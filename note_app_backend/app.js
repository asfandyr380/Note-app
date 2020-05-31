require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const app = express();
const bodyparser = require('body-parser');
const cors = require('cors');




// Connect to Mongo server
mongoose.connect(process.env.CONNECTION,{
    useFindAndModify: false,
    useNewUrlParser: true,
    useUnifiedTopology: true,
},
(err) => {
    if(err)
    {
     console.log(err);
    }
    console.log("Database Connected");
});


// Import Routes
const todos  = require('./routes/todos');
const users = require('./routes/users');


app.use(cors());
app.use(bodyparser.json());

//middleware
app.use('/todos', todos);
app.use('/users', users);



app.listen(3001);