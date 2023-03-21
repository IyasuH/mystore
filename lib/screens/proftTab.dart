// ignore: file_names
import 'package:flutter/material.dart';
import 'package:mystore/Widgets/dailyProfit.dart';
import 'package:mystore/Widgets/monthlyProfit.dart';
import 'package:mystore/Widgets/yearlyProfit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Widgets/weeklyProfit.dart';

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class profitColumChart extends StatefulWidget {
  const profitColumChart({super.key});

  @override
  State<profitColumChart> createState() => _profitColumChartState();
}

class _profitColumChartState extends State<profitColumChart> {
  @override
  Widget build(BuildContext context) {
    // The data source will be dependent on the touched and also  its number
    final List<ChartData> profitData = [
      ChartData(1, 100),
      ChartData(2, 87),
      ChartData(3, 65),
      ChartData(4, 98),
      ChartData(5, 81),
      ChartData(6, 120),
      ChartData(7, 90),
    ];
    return Scaffold(
      body: Center(
          child: Container(
        child: SfCartesianChart(series: <ChartSeries<ChartData, int>>[
          ColumnSeries(
            enableTooltip: false,
            color: Colors.green,
            isVisibleInLegend: true,
            isVisible: true,
            // isTrackVisible: true,
            dataSource: profitData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            // width: 0.9,
            // spacing: 0.3,
          ),
        ]),
      )),
    );
  }
}

class ProfitTab extends StatefulWidget {
  const ProfitTab({super.key});

  @override
  State<ProfitTab> createState() => _ProfitTabState();
}

class _ProfitTabState extends State<ProfitTab> {
  // Color profitPrimaryColor = const Color.fromRGBO(255, 38, 255, 0);
  // Color profitPrimaryColor = Colors.blueAccent;

  // Color profitSecondaryColor = const Color.fromRGBO(30, 19, 224, 0);
  // Color profitSecondaryColor = Colors.blue;
  Color thirtyPerCentColor = Colors.grey;
  int _selectedIndex = 0;
  // ignore: non_constant_identifier_names
  final List<String> _profitTimely = ["D", "W", "M", "Y"];
  Widget _buildTimelyChoose(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 55.0,
        width: 55.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedIndex == index ? Colors.green : Colors.white10,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _selectedIndex == index
                  ? const Color.fromARGB(255, 1, 203, 105)
                  : Colors.black26,
              // spreadRadius: 1.5,
              blurRadius: 5,
              blurStyle: BlurStyle.outer,
            )
          ],
          borderRadius: BorderRadius.circular(19),
        ),
        child: Center(
          child: Text(
            _profitTimely[index],
            // textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22,
                color: _selectedIndex == index
                    ? const Color.fromARGB(255, 1, 203, 105)
                    : Colors.white,
                fontWeight: _selectedIndex == index
                    ? FontWeight.w500
                    : FontWeight.w300),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _profitTimely
                    .asMap()
                    .entries
                    .map(
                      (MapEntry map) => _buildTimelyChoose(map.key),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // calling diferent graphs based on different timely choices
            SizedBox(
                height: 350,
                child: _selectedIndex == 0
                    ? DailyBarChart()
                    : _selectedIndex == 1
                        ? WeeklyBarChart()
                        : _selectedIndex == 2
                            ? MonthlyBarChart()
                            : YearlyBarChart()),
            Row(children: [
              Column(
                children: [
                  Container(
                    height: 190,
                    width: 185,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        top: 14, bottom: 7, right: 7, left: 14),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          width: 2.0,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 1, 203, 105),
                            blurStyle: BlurStyle.outer,
                            blurRadius: 5,
                          )
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.black45),
                    // ignore: prefer_const_literals_to_create_immutables
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text('Total Profit'),
                        Text('Today'),
                        Text('\$400'),
                      ],
                    ),
                  ),
                  Container(
                    height: 240,
                    width: 185,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        top: 7, bottom: 14, right: 7, left: 14),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 1, 203, 105),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 5,
                        )
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.black45,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text('Total Profit'),
                        Text('Today'),
                        Text('\$400'),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 240,
                    width: 185,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        top: 14, bottom: 7, right: 13, left: 7),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 1, 203, 105),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 5,
                        )
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.black45,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text('Total Profit'),
                        Text('Today'),
                        Text('\$400'),
                      ],
                    ),
                  ),
                  Container(
                    height: 190,
                    width: 185,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        top: 7, bottom: 14, right: 13, left: 7),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 1, 203, 105),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 5,
                        )
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.black45,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text('Total Profit'),
                        Text('Today'),
                        Text('\$400'),
                      ],
                    ),
                  )
                ],
              )
            ])
          ],
        ),
      ),
    );
  }
}
