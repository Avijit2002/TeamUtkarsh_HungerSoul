const express = require('express');
const mongoose = require('mongoose');
const path = require('path');
const bodyParser = require('body-parser');
const donation_routes = require('./routes/donation_routes');
const notification_routes = require('./routes/notification_routes');

const home_routes = require('./routes/home_routes');
const admin_routes = require('./routes/admin_routes');

const app = express();

app.set('view engine', 'ejs');
app.set('views', 'views');


app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());



app.use((req,res,next)=>{
    res.setHeader('Access-Control-Allow-Origin','*');
    res.setHeader('Access-Control-Allow-Methods','OPTION,GET,POST,PUT,PATCH,DELETE');
    res.setHeader('Access-Control-Allow-Headers','content-type,Authorization');
    next();
})

app.use('/donation',donation_routes);
app.use('/notification',notification_routes);

app.use(home_routes);
app.use('/admin',admin_routes);

app.use(express.static(path.join(__dirname, 'public'))); 



mongoose.connect('mongodb+srv://avi2002:s6DFXZuvTmxtLfnX@cluster0.6256vva.mongodb.net/test?retryWrites=true')
.then(result=>{
    app.listen(8080);
    console.log('connected to DB');
}).catch(err=>{
    console.log(err);
})
