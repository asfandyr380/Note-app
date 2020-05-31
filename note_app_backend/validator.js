const Joi = require('@hapi/joi');

const RegisterationValidator = (data) => {
    const schema = Joi.object().keys({
        username: Joi.string().min(4).required(),
        email: Joi.string().email().min(6).required(),
        password: Joi.string().min(6).required()
    });
    return schema.validate(data, schema);
}

const LoginValidator = (data) => {
    const schema = Joi.object({    
        email: Joi.string().email().min(6).required(),
        password: Joi.string().min(6).required()
    });
    schema.validate(data, schema);
}

module.exports.RegisterationValidator = RegisterationValidator;
module.exports.LoginValidator = LoginValidator;
