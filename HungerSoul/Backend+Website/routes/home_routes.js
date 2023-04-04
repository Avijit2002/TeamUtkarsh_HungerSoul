const express = require('express');
const controller_home = require('../Controller/home');
const router = express.Router();

router.get('/',controller_home.home);

router.get('/register',controller_home.register);

router.get('/login',controller_home.login);

router.post('/register-submit',controller_home.register_submit);



module.exports = router;