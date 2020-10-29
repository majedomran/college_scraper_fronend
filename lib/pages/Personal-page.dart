import 'package:college_scraper/pages/main-page.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatelessWidget {
  dynamic data;
  PersonalPage(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "شخصي",
            textAlign: TextAlign.start,
          ),
        ),
        body: Center(
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'الأسم : ' + data['name'],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text('الكليه : ' + data['college'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    Text(
                      'التخصص : ' + data['major'],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text('email : ' + data['email'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    Text(
                      'الرقم الجامعي : ' + data['stdNumber'],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text('الإنذارات : ' + data['warnings'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              title: Text('احصائيات'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('شخصي'),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: Colors.amber[800],
          currentIndex: 1,
          onTap: (value) {
            if (value == 0) {
              print('its 0');
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      MainPage(data),
                ),
              );
            }
          },
        ));
  }
}
