const express = require('express');
const router = express.Router();
const ip = require("ip");

/* GET home page. */
router.get('/', function(req, res, next) {
  res.writeHead(200, {
    'Content-Type': 'text/plain'
  });

  const ips = ip.address();

  res.write('OK '+ips);
  res.end();
  /*res.render('index', { title: 'Express' });*/
});

router.get("/health", async function(req, res){
  res.writeHead(200, {
    'Content-Type': 'text/plain',
    'Content-Length': 2
  });

  const ips = ip.address();

  res.write('OK ' + ips);
  res.end();
});

module.exports = router;
