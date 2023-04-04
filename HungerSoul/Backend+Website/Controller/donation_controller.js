const mongoose = require("mongoose");
const donationRequest = require('../models/donationRequest')
const QRdata = require('../models/QRdata')
const posts = require('../models/post')

var admin = require("firebase-admin");
var fcm = require("fcm-notification");
var serviceAccount = require("../config/push-notofication-key.json");
const certPath = admin.credential.cert(serviceAccount);

var FCM = new fcm(certPath);




exports.createdonation = (req,res,next)=>{
    //console.log(req.body)
    const now = new Date();
    const options = { timeZone: 'Asia/Kolkata', hour12: true, hour: '2-digit', minute: '2-digit' };
    const formattedTime = now.toLocaleTimeString('en-US', options);

     //      console.log(formattedTime);

    donation_request = new donationRequest.donation_request({
        donorname: req.body.donorName,
        donortoken: req.body.donortoken,
        phone:req.body.phoneNumber,
        address:req.body.address,
        email:req.body.email,
        food:req.body.food,
        quantity:req.body.quantity,
        bestbefore:req.body.bestbefore,
        selectedngo:req.body.selectedNGO,
        assigned:false,
        time_1: String(formattedTime),
        currentstep: 1,
    })
    
    donation_request.save().then(
        (result)=>{
            console.log('saved!!')
            res.status(201).json({
                message:"sucess!!",
            })
        }
    ).then(()=>{
        donationRequest.donation_request.find(
            {donortoken: req.body.donortoken}
        ).then((result)=>{
            console.log(result[0])
            let message = {
                notification:{
                    title: "Donation call made successfully.",
                    body: "We will notify you when volunteer accepts your request"
                },
                data:{
                    step:"1",
                    time_1: String(result[0].time_1),
                    donationid : String(result[0]._id),
                    //volunteername:req.body.volunteerName,
                    //orderid:"12345",
                    //date: "22/22/22"
                },
                token: req.body.donortoken,
            };
    
            FCM.send(message,function(err, response){
                if (err) {
                    console.log("Something has gone wrong!");
                } else {
                    console.log("Successfully sent with response: ", response);
                }
            }); 

        })
    }).catch(
        (err)=>{
            console.log(err);
        }
    )
}




exports.getdonationrequestlist = (req,res,next)=>{
    //console.log(req.body)
    donationRequest.donation_request.find({assigned:false}).then(
        (data)=>{
            //console.log(data);
            res.status(202).send({
                'data':data,
            });
        }
    ).catch(
        (err)=>{
            console.log(err)
        }
    ) 
    
}





exports.acceptdonationrequest = (req,res,next)=>{
    console.log(req.body)

    const now = new Date();
    const options = { timeZone: 'Asia/Kolkata', hour12: true, hour: '2-digit', minute: '2-digit' };
    const formattedTime = now.toLocaleTimeString('en-US', options);

    donationRequest.donation_request.find(
            {_id: req.body.donationRequestID}
        ).then((data)=>{
            //var token = data.donortoken;
            console.log(data[0].donortoken);
            
            let message = {
                notification:{
                    title: "Donation call accepted",
                    body: req.body.volunteerName + " is on its way"
                },
                data:{
                    donationid: String(req.body.donationRequestID),
                    step:"2",
                    time_1: String(data[0].time_1),
                    time_2: String(formattedTime),
                    volunteername:req.body.volunteerName,
                    //orderid:"12345",
                    //date: "22/22/22"
                },
                token: data[0].donortoken,
            };
    
            FCM.send(message,function(err, response){
                if (err) {
                    console.log("Something has gone wrong!");
                } else {
                    console.log("Successfully sent with response: ", response);
                }
            }); 

        }
    )
    donationRequest.donation_request.updateOne(
        {_id: req.body.donationRequestID },
        { volunteername:req.body.volunteerName,
        volunteerid: req.body.volunteerid,
        assigned:true ,
        currentstep:2,
        time_2: String(formattedTime)
    }).then(
            (data)=>{
                console.log('updated');
                res.status(203).json({
                data:"accepted",
            })
        }).catch((err)=>{
            console.log(err);
    
    });
    
}





exports.getqrdata = (req,res,next)=>{
    console.log(req.body)

    QRdata.QRdata.find({"QRid" :req.body.qr_id }).then((result)=>{
        if(result.length>0){
            if(result[0].currentstep== 0){
                result[0].currentstep=2;
            }
            res.status(200).json({
                data: result,
            })

        }else{
            res.status(201).json({
                    "notfound": "yes",
                })
                return;
            }
        }).catch((err)=>{
                console.log(err)
            })
}


exports.getdonationdetailforqr = (req,res,next)=>{
    //console.log(req.body)
    donationRequest.donation_request.find({_id :req.body._id }).then((result)=>{
                //console.log(result)
                res.status(200).json({
                    data: result,
                })
            }).catch((err)=>{
                console.log(err)
            })
}



exports.updateQRstep_3 = (req,res,next)=>{

    const now = new Date();
    const options = { timeZone: 'Asia/Kolkata', hour12: true, hour: '2-digit', minute: '2-digit' };
    const formattedTime = now.toLocaleTimeString('en-US', options);

    console.log(req.body)
    donationRequest.donation_request.find({_id :req.body.donationid }).then((result)=>{
        console.log(result[0])
        QRdata.QRdata.updateOne({"QRid" :req.body.qr_id },
        {
            donationid: req.body.donationid,
            donorname:  result[0].donorname,
            donortoken: result[0].donortoken,
            phone: result[0].phone,
            email: result[0].email,
            address: result[0].address,
            food: result[0].food,
            quantity: result[0].quantity,
            bestbefore: result[0].bestbefore,
            donationdesc:result[0].donationdesc,
            selectedngo:result[0].selectedngo,
            volunteername:result[0].volunteername,
            volunteerid:result[0].volunteerid,
            assigned:result[0].assigned,
            currentstep:3,
            time_1: result[0].time_1,
            time_2:result[0].time_2,
            time_3: String(formattedTime)
        }).then((update)=>{
            console.log(update.modifiedCount)
            let message = {
                notification:{
                    title: "Donation Picked up",
                    body: result[0].volunteername + " picked your donation and is on the way to NGO"
                },
                data:{
                    donationid: String(result[0]._id),
                    step:"3",
                    time_1: String(result[0].time_1),
                    time_2: String(result[0].time_2),
                    time_3: String(formattedTime),
                    volunteername: String(result[0].volunteername),
                    //orderid:"12345",
                    //date: "22/22/22"
                },
                token: result[0].donortoken,
            };
    
            FCM.send(message,function(err, response){
                if (err) {
                    console.log("Something has gone wrong!");
                } else {
                    console.log("Successfully sent with response: ", response);
                }
            }); 
    
            res.status(200).json({
                message: "success",
            })
    

        }).catch(err=>{
            console.log(err);
        });
        // donation id se sara data qr id mai transfer
        // current step ko 3
      // donor ko notification aur uska tracking update
    }).catch(err=>{
        console.log(err)
    })
}



exports.NGOreachupdate = (req,res,next)=>{

    const now = new Date();
    const options = { timeZone: 'Asia/Kolkata', hour12: true, hour: '2-digit', minute: '2-digit' };
    const formattedTime = now.toLocaleTimeString('en-US', options);

    console.log(req.body)
    QRdata.QRdata.updateOne({'QRid' :req.body.QRid },
        {'NGOvolname':req.body.NGOvolname,
          'NGOvolid':req.body.NGOvolid,
          'currentstep':4,
           'time_4': String(formattedTime)}).then(
            (result)=>{
                console.log(result)
                QRdata.QRdata.find({'QRid' :req.body.QRid}).then(data=>{
                    console.log(data);

                    let message = {
                        notification:{
                            title: "Donation Received by "+data[0].selectedngo,
                            body: data[0].NGOvolname + " collected your donation"
                        },
                        data:{
                            donationid: String(data[0].donationid),
                            step:"4",
                            time_1: String(data[0].time_1),
                            time_2: String(data[0].time_2),
                            time_3: String(data[0].time_3),
                            time_4: String(formattedTime),
                            volunteername: String(data[0].volunteername),
                            NGOvolname: String(data[0].NGOvolname),
                            selectedNGO:String(data[0].selectedngo)
                            //orderid:"12345",
                            //date: "22/22/22"
                        },
                        token: data[0].donortoken,
                    };
            
                    FCM.send(message,function(err, response){
                        if (err) {
                            console.log("Something has gone wrong!");
                        } else {
                            console.log("Successfully sent with response: ", response);
                        }
                    }); 
                    
                    res.status(200).json({
                        data: 'Updated',
                    })

                }).catch((err)=>{
                    console.log(err)
                })
                
            }).catch((err)=>{
                console.log(err)
            })
}


exports.dispatched = (req,res,next)=>{
    const now = new Date();
    const options = { timeZone: 'Asia/Kolkata', hour12: true, hour: '2-digit', minute: '2-digit' };
    const formattedTime = now.toLocaleTimeString('en-US', options);

    console.log(req.body)
    QRdata.QRdata.updateOne({'QRid' :req.body.QRid },
        {'DISvolname':req.body.DISvolname,
          'DISvolid':req.body.DISvolid,
          'location_to_be':req.body.location_to_be,
          'time_5':String(formattedTime),
          'currentstep':5}).then(
            (result)=>{
                console.log(result)
                QRdata.QRdata.find({'QRid' :req.body.QRid}).then(data=>{
                    console.log(data);

                    let message = {
                        notification:{
                            title: "Your Donation is dispatched to be distributed to needy one",
                            body: data[0].DISvolname + " is taking your food to distribute"
                        },
                        data:{
                            donationid: String(data[0].donationid),
                            step:"5",
                            time_1: String(data[0].time_1),
                            time_2: String(data[0].time_2),
                            time_3: String(data[0].time_3),
                            time_4: String(data[0].time_4),
                            time_5: String(formattedTime),
                            volunteername: String(data[0].volunteername),
                            NGOvolname: String(data[0].NGOvolname),
                            selectedNGO:String(data[0].selectedngo),
                            DISvolname:String(data[0].DISvolname),
                            location_to_be:String(data[0].location_to_be),
                            //orderid:"12345",
                            //date: "22/22/22"
                        },
                        token: data[0].donortoken,
                    };
            
                    FCM.send(message,function(err, response){
                        if (err) {
                            console.log("Something has gone wrong!");
                        } else {
                            console.log("Successfully sent with response: ", response);
                        }
                    }); 
                    
                    res.status(200).json({
                        data: 'Updated',
                    })

                }).catch((err)=>{
                    console.log(err)
                })
                
            }).catch((err)=>{
                console.log(err)
            })
}



exports.donated = (req,res,next)=>{
    const now = new Date();
    const options = { timeZone: 'Asia/Kolkata', hour12: true, hour: '2-digit', minute: '2-digit' };
    const formattedTime = now.toLocaleTimeString('en-US', options);

    console.log(req.body)
    QRdata.QRdata.updateOne({'QRid' :req.body.QRid },
        {'area':req.body.area,
          'receiver_gender':req.body.gender,
          'receiver_isSuffering':req.body.isSuffering,
          'message':req.body.message,
          'completed':true,
          'time_6': String(formattedTime)}).then(
            (result)=>{
                console.log(result)
                QRdata.QRdata.find({'QRid' :req.body.QRid}).then(data=>{
                    console.log(data);

                    let message = {
                        notification:{
                            title: "Your food is donated by NGO",
                            body: "Thank you!!!...See message from receiver"
                        },
                        data:{
                            donationid: String(data[0].donationid),
                            step:"6",
                            time_1: String(data[0].time_1),
                            time_2: String(data[0].time_2),
                            time_3: String(data[0].time_3),
                            time_4: String(data[0].time_4),
                            time_5: String(data[0].time_5),
                            time_6: String(formattedTime),

                            volunteername: String(data[0].volunteername),
                            NGOvolname: String(data[0].NGOvolname),
                            selectedNGO:String(data[0].selectedngo),
                            DISvolname:String(data[0].DISvolname),
                            location_to_be:String(data[0].location_to_be),

                            area:String(data[0].area),
                            gender:String(data[0].receiver_gender),
                            isSuffering:String(data[0].receiver_isSuffering),
                            message:String(data[0].message),


                            //orderid:"12345",
                            //date: "22/22/22"
                        },
                        token: data[0].donortoken,
                    };
            
                    FCM.send(message,function(err, response){
                        if (err) {
                            console.log("Something has gone wrong!");
                        } else {
                            console.log("Successfully sent with response: ", response);
                        }
                    }); 
                    
                    res.status(200).json({
                        data: 'Updated',
                    })

                }).catch((err)=>{
                    console.log(err)
                })
                
            }).catch((err)=>{
                console.log(err)
            })
}



exports.getacceptedrequestlist = (req,res,next)=>{
    console.log(req.body)
    donationRequest.donation_request.find({assigned:true,volunteerid:req.body.volunteerid}).then(
        (data)=>{
            console.log(data);
            res.status(202).send({
                'data':data,
            });
        }
    ).catch(
        (err)=>{
            console.log(err)
        }
    ) 
    
}



exports.getpost = (req,res,next)=>{
    //console.log(req.body)
    posts.post.find().then(
        (data)=>{
            console.log(data);
            res.status(202).send({
                'data':data,
            });
        }
    ).catch(
        (err)=>{
            console.log(err)
        }
    ) 
    
}



