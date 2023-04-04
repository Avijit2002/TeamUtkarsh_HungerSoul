const mongoose = require('mongoose');
const schema = mongoose.Schema;
const ProductSchema = new schema({
    title:{
        type: String,
        required:true
    },
    content: {
        type: String,
        required:false
    },
    author: {
        type: String,
        required:false
    },
    
})

exports.post = mongoose.model('post',ProductSchema);  //connect schema to name  here Service become collection name (services)
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

