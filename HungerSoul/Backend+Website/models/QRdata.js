const mongoose = require('mongoose');
const schema = mongoose.Schema;
const ProductSchema = new schema({
    QRid:{
        type: String,
        required:true
    },
    donationid: {
        type: String,
        required:false
    },
    donorname: {
        type: String,
        required:false
    },
    donortoken: {
        type: String,
        required:false
    },
    phone: {
        type: String,
        required:false
    },
    email: {
        type: String,
        required:false
    },
    address: {
        type: String,
        required:false
    },
    food: {
        type: String,
        required:false
    },
    quantity: {
        type: String,
        required:false
    },
    bestbefore: {
        type: String,
        required:false
    },
    donationdesc:{
        type: String,
        required:false
    },
    selectedngo:{
        type: String,
        required: false
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
        required:false
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
        required:false
    },
    NGOvolname:{
        type: String,
        required:false
    },
    NGOvolid:{
        type: String,
        required:false
    },
    DISvolname:{
        type: String,
        required:false
    },
    DISvolid:{
        type: String,
        required:false
    },
    location_to_be:{
        type: String,
        required:false
    },
    area:{
        type: String,
        required:false
    },
    receiver_gender:{
        type: String,
        required:false
    },
    receiver_isSuffering:{
        type: Boolean,
        required:false
    },
    message:{
        type: String,
        required:false
    },
    completed:{
        type:Boolean,
        required:false
    }
    
})

exports.QRdata = mongoose.model('QRdata',ProductSchema);  //connect schema to name  here Service become collection name (services)
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

