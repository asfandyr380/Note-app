import 'dart:convert';
import 'package:http/http.dart' as http;


List items = [];
String token;
String path;
final String url = 'http://192.168.10.12:3001/users/$path';

  Future<void> logIn(String email, String pass) async {
    path = 'login';
    var data = {
      'email': email,
      'password': pass,
    };

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    http.Response response =
        await http.post(url, headers: header, body: json.encode(data));
    var body = response.body;
    token = jsonDecode(body)['authtoken'];
    print(token);
  }


  Future<void> registerUser(String username, String email, String pass) async {
    path = 'register';
    var data = {
      'username': username,
      'email': email,
      'password': pass,
    };

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    http.Response response =
        await http.post(url, body: json.encode(data), headers: header);
    http.get(url);
    print(response.headers);
  }


   Future<void> deleteItem(String id) async
  {
    final String deleteUrl = 'http://192.168.10.12:3001/todos/$id';
      var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    http.Response response = await http.delete(deleteUrl, headers: header);
    print(response.body);
  }


  Future<void> addTodo(String title, description) async
  {
    final String addurl = 'http://192.168.10.12:3001/todos';
       var data = {
         'todoname': title,
         'description': description
    };

    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    http.Response response = await http.post(addurl, headers: header, body: json.encode(data));

    print(response.body);
  }