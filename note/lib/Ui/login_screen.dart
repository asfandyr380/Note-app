import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:note/Ui/componants.dart';
import 'package:note/Ui/home_screen.dart';
import 'package:note/const.dart';
import 'register_screen.dart';
import 'package:note/Services/Networking.dart';

TextEditingController email_controller = TextEditingController();
TextEditingController pass_controller = TextEditingController();

String email;
String pass;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
                    margin: EdgeInsets.only(right: 270, top: 12),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 33),
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
                          hintText: 'Password',
                          labelText: 'Enter Your Password'),
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 150,
                    margin: EdgeInsets.only(right: 230, top: 20),
                    child: customButton(context, 'LOGIN', () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        logIn(email, pass).whenComplete(() {
                          if (token == null || token == '') {
                            return print('token is null');
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Home();
                            }));
                          }
                        });
                        email_controller.clear();
                        pass_controller.clear();
                      }
                    }, loginButtoncolor),
                  ),
                  Container(
                    height: 35,
                    width: 150,
                    margin: EdgeInsets.only(top: 120),
                    child: customButton(context, 'Register', () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegisterPage();
                      }));
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
