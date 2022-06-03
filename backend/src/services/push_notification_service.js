const {ONE_SIGNAL_CONFIG} = require("../config/notifications_config")

async function sendNotification(data, callback) {
    var headers = {
        "Content-Type": "application/json; charset=utf-8",
        Authorization : "Basic " + ONE_SIGNAL_CONFIG.API_KEY
    }

    var options = {
        host: "onesignal.com",
        port: 443,
        path: "/api/v1/notifications",
        method: "POST",
        headers: headers
    }

    var https = require("https")
    var req = https.request(options, (res) => {
        res.on("data", (data) => {
            console.log(JSON.parse(data))

            return callback(null, JSON.parse(data))
        })
    })

    req.on("error", (err) => {
        return callback({
            message: err
        })
    })

    req.write(JSON.stringify(data))
    req.end()
}

module.exports = {
    sendNotification
}