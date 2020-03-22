const jwt = require('jsonwebtoken')

const config = process.env.JWTSECRETKEY

function verifyToken(req, res, next) {
    //console.log(req.headers)

    let token = req.headers['authorization'] //retrieve authorization header’s content
    console.log(token)
    if (!token || !token.includes('Bearer')) {
        //process the token
        //console.log(err)
        //console.log(token)
        res.status(401)//error is here
        return res.send({ auth: 'false', message: 'Not authenticated!' })
    } else {
        token = token.split('Bearer ')[1] //obtain the token’s value
        //console.log(token)
        jwt.verify(token/* taken from Bearer*/,config/* this is hashed*/, function(err, decoded) {
            //verify token  
            //console.log(token) 
            //console.log(config)
            if (err) {
                //console.log(err)
                //console.log(token)
                res.status(401)
                return res.send({ auth: false, message: 'Not authenticated!' })
            } else {
                console.log(decoded)
                req.password = decoded.password //decode the userid and store in req for use
                //console.log(config)
                req.user_id = decoded.user_id
                req.username = decoded.username
                //decode the role and store in req for use
                next()
            }
        })
    }
}

module.exports = verifyToken