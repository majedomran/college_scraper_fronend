import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:http/http.dart' ;

class LoginRequest {
  String userName = '';
  String password = '';
  String body;
  LoginRequest(this.userName, this.password);

  HttpClient client = new HttpClient();

  Future<dynamic> login() async {
    Map<String, dynamic> data = {
      'loginForm:username': userName,
      'loginForm:password': password
    };
    print(userName);
    print(password);
    print(data);
    var body;
    Response r =
        await post('https://my-college-scrape.herokuapp.com/', body: data);
        try{
    body = json.decode(r.body);
        }catch(e){
          print('exeption from json encoder');
          return null;
        }
    print(r.statusCode);
    return (body['login'] == 'true') ? body : null;
  }
}
