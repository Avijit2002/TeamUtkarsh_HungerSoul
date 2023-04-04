const express = require('express');
const controller_admin = require('../Controller/admin');
const router = express.Router();

router.get('/dashboard',controller_admin.dashboard);

router.post('/dashboard',controller_admin.dashboard);  // for login

router.get('/dashboard/QRgenerator',controller_admin.QRgenerator);

router.get('/dashboard/feedpost',controller_admin.feedpost);

router.post('/dashboard/generateQR/qrgenerator',controller_admin.generateQR);

router.get('/dashboard/inventory',controller_admin.inventory);

router.post('/dashboard/feedpost/submit',controller_admin.postSubmit);



module.exports = router;