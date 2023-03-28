// ignore_for_file: file_names, implementation_imports, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/model.dart';

class MonthlyBarChart extends StatefulWidget {
  List monthlyProfit;
  MonthlyBarChart({
    super.key,
    required this.monthlyProfit,
  });

  @override
  State<MonthlyBarChart> createState() => _MonthlyBarChartState();
}

class _MonthlyBarChartState extends State<MonthlyBarChart> {
  Map FlListP = {};
  double totalMonProfit = 0;
  loadFlListPData() {
    for (var i = 0; i < (widget.monthlyProfit.length); i += 1) {
      FlListP[i] = widget.monthlyProfit[i];
      totalMonProfit += widget.monthlyProfit[i];
    }
    setState(() {});
  }

  @override
  void initState() {
    // // Just In case months change :)
    FlListP[widget.monthlyProfit.length + 1] = 0;
    FlListP[widget.monthlyProfit.length + 2] = 0;
    FlListP[widget.monthlyProfit.length + 3] = 0;
    loadFlListPData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 7, right: 10, bottom: 1, left: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '\$ $totalMonProfit',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                          // height: 4,
                          ),
                      const Text(
                        'This Week Profit',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          letterSpacing: 1.5,
                          wordSpacing: 1.8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 38,
                ),
                Expanded(child: LineChart(mainData())),
              ],
            ),
          ),
        )
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.black54,
            tooltipMargin: -1,
          )),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      // minY: 0,
      maxX: 31,
      lineBarsData: [
        LineChartBarData(
          // spots: (dynamic){
          //   List<FlSpot> newList=[];
          //   for(i=1;i<=LFlListP.length();i+=1){
          //     newList.add(i, FlListP[i]),
          //   }
          //   return newList;
          // },
          // tried to automate this but i shoud be done fast
          spots: [
            FlSpot(1, FlListP[0]),
            FlSpot(2, FlListP[1]),
            FlSpot(3, FlListP[2]),
            FlSpot(4, FlListP[3]),
            FlSpot(5, FlListP[4]),
            FlSpot(6, FlListP[5]),
            FlSpot(7, FlListP[6]),
            FlSpot(8, FlListP[7]),
            FlSpot(9, FlListP[8]),
            FlSpot(10, FlListP[9]),
            FlSpot(11, FlListP[10]),
            FlSpot(12, FlListP[11]),
            FlSpot(13, FlListP[12]),
            FlSpot(14, FlListP[13]),
            FlSpot(15, FlListP[14]),
            FlSpot(16, FlListP[15]),
            FlSpot(17, FlListP[16]),
            FlSpot(18, FlListP[17]),
            FlSpot(19, FlListP[18]),
            FlSpot(20, FlListP[19]),
            FlSpot(21, FlListP[20]),
            FlSpot(22, FlListP[21]),
            FlSpot(23, FlListP[22]),
            FlSpot(24, FlListP[23]),
            FlSpot(25, FlListP[24]),
            FlSpot(26, FlListP[25]),
            FlSpot(27, FlListP[26]),
            FlSpot(28, FlListP[27]),
            FlSpot(29, FlListP[28]),
            FlSpot(30, FlListP[29]),
            FlSpot(31, FlListP[30]),
          ],
          color: Colors.green,
          isCurved: true,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: const Color.fromARGB(30, 19, 224, 0),
          ),
        ),
      ],
    );
  }
}
