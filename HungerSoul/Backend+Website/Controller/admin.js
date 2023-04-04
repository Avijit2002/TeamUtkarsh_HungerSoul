const { response } = require("express");
const mongoose = require("mongoose");
const emergency_services_temp = require("../models/service").emergency_services_temp;
const emergency_services_perm = require("../models/service").emergency_services_perm;
const user = require("../models/user");
const QRdata = require('../models/QRdata');
const donation_request = require('../models/donationRequest');
const post = require('../models/post')



exports.dashboard = (req, res, next) => {
    emergency_services_perm.find().then(permservice => {
        emergency_services_temp.find().
            then(service => {
                res.render('../views/admin/dashboard.ejs', {
                    services: service,
                    permservices : permservice
                });
                console.log(service);
            }).catch(err => {
                console.log(err);
            })
    })
}

exports.QRgenerator = (req,res,next)=>{
    res.render('../views/admin/QRgenerator.ejs');
}

exports.feedpost = (req,res,next)=>{
    res.render('../views/admin/Post.ejs');
}

exports.inventory = (req,res,next)=>{
    QRdata.QRdata.find({currentstep:4}).then((data)=>{
        console.log(data);
        res.render('../views/admin/inventory.ejs',{
            food: data,
        });
        
    })
    
}




exports.dashboard = (req, res, next) => {
    donation_request.donation_request.find({currentstep:1}).then(data => {
                res.render('../views/admin/dashboard.ejs', {
                    food: data,
                });
                //console.log(service);
            }).catch(err => {
                console.log(err);
            })


}

exports.generateQR = (req,res,next)=>{
    console.log(req.body)
    q = new QRdata.QRdata({
        QRid: String(req.body.QRidGene),
        currentstep: 0,
    })
    
    q.save().then(
        (result)=>{
            console.log('saved!!')
            res.json({
                message:"sucess!!",
            })
        }).catch(e=>{
            console.log(e)
        })
}


exports.postSubmit = (req,res,next)=>{
    console.log(req.body);
    const posts = new post.post({
        title: req.body.title,
        author: req.body.author,
        content: req.body.content,
    });
    posts.save()
    .then(result=>{
        console.log('data saved');
        res.redirect('/admin/dashboard/feedpost');
    }).catch(err=>{
        console.log(err)
    })
    //console.log(emergency_service);
    
}

 
