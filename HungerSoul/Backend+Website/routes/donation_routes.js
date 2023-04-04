const express = require('express');

const controller = require('../Controller/donation_controller')

const router = express.Router();



// router.get('/getPost',controller.getPost);

// Donor UI
router.post('/createdonation',controller.createdonation);


// Volunteer UI
router.get('/getdonationrequestlist',controller.getdonationrequestlist);

router.post('/acceptrequest',controller.acceptdonationrequest);

router.post('/getqrdata',controller.getqrdata);

router.post('/getdonationdetailforqr',controller.getdonationdetailforqr)

router.post('/updateQRstep_3',controller.updateQRstep_3)

router.post('/NGOreachupdate',controller.NGOreachupdate)

router.post('/dispatched',controller.dispatched)

router.post('/donated',controller.donated)

router.post('/getacceptedrequestlist',controller.getacceptedrequestlist)

router.get('/getpost',controller.getpost);








module.exports=router;