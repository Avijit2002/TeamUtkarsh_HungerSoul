const mongoose = require('mongoose');
const schema = mongoose.Schema;
const ProductSchema = new schema({
    donorname: {
        type: String,
        required:true
    },
    donortoken: {
        type: String,
        required:true
    },
    phone: {
        type: String,
        required:true
    },
    email: {
        type: String,
        required:true
    },
    address: {
        type: String,
        required:true
    },
    food: {
        type: String,
        required:true
    },
    quantity: {
        type: String,
        required:true
    },
    bestbefore: {
        type: String,
        required:true
    },
    donationdesc:{
        type: String,
        required:false
    },
    selectedngo:{
        type: String,
        required: true
    },
    volunteername:{
        type: String,
        required:false
    },
    volunteerid:{
        type: String,
        required:false
    },
    assigned:{
        type: Boolean,
        required:true
    },
    time_1:{
        type: String,
        required:false
    },
    time_2:{
        type: String,
        required:false
    },
    time_3:{
        type: String,
        required:false
    },
    time_4:{
        type: String,
        required:false
    },
    time_5:{
        type: String,
        required:false
    },
    time_6:{
        type: String,
        required:false
    },
    currentstep:{
        type: Number,
        required:true
    }
    
})

exports.donation_request = mongoose.model('donation_request',ProductSchema);  //connect schema to name  here Service become collection name (services)
//exports.emergency_services_perm = mongoose.model('emergency_services_perm',ProductSchema);
  

// module.exports = class Service{
//     constructor(service, name,address,state,city,zip,phone,email){
//         this.service = service;
//         this.name = name;
//         this.address = address;
//         this.state = state;
//         this.city = city;
//         this.zip= zip;
//         this.phone=phone;
//         this.email=email;
//     }
// }

