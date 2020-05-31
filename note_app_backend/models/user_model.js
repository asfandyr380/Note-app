const mongoose = require('mongoose');

const userschema = mongoose.Schema({
    username: {
        type: String,
        min: 4,
        max: 255
    },
    email: {
        type: String,
        min: 6,
        max: 255
    },
    password: {
        type: String,
        min: 6,
        max: 255
    }
});

module.exports = mongoose.model('user', userschema);