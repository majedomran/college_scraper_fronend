

import 'package:college_scraper/login-request.dart';
import 'package:college_scraper/pages/main-page.dart';
import 'package:college_scraper/service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //declarations
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  dynamic data = "";
  bool isLoading = false;
  Service service = new Service();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل دخول'),
      ),
      body: Center(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                decoration:
                                    InputDecoration(labelText: 'اسم المستخدم'),
                                keyboardType: TextInputType.number,
                                controller: userName,
                              ),
                            ),
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'كلمة السر',
                                  ),
                                  obscureText: true,
                                  controller: password,
                                  onSubmitted: (_) => login(context),
                                )),
                          ],
                        ),
                      )),
                  RaisedButton(
                    child: Text('login'),
                    onPressed: () {
                      login(context);
                    },
                  ),
                  Text(data.toString())
                ],
              ),
      ),
    );
  }

  void login(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    LoginRequest loginrequest = new LoginRequest(
        userName.text.replaceAll(' ', ''), password.text.replaceAll(' ', ''));
    dynamic r = await loginrequest.login();
    setState(() {
      isLoading = false;
    });
    setState(() {
      if (r != null) {
        data = r;
        print(data);
        service.navigatingPage(context, MainPage(data),true);
      }
    });
  }

  
}
