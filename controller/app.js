const express = require('express')
const app = express()
const fs = require('fs')
const DB = require('../data/dataAccess.js')
const VerifyToken = require('../auth/verifyToken')
const cors = require('cors')
var bodyParser = require('body-parser');
var urlencodedParser = bodyParser.urlencoded({ extended: false });
app.use(bodyParser.json()); //parse appilcation/json data
app.use(urlencodedParser); //Check insert user.
app.use(cors());
const multer = require('multer');
var storage = multer.diskStorage({/* need to install multer*///do seperate files for listings/pfp
  destination: function (req, file, cb) {
    cb(null, 'uploads/')//Storage area
  },
  filename: function (req, file, cb) {/*cb == callback*/
    cb(null, Date.now()+'')//Appending .jpg
  }
})
var upload = multer({
  storage: storage,
})
var myLogger = function (req, res, next) {//fires everytime get app is called

  next()
}

app.use(myLogger)

//Image Upload
app.get('/Upload/', function (req, res) {
  fs.createReadStream("./controller/Upload.html").pipe(res)
})
app.post('/upload/', upload.single('photo')/*this part uploads it*/, function (req, res) {//integrate this with postListing+postUser
  console.log(req)
  if (req.err) {
    res.end(req.err)
    req.err = null;
    return null
  }
  console.log('Uploading..')
  PFPTimeStamp = req.file.filename.replace(".jpg", "")
  res.send(PFPTimeStamp)
  console.log(PFPTimeStamp)
  // DB.FastImageChange(req.body.userid, PFPTimeStamp, function (req, res) {//finish this, parse in decoded.userid with jwt
  //   if (err) {
  //     res.send(PFPTimeStamp)
  //   } else {

  //   }
  // })
})
//verify token

app.post('/decodeToken/', VerifyToken, function (req, res) {//decodes token
  res.json({ username: req.username, password: req.password, user_id: req.user_id })
})
app.post('/postlogin', function (req, res) {//login page sends data here
  console.log(req.body)
  console.log(req.body.remember_me)
  console.log(req.body.username)
  console.log(req.body.password)
  DB.loginUser(
    req.body.username,
    req.body.password,
    function (err, result) {
      if (!err) {
        req.headers.authorization = 'Bearer ' + result
        console.log(req.headers)
        res.json({
          success: true,
          message: 'Authentication successful!',
          token: result
        });
      } else {
        if (err.error == 'Invalid credentials') {
          console.log(err);
          res.status(401).send(`Not Authorized`);
        } else {
          console.log('Internal Server Error')
          res.status(500).send(`Internal Server Error`);
        }
      }
    })
})
// use username once logged in


app.get('/users/PFP/:userid/', function (req, res) {
  var userid = req.params.userid;
  console.log(userid)
  DB.getPFP(userid, function (err, result) {
    if (err) {
      res.status(500).send("Internal Server Error")
      console.log(err)
    } else {
      console.log(result)
      var route = result[0].PFPID//to get around RowPacketData,uses default constructor
      fs.createReadStream('./uploads/' + route).pipe(res);
    }
  })
});

app.get('/listings/photo/:id/', function (req, res) {
  var id = req.params.id;
  console.log(id)
  DB.getListingPhoto(id, function (err, result) {
    if (err) {
      res.status(500).send("Internal Server Error")
      console.log(err)
    } else {
      console.log(result)
      var route = result[0].photo//to get around RowPacketData,uses default constructor
      fs.createReadStream('./uploads/' + route).pipe(res);
    }
  })
});

app.get('/users/', VerifyToken, function (req, res) {//Endpoint 1
  DB.getUsers(function (err, result) {
    if (!err) {
      res.send(result);
    }
    else {
      console.log(err);
      res.status(500).send(`Internal Server Error`);
    }
  })
})
var UploadErrorHandling = upload.single('photo');
app.post('/users/', function (req, res) {//Endpoint 2//
  UploadErrorHandling(req, res, function (err) {
    console.log(err)
    if (err !== undefined) {
      if (err.message == 'Wrong File Type') {
        return res.status(415).send('wrongFileType')//if file is not jpg
      } else {
        if (err.message == 'File too large') {
          return res.status(413).send('FileTooLarge')//if file is above > 1MB
        }
      }
    }
    if (!req.file) {//if no image
      return res.status(410).send('ImageNotSent')//if no image
    }
    console.log(req.body.username)
    DB.postUsers(
      (Date.now() / 1000),
      req.body.username,
      req.body.password,
      req.file.filename,
      function (err, result, UID) {
        if (!err) {
          res.send(UID[0])
          res.status(201)
        } else {
          console.log(err)
          res.status(500).send('Internal Server Error')
        }
      })

  })
})


app.get('/Pic/:route', function (req, res) {
  fs.createReadStream('./uploads/' + req.params.route).pipe(res);
})
app.get('/users/:userid/', function (req, res) {//Endpoint 3
  var userid = req.params.userid;
  console.log(userid)
  DB.getUser(userid, function (err, result) {
    if (err) {
      console.log(err)
      res.status(500).send("Internal Server Error")
    } else {
      console.log(result)
      res.send(result)
      res.status(200)
    }
  })
})

app.put('/users/:userid/', function (req, res) {//Endpoint 4
  UploadErrorHandling(req, res, function (err) {
    if (err !== undefined) {
      if (err.message == 'Wrong File Type') {
        return res.status(415).send('wrongFileType')//if file is not jpg
      } else {
        if (err.message == 'File too large') {
          return res.status(413).send('FileTooLarge')//if file is above > 1MB
        }
      }
    }
    if (req.file) {//if no image
      var userid = req.params.userid
      var username = req.body.username
      var PFPID = req.file.filename
      var password = req.body.password
      var UNSame = req.body.UNSame
      DB.putUser(password, username, userid, PFPID, UNSame, function (err, results, SUser) {
        if (err) {
          console.log(err)
          res.status(500).send('Internal Server Error')
        } else if (SUser == true) {
          console.log(SUser + " users")
          res.status(422).send('Unprocessable Entity')
        }
        else {
          res.status(204)
          res.end();
        }
      })
    } else {
      var userid = req.params.userid
      var username = req.body.username
      var PFPID = req.body.photo
      var password = req.body.password
      var UNSame = req.body.UNSame
      DB.putUser(password, username, userid, PFPID, UNSame, function (err, results, SUser) {
        if (err) {
          console.log(err)
          res.status(500).send('Internal Server Error')
        } else if (SUser == true) {
          console.log(SUser + " users")
          res.status(422).send('Unprocessable Entity')
        }
        else {
          res.status(204)
          res.end();
        }
      })
    }
  })
})


app.get('/users/:userid/listings', VerifyToken, function (req, res) {//Endpoint 5
  DB.getUserListings(
    req.params.userid,
    function (err, results) {
      if (err) {
        console.log(err)
        res.status(500).send('Internal Server Error')
      } else {
        res.status(200)
        res.send(results)
      }
    })
})

app.get('/listings/', function (req, res) {//Endpoint 6
  DB.getListings(function (err, results) {
    if (err) {
      console.log(err)
      res.status(500).send('Internal Server Error')
    } else {
      res.status(200)
      res.send(results)
    }
  })
})

/*app.get('/listingsO/:sort/:variable', function (req, res) {//Endpoint 6
  DB.getListingsOrder(
    req.params.sort,
    req.params.variable,
    function (err, results) {
    if (err) {
      console.log(err)
      res.status(500).send('Internal Server Error')
    } else {
      res.status(200)
      res.send(results)
      console.log(req.body.sort)
    }
  })
})*/

app.get('/listings/:id/', function (req, res) {//Endpoint 7
  DB.getListing(
    req.params.id,
    function (err, results) {
      if (err) {
        console.log(err)
        res.status(500).send('Internal Server Error')
      } else {
        res.status(200)
        res.send(results)
      }
    })
})

app.post('/listings/', VerifyToken, function (req, res) {//Endpoint 8
  UploadErrorHandling(req, res, function (err) {
    if (err !== undefined) {
      if (err.message == 'Wrong File Type') {
        return res.status(415).send('wrongFileType')//if file is not jpg
      } else {
        if (err.message == 'File too large') {
          return res.status(413).send('FileTooLarge')//if file is above > 1MB
        }
      }
    }
    if (!req.file) {//if no image  
      console.log('hey?')
      return res.status(410).send('ImageNotSent')
    } else {
      DB.postListing(
        (Date.now() / 1000),/* parse in date*/
        req.body.title,
        req.body.description,
        req.body.price,
        req.body.fk_user_id,
        req.file.filename,
        function (err, result, ID) {
          if (!err) {
            res.send(ID[0])
            res.status(201)
          } else {
            console.log(err)
            res.status(500).send('Internal Server Error')
          }
        })
    }
  })
})

app.delete('/listings/:id/', VerifyToken, function (req, res) {//Endpoint 
  DB.deleteListing(
    req.params.id,
    function (err, result) {
      if (err) {
        res.status(500).send('Internal Server Error')
      } else {
        res.status(204)
        console.log(req.params.id + ' Deleted')
        res.end();
      }
    }
  )
})
app.put('/listings/:id/', VerifyToken, function (req, res) {//Endpoint 10
  UploadErrorHandling(req, res, function (err) {
    if (err !== undefined) {
      if (err.message == 'Wrong File Type') {
        return res.status(415).send('wrongFileType')//if file is not jpg
      } else {
        if (err.message == 'File too large') {
          return res.status(413).send('FileTooLarge')//if file is above > 1MB
        }
      }
    }

    if (!req.file) {//if no image  
      console.log('hey?')
      DB.putListing(
        req.params.id,
        req.body.title,
        req.body.description,
        req.body.price,
        req.body.fk_user_id,
        req.body.photo,
        function (err, result) {
          if (err) {
            res.status(500).send('Internal Server Error')
            console.log(err)
          } else {
            res.status(204)
            res.end("hey");
          }
        }
      )
    } else {
      DB.putListing(
        req.params.id,
        req.body.title,
        req.body.description,
        req.body.price,
        req.body.fk_user_id,
        req.file.filename,
        function (err, result) {
          if (err) {
            res.status(500).send('Internal Server Error')
            console.log(err)
          } else {
            res.status(204)
            res.end("hey");
          }
        }
      )
    }

  })
})
app.get('/listings/:id/offers/', VerifyToken, function (req, res) {//Endpoint 11
  DB.getOffer(
    req.params.id,
    function (err, results) {
      if (err) {
        console.log(err)
        res.status(500).send('Internal Server Error')
      } else {
        res.status(200)
        res.send(results)
      }
    })
})
app.post('/listings/:id/offers/', VerifyToken, function (req, res) {//Endpoint 12
  DB.postOffer(
    (Date.now() / 1000),/* parse in date*/
    req.body.offer,
    req.body.fk_offeror_id,
    req.params.id,
    function (err, result, ID) {
      if (!err) {
        res.send(ID[0])
        res.status(201)
      } else {
        console.log(err)
        res.status(500).send('Internal Server Error')
      }
    })
})

app.get('/likes/', VerifyToken, function (req, res) {
  DB.getLikes(function (err, result) {
    if (!err) {
      res.send(result);
    } else {
      console.log(err);
      res.status(500).send(`Internal Server Error`);
    }
  })
})
app.get('/likes/user/:userid/', VerifyToken, function (req, res) {
  var userid = req.params.userid;
  console.log(userid)
  DB.getUserLikes(userid, function (err, result) {
    if (err) {
      console.log(err)
      res.status(500).send("Internal Server Error")
    } else {
      console.log(result)
      res.send(result)
      res.status(200)
    }
  })
})
app.get('/likes/listing/:id/', function (req, res) {
  var id = req.params.id;
  console.log(id)
  DB.getListingLikes(id, function (err, result) {
    if (err) {
      console.log(err)
      res.status(500).send("Internal Server Error")
    } else {
      console.log(result)
      res.send(result)
      res.status(200)
    }
  })
})
app.post('/like/:id', VerifyToken, function (req, res) {//login page sends data here
  DB.Like(
    req.username,
    req.params.id,
    function (err, result) {
      if (!err) {
        console.log("Liked")
        res.send(result)
        //console.log(result)
      } else {
        console.log(err);
        res.status(500).send(`Internal Server Error`);
      }
    })
})
app.post('/dislike/:id', VerifyToken, function (req, res) {//login page sends data here
  DB.Dislike(
    req.username,
    req.params.id,
    function (err, result) {
      if (!err) {
        console.log("Disliked")
        res.send(result)
        //console.log(result)
      } else {
        console.log(err);
        res.status(500).send(`Internal Server Error`);
      }
    })
})
//Error Handling
app.use(function (err, req, res, next) {
  if (err.code === 'LIMIT_FILE_SIZE') {
    res.end('File is over 1MB!')
    console.log('File is too large!')
  }
})
module.exports = app