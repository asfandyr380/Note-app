const express = require('express');
const route = express.Router();
const Todo = require('../models/todo');
const varify = require('./auth');


// Get All The Files From Database
route.get(`/`, varify, async (req, res) => {
    try {
        const userId = req.user._id; 
        const todo = await Todo.find();
        res.status(200).json(todo);
    } catch (err) { console.log(err) }
});

// Get User Data by Id
route.get('/:id', async (req,res) => {
    try{
        const id = req.params.id;
        const getTodo = await Todo.findOne({_id: id});
        res.status(200).json(getTodo);
    }
    catch(err){
        console.log(err);
    }
}); 


// Add a Todo Item in The Database
route.post('/', async (req, res) => {
    const postTodo = new Todo({
        todoname: req.body.todoname,
        description: req.body.description,
    });
    try {
        const saved = await postTodo.save();
        res.json(saved);
    } catch (err) { console.log(err) }

});


// Update Exitsting Todo
route.patch('/:removedId', async (req, res) => {
    try {
        const removeId = req.params.removedId;
        const update = req.body;
        const option = { new: true };
        const updateTodo = await Todo.findByIdAndUpdate(removeId, update, option);
        res.json(updateTodo);
    } catch (err) {
        console.log(err.message);
    }

});


// Delete the Todo item form Database
route.delete('/:todoId', async (req, res) => {
    try {
    const deleteid = req.params.todoId;
    const removetodo = await Todo.remove({ _id: deleteid });
        res.json(removetodo);
    } catch (err) { console.log(err) }
});


module.exports = route