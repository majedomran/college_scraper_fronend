import 'package:flutter/material.dart';
import './pages/Personal-page.dart';
import 'pages/course.dart';

class Service {
  String calculateGDP(Map data) {
    int hours = totalHours(data);
    double points = totalPoints(data);
    double GDP = points / hours;
    print(GDP);
    return GDP.toStringAsFixed(2);
  }

  double totalPoints(Map data) {
    double points = 0;
    var i = 0;
    List terms = getTerms(data);
    while (data['data']['term' + i.toString()] != null) {
      var j = 0;
      while (data['data']['term' + i.toString()][terms[i]]
              ['course' + j.toString()] !=
          null) {
        if (double.parse(data['data']['term' + i.toString()][terms[i]]
                ['course' + j.toString()]['points']) !=
            0)
          points += double.parse(data['data']['term' + i.toString()][terms[i]]
              ['course' + j.toString()]['points']);
        j++;
      }
      i++;
    }
    return points;
  }

  int totalHours(Map data) {
    int hours = 0;
    var i = 0;
    List terms = getTerms(data);
    while (data['data']['term' + i.toString()] != null) {
      var j = 0;
      while (data['data']['term' + i.toString()][terms[i]]
              ['course' + j.toString()] !=
          null) {
        if (double.parse(data['data']['term' + i.toString()][terms[i]]
                ['course' + j.toString()]['points']) !=
            0)
          hours += int.parse(data['data']['term' + i.toString()][terms[i]]
              ['course' + j.toString()]['hours']);
        j++;
      }
      i++;
    }

    return hours;
  }

  double calculateSingleGdp(Map term) {
    var i = 0;
    double hours = 0;
    double points = 0;
    while (term['course' + i.toString()] != null) {
      if (double.parse(term['course' + i.toString()]['points']) != 0) {
        hours += double.parse((term['course' + i.toString()]['hours']));
        points += double.parse(term['course' + i.toString()]['points']);
      }
      i++;
    }
    return points / hours;
  }

  List getGDPs(dynamic data) {
    List gdps = new List();
    List terms = getTerms(data);
    for (var i = 0; i < terms.length; i++) {
      gdps.add(
          calculateSingleGdp(data['data']['term' + i.toString()][terms[i]]));
    }
    return gdps;
  }

  List getEcumaltedGDPs(dynamic data) {
    List gdps = new List();
    List<HoursPoints> currentGDPs = new List();
    List terms = getTerms(data);
    for (var i = 0; i < terms.length; i++) {
      var index = 0;
      while (data['data']['term' + i.toString()][terms[i]]
              ['course' + index.toString()] !=
          null) {
        if (double.parse(data['data']['term' + i.toString()][terms[i]]
                ['course' + index.toString()]['points']) !=
            0)
          currentGDPs.add(new HoursPoints(
              double.parse(data['data']['term' + i.toString()][terms[i]]
                  ['course' + index.toString()]['hours']),
              double.parse(data['data']['term' + i.toString()][terms[i]]
                  ['course' + index.toString()]['points'])));
        index++;
      }

      double hours = 0;
      double points = 0;

      for (var j = 0; j < currentGDPs.length; j++) {
        hours += currentGDPs[j].hours;
        points += currentGDPs[j].points;
      }
      gdps.add(points / hours);
    }
    print(gdps);
    return new List.from(gdps.reversed);
  }

  List getTerms(Map data) {
    var i = 0;
    List terms = new List();
    while (data['data']['term' + i.toString()] != null) {
      terms.addAll(data['data']['term' + i.toString()].keys.toList());
      i++;
    }
    // print(terms);
    return terms;
  }

  List getTermsByYear(Map data) {
    var i = 0;
    List terms = new List();
    List termsByYear = new List();
    while (data['data']['term' + i.toString()] != null) {
      terms = getTerms(data);
      String term = terms[i];
      String finalTerm = term.split(' ')[2];
      String termNum = term.split(' ')[1];
      if (termNum == 'الأول') finalTerm = finalTerm + '(1)';
      if (termNum == 'الثاني') finalTerm = finalTerm + '(2)';
      if (termNum == 'الصيفي') finalTerm = finalTerm + '(0)';
      termsByYear.add(finalTerm);
      // print(term);
      // print(i);
      i++;
    }
    // print(terms);
    return termsByYear;
  }

// build a method that gets a key: index, value {color:''white,name:'phy',grade:'A+',hours:'3'}
  List<Course> getAllCourses(dynamic data) {
    List<Course> courses = new List();
    List terms = getTerms(data);
    for (var i = 0; i < terms.length; i++) {
      // if((terms.length - i)==1||(terms.length - i)==4||(terms.length - i)==7||(terms.length - i)==10||(terms.length - i)==13||(terms.length - i)==16)
      // courses.add(new Course('الترم الأول','',null,Colors.blue));
      // if((terms.length - i)==2||(terms.length - i)==5||(terms.length - i)==8||(terms.length - i)==11||(terms.length - i)==14||(terms.length - i)==17)
      // courses.add(new Course('الترم الثاني','',null,Colors.blue));
      // if((terms.length - i)==3||(terms.length - i)==6||(terms.length - i)==9||(terms.length - i)==12||(terms.length - i)==15||(terms.length - i)==18)
      courses.add(
          new Course(terms[i].toString(), 'التقدير', 'ساعات', Colors.blue));
      courses.addAll(getCoursesOfTerm(data, i));
      courses.add(new Course(
          'تقدير الترم',
          calculateSingleGdp(data['data']['term' + i.toString()][terms[i]])
              .toStringAsFixed(2),
          getHoursTerm(getCoursesOfTerm(data, i)),
          Colors.amber[700]));
    }
    // for (var i = 0; i < courses.length; i++) {
    //   print(courses[i].name);
    // }//not important
    return courses;
  }

  int getHoursTerm(List term) {
    int hours = 0;
    for (var i = 0; i < term.length; i++) {
      hours += term[i].hours;
    }
    return hours;
  }

  List<Course> getCoursesOfTerm(Map data, int index) {
    List<Course> courses = new List();

    List terms = getTerms(data);
    var j = 0;
    while (data['data']['term' + index.toString()][terms[index]]
            ['course' + j.toString()] !=
        null) {
      courses.add(new Course(
          data['data']['term' + index.toString()][terms[index]]
              ['course' + j.toString()]['name'],
          data['data']['term' + index.toString()][terms[index]]
              ['course' + j.toString()]['grade'],
          int.parse(data['data']['term' + index.toString()][terms[index]]
              ['course' + j.toString()]['hours']),
          Colors.white));
      j++;
    }
    // print(course);
    return courses;
  }

  navigatingPage(BuildContext context, page, bool pop) {
    if (pop) Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class HoursPoints {
  double hours;
  double points;
  HoursPoints(this.hours, this.points);
}
