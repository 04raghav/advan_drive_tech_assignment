const jwt = require('jsonwebtoken');
const User = require('../models/user');

const auth = async (req, res, next) => {
    try {
        // Use a consistent secret key
        const JWT_SECRET = 'your-secret-key-for-jwt-that-is-long'; 
        const token = req.header('x-auth-token');

        if (!token) {
            return res.status(401).json({ msg: 'No auth token, access denied' });
        }

        const verified = jwt.verify(token, JWT_SECRET);
        if (!verified) {
            return res.status(401).json({ msg: 'Token verification failed, authorization denied' });
        }

        // Attach the full user document to the request object
        req.user = await User.findById(verified.id);
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
};

module.exports = auth;