// var admin = require("firebase-admin");
// var fcm = require("fcm-notification");
// var serviceAccount = require("../config/push-notofication-key.json");
// const certPath = admin.credential.cert(serviceAccount);

// var FCM = new fcm(certPath);

// exports.sendPushNotification = (req,res,next)=>{
//         let message = {
//             notification:{
//                 title: "Test Notification",
//                 body:"Motification Message"
//             },
//             data:{
//                 orderid:"12345",
//                 date: "22/22/22"
//             },
//             token: req.body.fcm_token,
//         };

//         FCM.send(message,function(err, response){
//             if (err) {
//                 console.log("Something has gone wrong!");
//             } else {
//                 console.log("Successfully sent with response: ", response);
//             }
//         }); 
//     }