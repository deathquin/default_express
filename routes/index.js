const express = require('express');
const router = express.Router();
const ip = require("ip");

/* GET home page. */
router.get('/', function(req, res, next) {
  res.writeHead(200, {
    'Content-Type': 'text/plain'
  });

  const ips = ip.address();

  res.write('OK12345 '+ips);
  res.end();
  /*res.render('index', { title: 'Express' });*/
});

router.get("/health", async function(req, res){
  res.writeHead(200, {
    'Content-Type': 'text/plain'
  });

  const ips = ip.address();

  res.write('OK12 ' + ips);
  res.end();
});

/*res.writeHead(200, {
  'Content-Type': 'text/plain',
  'Content-Length': 2
});*/

module.exports = router;
