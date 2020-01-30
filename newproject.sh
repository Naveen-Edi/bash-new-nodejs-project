#!/bin/bash

mkdir sample-node 
cd sample-node
npm init -y

mkdir config
mkdir core
mkdir core/cron
mkdir core/packages
mkdir core/push
mkdir core/socket

mkdir db
mkdir db/models
mkdir db/seeds

mkdir routes
mkdir routes/controllers
mkdir routes/helpers
mkdir routes/middlewares

mkdir templates
mkdir utils

npm i dotenv --save
npm i mongoose --save

npm i crypto --save
npm i nodemailer --save
npm i fs --save
npm i @sendgrid/mail --save
npm i jsonwebtoken --save
npm i redis --save

npm i express --save
npm i cors --save
npm i helmet --save
npm i body-parser --save
npm i express-ip --save
npm i express-useragent --save
npm i express-mongo-sanitize --save
npm i hpp --save
npm i express-rate-limit --save
npm i ddos --save
npm i cookie-parser --save
npm i express-session --save
npm i randomstring --save
npm i bcryptjs --save
npm i qrcode --save
npm i speakeasy --save
npm i node-input-validator --save
npm i apn --save
npm i fcm-node --save
npm i path --save
npm i socket.io-client --save
npm i socket.io --save
npm i request --save


# npm i binance-api-node --save
# npm i bitfinex-api-node --save
# npm i node-bitstamp --save
# npm i bittrex-node --save
# npm i exmo-api --save
# npm i hitbtc-node-sdk --save
# npm i kraken-api --save
# npm i @okfe/okex-node --save
# npm i poloniex-api-node --save
# npm i kucoin-node-api --save
# npm i cexio-api-node --save


echo "PORT= 3000
socket_port= 4000
db_url= mongodb://localhost:27017/payment
session_secret= qwerty
jwt_secret= qwerty
admin_jwt_secret= qwerty
support_email= support@demo.com
support_password= demo@2019
admin_email= admin@demo.com
admin_password= 123456
email_verify_url= 
device_verify_url= 
email_images= 
home_url= 
reset_password_url= 
crypto_pass= 
coinpayment_key= 
coinpayment_secret= 
mysql_username= 
mysql_password= 
sendgrid_api_key=
verify_email_template=
forgot_password_template=
authorize_device_template=
custom_mail_template=
from_email=
session_expiry=86400000" >> .env


echo "const mongoose = require('mongoose');
const options = { useNewUrlParser: true, useCreateIndex: true, useUnifiedTopology: true };

// Mongodb connection
mongoose.connect(process.env.db_url, options);

// Mongodb connection success
mongoose.connection.on('connected', function() {
  console.log('Mongoose connection is open ');
});

// Mongodb connection error
mongoose.connection.on('error', function(err) {
  console.log('Mongoose connection has occured ' + err + ' error');
});

// Mongodb connection disconnected
mongoose.connection.on('disconnected', function() {
  console.log('Mongoose connection is disconnected');
});
">> config/connection.js

echo "require('dotenv').config();
require('./config/connection');

const app = require('./routes/route');
const port = process.env.PORT || 3000;



app.listen(port, () => {
  console.log('App listening on port 3000!');
});" >> app.js

echo "const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(process.env.sendgrid_api_key);

let sendMail = async function(email_array, template_id, replacements) {
  try {

    const msg = {
      to: email_array,
      from: process.env.from_email,
      templateId: template_id,
      dynamic_template_data: replacements,
    };

    let response = await sgMail.send(msg);
    if (response) {
      return true;
    } else {
      return false;
    }
  } catch (err) {
    return false;
  }
};

module.exports = {
  sendMail,
};" >> utils/sendgrid.js


echo "const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const app = express();
const bodyParser = require('body-parser');
const expressip = require('express-ip');
const useragent = require('express-useragent');
const mongoSanitize = require('express-mongo-sanitize');
const hpp = require('hpp');


const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 1 * 60 * 1000, // 1 minutes
  max: 500, // limit each IP to 500 requests per windowMs
});

app.use(limiter);

var Ddos = require('ddos');
var ddos = new Ddos({ 
	burst: 10, 
	limit: 24 ,
	testmode : false
})

app.use(ddos.express);


app.use(cors());

app.use(helmet());

app.use(helmet.hidePoweredBy({ setTo: 'PHP 4.2.0' }));

app.use(useragent.express());

app.use(bodyParser.json({ limit: '10mb' }));
app.use(bodyParser.urlencoded({ extended: true, limit: '10mb' }));

app.use(hpp()); 
// To remove data, use:
app.use(mongoSanitize());
// Or, to replace prohibited characters with _, use:
app.use(mongoSanitize({
    replaceWith: '_'
}))

app.use(expressip().getIpInfoMiddleware);


var cookieParser = require('cookie-parser');
var session = require('express-session');

app.set('trust proxy', 1) // trust first proxy

app.use(cookieParser());
app.use(session({
  secret: 'WX3CV5FNuZE1vwCJ2tCIww',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false },
}));

//* ***************** U S E R ***************

// User Auth Api



//* ***************** A D M I N ***************

// Admin Auth Api



//* ***************** M E R C H E N T ***************


module.exports = app;
" >> routes/route.js