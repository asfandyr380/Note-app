import 'package:flutter/material.dart';

// Login/register Screen Colors
const Color backgroundcolor1 = Color(0xff4C555D);
const Color backgroundcolor2 = Color(0xff0F1113);
const Color loginButtoncolor = Color(0xffF1833B);
const Color registerColor = Color(0xff29282E);

// Home Screen Colors
const Color cardColor = Color(0xff303743);
const Color buttonColor = Color(0xff475060);
const Color dialogColor = Color(0xff626D80);


// TextField Styling Properties
final TextStyle typedtext = TextStyle(color: Colors.white, fontSize: 20);
final InputDecoration textFielddecoration = InputDecoration(
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: Colors.white)),
  labelStyle: TextStyle(color: Colors.white),
  labelText: 'Value',
  hintText: 'Enter Your Value',
  hintStyle: TextStyle(color: Colors.white),
);
