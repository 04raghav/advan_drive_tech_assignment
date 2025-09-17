const express = require('express');
const mongoose = require('mongoose');

// Import routers
const authRouter = require('./routes/auth');
const requestRouter = require('./routes/request');


const PORT = 9000;

const app = express();
const DB = 'YOUR_DB_CONNECTION_STRING';

// Middleware
app.use(express.json());

// Use Routers
app.use('/api', authRouter);
app.use('/api', requestRouter);

mongoose.connect(DB).then(()=>{console.log("connection successful")}).catch((e)=>{console.log(e);});

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected at ${PORT}`)
})

