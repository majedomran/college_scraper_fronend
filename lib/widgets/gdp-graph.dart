import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample1 extends StatefulWidget {
  List years;
  List gdps;
  List ecumilatedGDPs;
  LineChartSample1(this.years, this.gdps,this.ecumilatedGDPs);
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  bool isShowingMainData;
  int i = 0;
  int j = 0;
  List indexes = new List();
  List<FlSpot> flSpotsGDP = new List();
  List<FlSpot> flSpotEcumilatedGDP = new List();
  LineChartBarData lineChartBarData1 = new LineChartBarData();
  bool isDone = false;
  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  void beforeBuild() {
    if (!isDone) {
      isDone = true;
      int cloneI = 0;
      int l = 0;
      int cloneJ = 0;
      for (var value = 0; value <= 14; value++) {
        // if(value == 0)indexes.clear();
        if ((14 / widget.years.length).toInt() >= 2 && l == 0) {
          cloneI = (14 / widget.years.length).toInt();
          l++;
          // print(l.toString()+(l == 0).toString());
        }
        // print(value);
        // print((14 / widget.years.length).toInt());
        if (value == cloneI && widget.years.length > cloneJ) {
          // print(cloneI);
          indexes.add(cloneI);
          // print('value is ' + i.toString());
          cloneI = cloneI + 2;
          // print(indexes);
          if (value == 14) {
            cloneI = 0;
            cloneJ = 0;
          }
          // print(j == widget.years.length);
          // print(widget.years.length);
          if (cloneJ == widget.years.length) {
            cloneJ--;
            print('decrese j');
          }

          cloneJ++;
          // print('j = '+j.toString());

        }
      }
      l = 0;
      cloneI = 0;
      cloneJ = 0;
      // print(widget.gdps);
      for (var i = 0; i < indexes.length; i++) {
        flSpotsGDP.add(new FlSpot(double.parse(indexes[i].toString()),
            double.parse(widget.gdps[i].toString())));
        flSpotEcumilatedGDP.add(new FlSpot(double.parse(indexes[i].toString()),
            double.parse(widget.ecumilatedGDPs[i].toString())));
          
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    beforeBuild();

    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          gradient: LinearGradient(
            colors: [
              Colors.amber[700],
              Colors.blue,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'المعدل',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      isShowingMainData ? sampleData1() : sampleData2(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
    flSpotsGDP.clear();
    flSpotEcumilatedGDP.clear();
    indexes.clear();
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            if (value == 0) indexes.clear();
            if ((14 / widget.years.length).toInt() >= 2 && i == 0)
              i = (14 / widget.years.length).toInt();
            // print(i);
            // print(value);
            // print((14 / widget.years.length).toInt());
            if (value == i && widget.years.length > j) {
              // print('value is ' + i.toString());
              i = i + 2;
              // print(indexes);
              if (value == 14) {
                i = 0;
                j = 0;
              }
              // print(j == widget.years.length);
              // print(widget.years.length);
              if (j == widget.years.length) {
                j--;
                print('decrese j');
              }
              var term = widget.years[j.toInt()];
              j++;
              // print('j = '+j.toString());
              return term;
            }
            if (value == 14) {
              i = 0;
              j = 0;
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 3:
                return '3';
              case 4:
                return '4';
              case 5:
                return '5';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 5,
      minY: 3,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    lineChartBarData1 = new LineChartBarData(
      spots: flSpotsGDP,
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: flSpotEcumilatedGDP,
      isCurved: true,
      colors: [
              Colors.white70
            ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    // final LineChartBarData lineChartBarData3 = LineChartBarData(
    //   spots: [
    //     FlSpot(1, 2.8),
    //     FlSpot(3, 1.9),
    //     FlSpot(6, 3),
    //     FlSpot(10, 1.3),
    //     FlSpot(13, 2.5),
    //   ],
    //   isCurved: true,
    //   colors: const [
    //     Color(0xff27b6fc),
    //   ],
    //   barWidth: 8,
    //   isStrokeCapRound: true,
    //   dotData: FlDotData(
    //     show: false,
    //   ),
    //   belowBarData: BarAreaData(
    //     show: false,
    //   ),
    // );
    return [
      lineChartBarData1,
      lineChartBarData2,
      // lineChartBarData3,
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            if (value == 0) indexes.clear();
            if ((14 / widget.years.length).toInt() >= 2 && i == 0)
              i = (14 / widget.years.length).toInt();
            // print(i);
            // print(value);
            // print((14 / widget.years.length).toInt());
            if (value == i && widget.years.length > j) {
              // print('value is ' + i.toString());
              i = i + 2;
              // print(indexes);
              if (value == 14) {
                i = 0;
                j = 0;
              }
              // print(j == widget.years.length);
              // print(widget.years.length);
              if (j == widget.years.length) {
                j--;
                print('decrese j');
              }
              var term = widget.years[j.toInt()];
              j++;
              // print('j = '+j.toString());
              return term;
            }
            if (value == 14) {
              i = 0;
              j = 0;
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
             
              case 3:
                return '3';
              case 4:
                return '4';
              case 5:
                return '5';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
          
      minX: 0,
      maxX: 14,
      maxY: 5,
      minY: 4,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    return [
      LineChartBarData(
        spots: flSpotsGDP,
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0xff4af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: flSpotEcumilatedGDP,
        isCurved: true,
        colors: [
              Colors.white70
            ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: false, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
      // LineChartBarData(
      //   spots: [
      //     FlSpot(1, 3.8),
      //     FlSpot(3, 1.9),
      //     FlSpot(6, 5),
      //     FlSpot(10, 3.3),
      //     FlSpot(13, 4.5),
      //   ],
      //   isCurved: false,
      //   curveSmoothness: 0,
      //   colors: const [
      //     Color(0x4427b6fc),
      //   ],
      //   barWidth: 2,
      //   isStrokeCapRound: true,
      //   dotData: FlDotData(show: true),
      //   belowBarData: BarAreaData(
      //     show: false,
      //   ),
      // ),
    ];
  }
}
