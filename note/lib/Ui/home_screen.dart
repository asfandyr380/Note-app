import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:note/const.dart';
import 'componants.dart';
import 'package:note/Services/Networking.dart';
import 'package:http/http.dart' as http;

 String iD;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

      Future<void> getItem() async {
      final String url = 'http://192.168.10.12:3001/todos';
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'auth_token': token,
    };
    http.Response response = await http.get(url, headers: header);
    var body = response.body;
    setState(() {
      items = jsonDecode(body);
    });
      
  }

  @override
  void initState()  {
    super.initState(); 
        getItem();
  }

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
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 70, left: 30),
                  child: Text(
                    'Hi Asfand Yr',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50, left: 70),
                  child: addButton(() async {
                    bool result = await showMyDialog(context);
                    if (result) {
                        await getItem();  
                    } else {
                      print('you did not save');
                    }
                  }),
                ),
              ],
            ),
            Divider(
              endIndent: 20,
              indent: 20,
              color: Colors.white,
              thickness: 2,
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      color: cardColor,
                      child: ListTile(
                        leading: Icon(
                          Icons.sort,
                          color: Colors.white,
                        ),
                        trailing: GestureDetector(
                          onTap: (){
                            iD = items[index]['_id']; 
                            deleteItem(iD).whenComplete(() async{
                               await getItem();
                            });
                            print(iD);
                          },
                          child: Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        title: Text(items[index]['todoname'],
                            style:
                                TextStyle(color: Colors.white, fontSize: 22)),
                        subtitle: Text(items[index]['date'],
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
