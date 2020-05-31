const jwt = require('jsonwebtoken');

module.exports = function(req, res, next) {
    const token = req.header('auth_token');
    if (!token) return res.status(401).send('ACCESS DENIED');

    try {
        const varify = jwt.verify(token, process.env.TOKEN);
        req.user = varify;
    } catch (err) {
        res.status(400)
            .send('INVAILD TOKEN');
    }
    next();
}
