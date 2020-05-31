const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const router = express.Router();
const user = require('../models/user_model');
require('dotenv').config();





router.post('/register', async (req, res) => {

    // Check if email already Exits
    const emailExits = await user.findOne({ email: req.body.email });
    if(emailExits) return res.status(400).send('Email already exits');

    //Hash the Password
    const salt = await bcrypt.genSalt(11);
    const hashedPass = await bcrypt.hash(req.body.password, salt);


    // Create new User
    const users = new user({
        username: req.body.username,
        email: req.body.email,
        password: hashedPass
    });
    try{
        // Save the New User
        const savedUser = await users.save();
        res.send(savedUser);
    }catch(err) {
        res.status(400).json({
            msg: err
        });
    }
});


router.post('/login', async (req,res) => {

    // Check if email already Exits
    const userexit = await user.findOne({ email: req.body.email });
    if(!userexit) return res.status(400).send('Email Does not Exits');

    // Check if password is valid or not
    const validpass = await  bcrypt.compare(req.body.password, userexit.password);
    if(!validpass) return res.status(400).send('Password is Wrong');

    // Create and Assign a Token
    const token = jwt.sign({_id: userexit._id}, process.env.TOKEN);
    res.header('auth_token', token).json({
        'authtoken': token,
    });


    res.send('login Success');
});



module.exports = router;