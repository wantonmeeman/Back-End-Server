var dbconnect = require("./databaseConfig")
var jwt = require('jsonwebtoken')
function Tcheck(c) {
    if (c) {
        return false
    }
    else {
        return true
    }
}
function SCheck(a, b) {
    var Arr = [];
    for (i = 0; i < a.length; i++) {
        Arr[i] = (a[i].username === b)
    }
    return Arr.every(Tcheck)
}
var DB = {
    loginUser(username, password, callback) {
        const conn = dbconnect.getConnection()
        conn.connect(function (err) {
            if (err) {
                callback(err, null)
                return
            }
            //check against database
            const sql = `SELECT username,password,user_id FROM users WHERE username = ? AND password = ?`
            conn.query(sql, [username, password], function (err, result) {
                if (err) {
                    callback({ error: err }, null)
                    return
                }
                if (result.length !== 1 || result[0].username !== username) {
                    callback({ error: 'Invalid credentials' }, null)
                    return
                }
                //let jwt hash the secret key
                let token = jwt.sign(
                    { password: result[0].password, username: result[0].username, user_id: result[0].user_id }, // payload or claims
                    process.env.JWTSECRETKEY, // secret key
                    {
                        expiresIn: 86400, //expires in 24 hrs
                    }
                )
                return callback(null, token)
            })
        })
    },
    getPFP: function (userid, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {//if error
                console.log(err);
                return callback(err, null);
            } else {
                console.log("Connected!");
                var sql = 'SELECT PFPID FROM users WHERE user_id = ?';
                conn.query(sql, [userid], function (err, result) {
                    conn.end()
                    console.log("con ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },
    getListingPhoto: function (id, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {//if error
                console.log(err);
                return callback(err, null);
            } else {
                console.log("Connected!");
                var sql = 'SELECT photo FROM listings WHERE id = ?';
                conn.query(sql, [id], function (err, result) {
                    conn.end()
                    console.log("con ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },
    getUsers: function (callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            }
            else {
                console.log("Connected!");
                var sql = 'SELECT * FROM users';
                conn.query(sql, function (err, result) {
                    conn.end();
                    console.log("connection ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },
    postUsers: function (created_at, username, password, filename, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err)
                return callback(err, null)
            } else {
                console.log('Connected')
                var sql = "INSERT INTO users(created_at,username,PFPID,password) values(FROM_UNIXTIME(?),?,?,?);"
                conn.query(sql, [created_at, username, filename, password], function (err, result) {
                    if (err) {
                        console.log('SQL ERR')
                        console.log(err);
                        return callback(err, null, null);
                    } else {
                        /* console.log(sql)
                         console.log(Date.now())
                         console.log(result)*/
                        var sql1 = "SELECT user_id FROM users ORDER BY created_at DESC LIMIT 1;"
                        conn.query(sql1, function (err, UID) {
                            if (err) {
                                console.log('SQL ERR')
                                console.log(err)
                                return callback(err, null, null)
                            } else {
                                return callback(null, result, UID)
                            }
                        })

                    }
                });
            }
        });
    },
    getUser: function (userid, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            } else {
                console.log("Connected!");
                var sql = 'SELECT * FROM users WHERE user_id = ?';
                conn.query(sql, [userid], function (err, result) {
                    conn.end();
                    console.log("conn ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },
    putUser: function (password, username, userid, PFPID, UNSame, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err)
                return callback(err, null)
            } else {
                if (UNSame == null) {//if user updates username
                    var sql1 = 'SELECT username FROM users'
                    conn.query(sql1, function (err1, result1) {
                        console.log('conn1 sent')
                        if (err1) {
                            callback(err1, null, null)
                        } else
                            if (SCheck(result1, username) == false) {/*If it is not unique, true, else false*/
                                return callback(null, null, true)
                            } else {
                                console.log(result1[0].username)
                                var sql = "UPDATE users SET password = ?,username = ?, PFPID = ? WHERE user_id = ?"
                                conn.query(sql, [password, username, PFPID, userid], function (err, result) {
                                    conn.end();
                                    console.log('Conn ended')
                                    if (err) {
                                        return callback(err, null, null)
                                    } else {
                                        console.log('Successful Change')
                                        return callback(null, result, null)
                                    }
                                })
                            }
                    })
                } else { //if user does not update
                    var sql = "UPDATE users SET password = ?,username = ?, PFPID = ? WHERE user_id = ?"
                    conn.query(sql, [password, username, PFPID, userid], function (err, result) {
                        conn.end();
                        console.log('Conn ended')
                        if (err) {
                            return callback(err, null, null)
                        } else {
                            console.log('Successful Change')
                            return callback(null, result, null)
                        }
                    }
                    )
                }
            }
        })
    },
    getUserListings: function (userid, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            }
            else {
                console.log("Connected!");
                var sql = 'SELECT * FROM listings WHERE fk_user_id = ?';
                conn.query(sql, [userid], function (err, result) {
                    conn.end();
                    console.log("Connection ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },
    getListings: function (callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            }
            else {
                console.log("Connected!");
                var sql = 'SELECT * FROM listings';
                conn.query(sql, function (err, result) {
                    conn.end();
                    console.log("Connection ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },
    /*getListingsOrder: function (sort,variable,callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            }
            else {
                console.log("Connected!");
                var sql = 'SELECT * FROM listings ORDER BY '+variable+' '+sort
                conn.query(sql, function (err, result) {
                    conn.end();
                    console.log("Connection ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },*/
    getListing: function (id, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            }
            else {
                console.log("Connected!");
                var sql = 'SELECT * FROM listings WHERE id = ?';
                conn.query(sql, [id], function (err, result) {
                    conn.end();
                    console.log("Connection ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },
    postListing: function (TOC, title, description, price, fk_user_id, filename, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err)
                return callback(err, null)
            } else {
                console.log('Connected')
                var sql = "INSERT INTO listings(TOC,title,description,price,fk_user_id,photo) values(FROM_UNIXTIME(?),?,?,?,?,?);"
                conn.query(sql, [TOC, title, description, price, fk_user_id, filename], function (err, result) {
                    if (err) {
                        console.log('SQL ERR')
                        console.log(err);
                        return callback(err, null, null);
                    } else {
                        var sql1 = "SELECT id FROM listings ORDER BY TOC DESC LIMIT 1;"
                        conn.query(sql1, function (err, ID) {
                            if (err) {
                                console.log('SQL1 ERR')
                                console.log(err)
                                return callback(err, null, null)
                            } else {
                                return callback(null, result, ID)
                            }
                        })

                    }
                });
            }
        });
    },
    deleteListing: function (id, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            }
            else {
                console.log('Connected')
                var sql = "DELETE FROM listings WHERE id = ?";
                conn.query(sql, [id], function (err, result) {
                    if (err) {
                        console.log('SQL ERR')
                        console.log(err);
                        return callback(err, null)
                    } else {
                        return callback(null, result)
                    }
                })
            }
        })
    },
    putListing: function (id, title, description, price, fk_user_id, photo, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err)
                return callback(err, null)
            } else {
                console.log('Connected')
                var sql = "UPDATE listings SET title = ? ,description = ? ,price = ? ,fk_user_id = ?,photo = ? WHERE id = ?"
                conn.query(sql, [title, description, price, fk_user_id, photo, id], function (err, result) {
                    if (err) {
                        console.log('SQL ERROR')
                        console.log(err);
                        return callback(err, null)
                    } else {
                        return callback(null, result)
                    }
                })
            }
        })
    },
    getOffer: function (id, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            }
            else {
                console.log("Connected!");
                var sql = 'SELECT * FROM offers WHERE fk_listing_id = ?';
                conn.query(sql, [id], function (err, result) {
                    conn.end();
                    console.log("Connection ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },
    postOffer: function (TOC, offer, fk_offeror_id, fk_listing_id, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err)
                return callback(err, null)
            } else {
                console.log('Connected')
                var sql = "INSERT INTO offers(TOC,offer,fk_listing_id,fk_offeror_id) values(FROM_UNIXTIME(?),?,?,?);"
                conn.query(sql, [TOC, offer, fk_listing_id, fk_offeror_id], function (err, result) {
                    if (err) {
                        console.log('SQL ERR')
                        console.log(err);
                        return callback(err, null, null);
                    } else {
                        var sql1 = "SELECT id FROM offers ORDER BY TOC DESC LIMIT 1;"
                        conn.query(sql1, function (err, ID) {
                            if (err) {
                                console.log('SQL1 ERR')
                                console.log(err)
                                return callback(err, null, null)
                            } else {
                                return callback(null, result, ID)
                            }
                        })

                    }
                });
            }
        });
    },
    Dislike: function (liker, listing, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            } else {
                console.log("Connected!");
                var sql = `SELECT user_id FROM users WHERE username = ?`//check if user exists
                conn.query(sql, [liker], function (err, result) {
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        console.log(result)
                        var sql1 =
                            `
                        SELECT 
                            fk_liker_id,
                            fk_listings_id
                        FROM
                            likes
                        WHERE 
                            fk_liker_id = ? 
                        AND
                            fk_listings_id = ?
                        `//use array.length
                        conn.query(sql1, [result[0].user_id, listing], function (err, DCheck) {
                            //console.log(DCheck)
                            //console.log(DCheck.length)
                            if (err) {
                                return callback(err, null)
                            } else {
                                //user cannot like same thing twice.
                                if (DCheck.length > 0) {
                                    var sql2 = "DELETE FROM likes WHERE fk_liker_id = ? AND fk_listings_id = ?"
                                    conn.query(sql2, [result[0].user_id, listing], function (err, OtherResult) {
                                        conn.end()
                                        console.log('connection ended')
                                        if (err) {
                                            console.log("Error")
                                            console.log(err)
                                            return callback(err, null)
                                        } else {
                                            return callback(null, "Disliked")
                                        }
                                    })
                                } else {
                                    return callback(null, "Cannot delete a listing that doesn't exist")
                                }
                            }
                        })
                    }
                });
            }
        });
    },
    Like: function (liker, listing, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            } else {
                console.log("Connected!");
                var sql = `SELECT user_id FROM users WHERE username = ?`//check if user exists
                console.log(liker)
                conn.query(sql, [liker], function (err, result) {
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        if (result.length == 0) {
                            return callback("User does not exist", null);
                        }
                        var sql1 =
                            `
                        SELECT 
                            fk_liker_id,
                            fk_listings_id
                        FROM
                            likes
                        WHERE 
                            fk_liker_id = ? 
                        AND
                            fk_listings_id = ?
                        `//use array.length
                        conn.query(sql1, [result[0].user_id, listing], function (err, DCheck) {
                            //console.log(DCheck)
                            //console.log(DCheck.length)
                            if (err) {
                                return callback(err, null)
                            } else {
                                //user cannot like same thing twice.
                                if (DCheck.length > 0) {
                                    return callback(null, "Cannot like a listing twice!")
                                } else {
                                    var sql2 = "INSERT INTO likes(fk_liker_id,fk_listings_id) values(?,?);"
                                    conn.query(sql2, [result[0].user_id, listing], function (err, OtherResult) {
                                        conn.end()
                                        console.log('connection ended')
                                        if (err) {
                                            console.log("Error")
                                            console.log(err)
                                            return callback(err, null)
                                        } else {
                                            return callback(null, "Liked")
                                        }
                                    })
                                }
                            }
                        })
                    }
                });
            }
        });
    },
    getLikes: function (callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            }
            else {
                console.log("Connected!");
                var sql = 'SELECT * FROM likes';
                conn.query(sql, function (err, result) {
                    conn.end();
                    console.log("connection ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },
    getUserLikes: function (id, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            }
            else {
                console.log("Connected!");
                var sql = 'SELECT * FROM likes WHERE fk_liker_id = ? ORDER BY fk_listings_id ASC;';
                conn.query(sql, [id], function (err, result) {
                    conn.end();
                    console.log("Connection ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },
    getListingLikes: function (id, callback) {
        var conn = dbconnect.getConnection();
        conn.connect(function (err) {
            if (err) {
                console.log(err);
                return callback(err, null);
            }
            else {
                console.log("Connected!");
                var sql = 'SELECT * FROM likes WHERE fk_listings_id = ?';
                conn.query(sql, [id], function (err, result) {
                    conn.end();
                    console.log("Connection ended")
                    if (err) {
                        console.log(err);
                        return callback(err, null);
                    } else {
                        return callback(null, result);
                    }
                });
            }
        });
    },
}
/* DELETE FROM listings WHERE */
/* ALTER TABLE listings AUTO_INCREMENT = 1*/
/* INSERT INTO listings(TOC,title,description,price,fk_user_id) values(FROM_UNIXTIME(?),?,?,?,?)*/



module.exports = DB
