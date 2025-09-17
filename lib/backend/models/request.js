const mongoose = require('mongoose');

const itemSchema = new mongoose.Schema({
    name: { type: String, required: true },
});

const requestSchema = new mongoose.Schema({
    fromUser: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    items: [itemSchema],
    status: {
        type: String,
        enum: ['pending', 'confirmed', 'partiallyFulfilled'],
        default: 'pending',
    },
    createdAt: { type: Date, default: Date.now },
    parentRequestId: { type: mongoose.Schema.Types.ObjectId, ref: 'Request', default: null },
});

const Request = mongoose.model('Request', requestSchema);
module.exports = Request;