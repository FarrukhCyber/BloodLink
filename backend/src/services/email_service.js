var nodeoutlook = require('nodejs-nodemailer-outlook')

function sendEmail(to, content) {

    user = "bloodlink.lcss@outlook.com"
    pass = "bloodlink@SEproject"

    nodeoutlook.sendEmail({
        auth: {
            user: user,
            pass: pass
        },
        from: user,
        to: to,
        subject: 'Blood Request',
        text: content,
        replyTo: user,
    
        onError: (e) => console.log(e),
        onSuccess: (i) => console.log(i)
    
    });
}

module.exports = sendEmail