// ignore_for_file: file_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyBarChart extends StatefulWidget {
  double monProfit;
  double tuesProfit;
  double wedProfit;
  double thurProfit;
  double firProfit;
  double satProfit;
  double sunProfit;

  WeeklyBarChart({
    super.key,
    required this.monProfit,
    required this.tuesProfit,
    required this.wedProfit,
    required this.thurProfit,
    required this.firProfit,
    required this.satProfit,
    required this.sunProfit,
  });

  final Color barBackgroundColor = Colors.black38;
  final Color barColor = Colors.black45;
  final Color touchedBarColor = Colors.green;

  @override
  State<StatefulWidget> createState() => WeeklyBarChartState();
}

class WeeklyBarChartState extends State<WeeklyBarChart> {
  final Duration animDuration = const Duration(milliseconds: 250);
  double totalProfit = 0;
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    totalProfit = widget.monProfit +
        widget.tuesProfit +
        widget.wedProfit +
        widget.thurProfit +
        widget.firProfit +
        widget.satProfit +
        widget.sunProfit;
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
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
                  'This Week Profit',
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
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 27,
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

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, widget.monProfit,
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, widget.tuesProfit,
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, widget.wedProfit,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, widget.thurProfit,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, widget.firProfit,
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, widget.satProfit,
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, widget.sunProfit,
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

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
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
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
                    fontSize: 16,
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
            interval: 50,
            showTitles: true,
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
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
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
