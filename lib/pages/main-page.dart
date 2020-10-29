import 'package:college_scraper/pages/Personal-page.dart';
import 'package:college_scraper/widgets/gdp-graph.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import '../service.dart';
import 'course.dart';

class MainPage extends StatefulWidget {
  dynamic data;
  MainPage(this.data);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Service service = new Service();
  List<charts.Series<GDP, String>> _seriesPieData;
  List<LineChartBarData> lineChartData;
  List<Course> courses;
  int selctedIndex = 0;
  _generateData(dynamic data) {
    var piedata = [
      new GDP(
          'معدل', double.parse(service.calculateGDP(data)), Colors.amber[800]),
      new GDP('', 5 - double.parse(service.calculateGDP(data)), Colors.white),
    ];
    _seriesPieData = List<charts.Series<GDP, String>>();
    lineChartData = List<LineChartBarData>();
    _seriesPieData.add(
      charts.Series(
        domainFn: (GDP gdp, _) => gdp.year,
        measureFn: (GDP gdp, _) => gdp.value,
        colorFn: (GDP gdp, _) => charts.ColorUtil.fromDartColor(gdp.colorVal),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (GDP row, _) => '${row.value}',
      ),
    );

    courses = new List();
    courses.addAll(service.getAllCourses(data));
  }

  void onItemTaped(index, context, data) {
    setState(() {
      selctedIndex = index;
      if (index == 1)
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                PersonalPage(data),
          ),
        );
      // service.navigatingPage(context, page, false);
    });
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(this.widget.data);
    _generateData(widget.data);
    return Scaffold(
        appBar: AppBar(
          title: Text("احصائيات"),
        ),
        body: Center(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Card(
                          child: LineChartSample1(
                              new List.from(
                                  service.getTermsByYear(widget.data).reversed),
                              new List.from(
                                  service.getGDPs(widget.data).reversed),
                              service.getEcumaltedGDPs(widget.data))),
                    ),
                  ),
                  Flexible(
                      flex: 2,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Card(
                              child: Container(),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: ListView(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        child: Column(
                                            children: courses.map((course) {
                                          return Card(
                                            color: course.color,
                                            child: Container(
                                                width: double.infinity,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            course.grade,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        )),
                                                    Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            getHoursTrue(
                                                                course),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        )),
                                                    Flexible(
                                                      flex: 5,
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          course.name,
                                                          style: TextStyle(),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          );
                                        }).toList()),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              )),
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
          currentIndex: selctedIndex,
          onTap: (index) {
            print(selctedIndex);
            onItemTaped(index, context, widget.data);
          },
        ));
  }

  String getHoursTrue(Course course) {
    if (course.hours != null) return course.hours.toString();
    return '';
  }
}

class GDP {
  String year;
  double value;
  Color colorVal;

  GDP(this.year, this.value, this.colorVal);
}
