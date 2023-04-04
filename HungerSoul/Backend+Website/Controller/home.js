const emergency_services_temp = require("../models/service").emergency_services_temp;

exports.home = (req,res,next)=>{
    res.render('../views/home.ejs');
}


exports.register = (req,res,next)=>{
    res.render('../views/registerForm.ejs');
}

exports.login = (req,res,next)=>{
    res.render('../views/login.ejs');
}

exports.register_submit = (req,res,next)=>{
    console.log(req.body);
    const service = req.body.service;
    const name = req.body.name;
    const address = req.body.address;
    const state = req.body.state;
    const city = req.body.city;
    const zip = req.body.zip;
    const phone = req.body.phone;
    const email = req.body.email;
    const emergency_service = new emergency_services_temp({
        service : service,
        name:name,
        address:address,
        state:state,
        city:city,
        zip:zip,
        phone:phone,
        email:email
    });
    emergency_service.save()
    .then(result=>{
        console.log('data saved');
        res.redirect('/');
    }).catch(err=>{
        console.log(err)
    })
    //console.log(emergency_service);
    
}
