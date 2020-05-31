const mongoose = require('mongoose');

const todoSchema = mongoose.Schema({
    todoname: 
    {
        type: String,
        require: true
    },
    description: { type: String },
    date: 
    {
        type: Date,
        default: Date.now
    }
});


module.exports = mongoose.model('todo', todoSchema);