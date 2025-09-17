const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    email: {
        required: true,
        type: String,
        trim: true,
        unique: true,
    },
    password: {
        required: true,
        type: String,
    },
    role: {
        type: String,
        enum: ['endUser', 'receiver'],
        default: 'endUser',
    },
});

const User = mongoose.model('User', userSchema);
module.exports = User;