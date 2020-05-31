import 'package:note/Services/Networking.dart';
import 'package:flutter/material.dart';
import 'package:note/const.dart';

final TextEditingController title_controller = TextEditingController();
final TextEditingController description_controller = TextEditingController();

String title;
String description;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

Future<bool> showMyDialog(BuildContext context) async {
  return showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        actionsPadding: EdgeInsets.all(20),
        backgroundColor: dialogColor,
        title: Text(
          'ADD TODO',
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Form(
            autovalidate: true,
            key: _formKey,
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  onSaved: (value) {
                    title = value;
                  },
                  validator: (value) {
                    if (value == '') {
                      return 'Enter Something';
                    }
                  },
                  style: typedtext,
                  controller: title_controller,
                  decoration: textFielddecoration.copyWith(
                      labelText: 'Note', hintText: ''),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (value) {
                    description = value;
                  },
                  style: typedtext,
                  controller: description_controller,
                  maxLines: 4,
                  decoration: textFielddecoration.copyWith(
                      labelText: 'Description', hintText: ''),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 35,
                width: 100,
                child: customButton(context, 'Save', () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    addTodo(title, description);
                    Navigator.pop(context, true);
                    title_controller.clear();
                    description_controller.clear();
                  }
                }, loginButtoncolor),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                height: 35,
                width: 100,
                child: customButton(context, 'Back', () {
                  title_controller.clear();
                  description_controller.clear();
                  Navigator.pop(context, false);
                }, buttonColor),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Widget customButton(
    BuildContext ctx, String label, Function onpressed, Color color) {
  return MaterialButton(
    onPressed: onpressed,
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    color: color,
    child: Text(
      label,
      style: TextStyle(fontSize: 25, color: Colors.white),
    ),
  );
}

Widget addButton(Function onPressed) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, right: 25),
    child: SizedBox.fromSize(
      size: Size(60, 60), // button width and height
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          elevation: 10,
          color: cardColor, // button color
          child: InkWell(
            splashColor: Colors.grey, // splash color
            onTap: onPressed, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.add, color: Colors.white, size: 35), // icon // text
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
