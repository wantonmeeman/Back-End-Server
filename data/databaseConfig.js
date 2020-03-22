var mysql = require('mysql');
var dbconnect = {
    getConnection: function () {
        var conn = mysql.createConnection({
            host: "localhost",
            user: "root",
            password: "Yolo021205",
            database: "assign"
        });
        return conn;
    }
};
module.exports = dbconnect
