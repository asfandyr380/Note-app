import 'package:email_validator/email_validator.dart';
import 'package:note/Services/Networking.dart';
import 'package:flutter/material.dart';
import 'package:note/Ui/componants.dart';
import 'package:note/const.dart';
import 'login_screen.dart';

TextEditingController username_controller = TextEditingController();
TextEditingController email_controller = TextEditingController();
TextEditingController pass_controller = TextEditingController();

String username;
String email;
String password;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [backgroundcolor2, backgroundcolor1],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Hero(
                    tag: 'hero',
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Logo.png'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'NOTE',
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 100, top: 12),
                    child: Text(
                      'Setup Your Account',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 12, right: 12),
                    child: TextFormField(
                      onSaved: (value) {
                        username = value;
                      },
                      validator: (value) {
                        if (value == '') {
                          return 'INVALID USERNAME';
                        }
                      },
                      style: typedtext,
                      controller: username_controller,
                      decoration: textFielddecoration.copyWith(
                          hintText: 'Username', labelText: 'Enter a Username'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 12, right: 12),
                    child: TextFormField(
                      onSaved: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (!EmailValidator.validate(value)) {
                          return 'Please Enter a Valid Email';
                        }
                      },
                      style: typedtext,
                      controller: email_controller,
                      decoration: textFielddecoration.copyWith(
                          hintText: 'Email', labelText: 'Enter Your Email'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 12, right: 12),
                    child: TextFormField(
                      onSaved: (value) {
                        pass = value;
                      },
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Too Short';
                        }
                      },
                      obscureText: true,
                      style: typedtext,
                      controller: pass_controller,
                      decoration: textFielddecoration.copyWith(
                          hintText: 'Password', labelText: 'Enter a Password'),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 150,
                    margin: EdgeInsets.only(right: 230, top: 20),
                    child: customButton(context, 'Register', () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        registerUser(username, email, pass).whenComplete(() => {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginPage();
                              })),
                            });
                        username_controller.clear();
                        email_controller.clear();
                        pass_controller.clear();
                      }
                    }, loginButtoncolor),
                  ),
                  Container(
                    height: 35,
                    width: 150,
                    margin: EdgeInsets.only(top: 120),
                    child: customButton(context, 'LOGIN', () {
                      Navigator.pop(context);
                    }, buttonColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
