const express = require('express');
const auth = require('../middleware/auth');
const Request = require('../models/request');

const requestRouter = express.Router();

requestRouter.post('/requests', auth, async (req, res) => {
    try {
        if (req.user.role !== 'endUser') {
            return res.status(403).json({ msg: "Access denied" });
        }
        const { items } = req.body;
        let request = new Request({
            fromUser: req.user._id,
            items: items.map(item => ({ name: item.name })),
            status: 'pending',
            parentRequestId: null,
        });
        request = await request.save();
        res.status(201).json(request);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

requestRouter.get('/requests', auth, async (req, res) => {
    try {
        let requests;
        if (req.user.role === 'endUser') {
            requests = await Request.find({ 
                fromUser: req.user._id,
                parentRequestId: null
            }).sort({ createdAt: -1 });
        } else {
            requests = await Request.find({ 
                status: 'pending' 
            }).sort({ createdAt: -1 });
        }
        res.json(requests);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

requestRouter.post('/requests/:id/confirm', auth, async (req, res) => {
    try {
        if (req.user.role !== 'receiver') {
            return res.status(403).json({ msg: "Access denied" });
        }

        const { confirmedItems } = req.body;
        const currentRequest = await Request.findById(req.params.id);
        if (!currentRequest) {
            return res.status(404).json({ msg: 'Request not found' });
        }

        const unconfirmedItems = currentRequest.items.filter(item => !confirmedItems.includes(item.name));

        if (unconfirmedItems.length === 0) {
            currentRequest.status = 'confirmed';
            await currentRequest.save();

            if (currentRequest.parentRequestId) {
                const pendingSiblings = await Request.find({ 
                    parentRequestId: currentRequest.parentRequestId,
                    status: 'pending' 
                });
                
                if (pendingSiblings.length === 0) {
                    await Request.findByIdAndUpdate(currentRequest.parentRequestId, { status: 'confirmed' });
                }
            }

            res.json({ status: 'confirmed', updatedRequest: currentRequest });
        } else {
            const parentId = currentRequest.parentRequestId || currentRequest._id;

            await Request.findByIdAndUpdate(parentId, { status: 'partiallyFulfilled' });
            
            let reassignedRequest = new Request({
                fromUser: currentRequest.fromUser,
                items: unconfirmedItems,
                status: 'pending',
                parentRequestId: parentId,
            });
            reassignedRequest = await reassignedRequest.save();

            res.json({
                status: 'partiallyFulfilled',
                reassignedRequest: reassignedRequest
            });
        }
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = requestRouter;