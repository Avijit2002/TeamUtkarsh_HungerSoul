const mongoose = require('mongoose');
const schema = mongoose.Schema;

const UserSchema =new schema({
    Name:{
        type:String,
        require:true
    },  
    Password:{
        type:String,
        require:true  
    },
    EmergencyContactNumber:{
        type:String,
        require:true
    },
    VehicleNumber:{
        type:String,
        require:true
    },
    VehicleRegistrationId:{
        type:String,
        require:true
    },
    EmailAddress:{
        type:String,
        require:true
    },
    ContactNumber:{
        type:String,
        require:true
    },
    Address:{
        type:String,
        require:true
    },
    GovernmentId:{
        type:String,
        require:true
    }
})

module.exports = mongoose.model('user',UserSchema);
