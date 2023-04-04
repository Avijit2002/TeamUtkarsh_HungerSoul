const mongoose = require('mongoose');
const schema = mongoose.Schema;
const ProductSchema = new schema({
    service: {
        type: String,
        required:true
    },
    name: {
        type: String,
        required:true
    },
    address: {
        type: String,
        required:true
    },
    state: {
        type: String,
        required:true
    },
    city: {
        type: String,
        required:true
    },
    zip: {
        type: Number,
        required:true
    },
    phone: {
        type: Number,
        required:true
    },
    email: {
        type: String,
        required:true
    },
})

exports.emergency_services_temp = mongoose.model('emergency_services_temp',ProductSchema);  //connect schema to name  here Service become collection name (services)
exports.emergency_services_perm = mongoose.model('emergency_services_perm',ProductSchema);
  

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

