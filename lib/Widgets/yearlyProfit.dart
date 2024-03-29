// ignore_for_file: file_names, unrelated_type_equality_checks, non_constant_identifier_names, must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YearlyBarChart extends StatefulWidget {
  double JanProfit;
  double FebProfit;
  double MarProfit;
  double AprProfit;
  double MayProfit;
  double JunProfit;
  double JulProfit;
  double AugProfit;
  double SepProfit;
  double OctProfit;
  double NovProfit;
  double DecProfit;
  double TotalProfit;
  YearlyBarChart({
    super.key,
    required this.AprProfit,
    required this.AugProfit,
    required this.DecProfit,
    required this.FebProfit,
    required this.JanProfit,
    required this.JulProfit,
    required this.JunProfit,
    required this.MarProfit,
    required this.MayProfit,
    required this.NovProfit,
    required this.OctProfit,
    required this.SepProfit,
    required this.TotalProfit,
  });

  final Color barBackgroundColor = Colors.black38;
  final Color barColor = Colors.black45;
  final Color touchedBarColor = Colors.green;

  @override
  State<YearlyBarChart> createState() => _YearlyBarChartState();
}

class _YearlyBarChartState extends State<YearlyBarChart> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;
  double totalProfit = 0;
  @override
  Widget build(BuildContext context) {
    // print("Is this loading!");
    double totalProfit = widget.TotalProfit;
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                '\$ $totalProfit',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                'This Year Profit',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  letterSpacing: 1.5,
                  wordSpacing: 1.8,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BarChart(
                    mainBarData(),
                    swapAnimationDuration: animDuration,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.grey.shade800)
              : const BorderSide(color: Colors.white, width: 0),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(
        12,
        (i) {
          switch (i) {
            case 0:
              return makeGroupData(0, widget.JanProfit,
                  isTouched: i == touchedIndex);
            case 1:
              return makeGroupData(1, widget.FebProfit,
                  isTouched: i == touchedIndex);
            case 2:
              return makeGroupData(2, widget.MarProfit,
                  isTouched: i == touchedIndex);
            case 3:
              return makeGroupData(3, widget.AprProfit,
                  isTouched: i == touchedIndex);
            case 4:
              return makeGroupData(4, widget.MayProfit,
                  isTouched: i == touchedIndex);
            case 5:
              return makeGroupData(5, widget.JunProfit,
                  isTouched: i == touchedIndex);
            case 6:
              return makeGroupData(6, widget.JulProfit,
                  isTouched: i == touchedIndex);
            case 7:
              return makeGroupData(7, widget.AugProfit,
                  isTouched: i == touchedIndex);
            case 8:
              return makeGroupData(8, widget.SepProfit,
                  isTouched: i == touchedIndex);
            case 9:
              return makeGroupData(9, widget.OctProfit,
                  isTouched: i == touchedIndex);
            case 10:
              return makeGroupData(10, widget.NovProfit,
                  isTouched: i == touchedIndex);
            case 11:
              return makeGroupData(11, widget.DecProfit,
                  isTouched: i == touchedIndex);
            default:
              return throw Error();
          }
        },
      );

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.black45,
          // tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -1,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'January';
                break;
              case 1:
                weekDay = 'February';
                break;
              case 2:
                weekDay = 'March';
                break;
              case 3:
                weekDay = 'April';
                break;
              case 4:
                weekDay = 'May';
                break;
              case 5:
                weekDay = 'June';
                break;
              case 6:
                weekDay = 'July';
                break;
              case 7:
                weekDay = 'August';
                break;
              case 8:
                weekDay = 'Spetember';
                break;
              case 9:
                weekDay = 'October';
                break;
              case 10:
                weekDay = 'November';
                break;
              case 11:
                weekDay = 'December';
                break;

              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              // touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: 5,
            showTitles: false,
            reservedSize: 40,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Jan', style: style);
        break;
      case 1:
        text = const Text('Feb', style: style);
        break;
      case 2:
        text = const Text('Mar', style: style);
        break;
      case 3:
        text = const Text('Apr', style: style);
        break;
      case 4:
        text = const Text('May', style: style);
        break;
      case 5:
        text = const Text('Jun', style: style);
        break;
      case 6:
        text = const Text('Jul', style: style);
        break;
      case 7:
        text = const Text('Aug', style: style);
        break;
      case 8:
        text = const Text('Spt', style: style);
        break;
      case 9:
        text = const Text('Oct', style: style);
        break;
      case 10:
        text = const Text('Nov', style: style);
        break;
      case 11:
        text = const Text('Dec', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}
