// ignore_for_file: non_constant_identifier_names, file_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';

// ignore: must_be_immutable
class SalesBarChart extends StatefulWidget {
  String selectedYear;
  SalesBarChart({super.key, required this.selectedYear});

  @override
  State<SalesBarChart> createState() => _SalesBarChartState();
}

class _SalesBarChartState extends State<SalesBarChart> {
  final Duration animDuration = const Duration(milliseconds: 250);
  Color salesColor = const Color.fromRGBO(0, 188, 212, 1);
  final Color barColor = Colors.black45;
  int touchedIndex = -1;
  int betweenSapce = 0;
  List<Sale> saleSQFL = [];
  List<Sale> saleYearly = [];
  loadSaleData() async {
    saleSQFL = await Sale().select().toList();
    saleYearly = [];
    for (var element in saleSQFL) {
      if ((element.date!).year == int.parse(widget.selectedYear)) {
        saleYearly.add(element);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    loadSaleData();
    super.initState();
  }

  BarChartGroupData generateGroupData(
    int x,
    double sales, {
    bool isTouched = false,
    Color? barColor,
    double width = 18,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      // groupVertically: true,
      barRods: [
        BarChartRodData(
          toY: sales,
          color: isTouched ? salesColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.grey.shade800)
              : const BorderSide(color: Colors.white, width: 0),
        )
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Color.fromARGB(255, 187, 187, 187),
        fontSize: 12,
        fontWeight: FontWeight.w500);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  double JanSales = 0,
      FebSales = 0,
      MarSales = 0,
      AprSales = 0,
      MaySales = 0,
      JunSales = 0,
      JulSales = 0,
      AugSales = 0,
      SepSales = 0,
      OctSales = 0,
      NovSales = 0,
      DecSales = 0;

  List<BarChartGroupData> monthSales = [];
  List<BarChartGroupData> showMonthlySales() => List.generate(
        12,
        (i) {
          switch (i) {
            case 0:
              return generateGroupData(0, JanSales,
                  isTouched: i == touchedIndex);
            case 1:
              return generateGroupData(1, FebSales,
                  isTouched: i == touchedIndex);
            case 2:
              return generateGroupData(2, MarSales,
                  isTouched: i == touchedIndex);
            case 3:
              return generateGroupData(3, AprSales,
                  isTouched: i == touchedIndex);
            case 4:
              return generateGroupData(4, MaySales,
                  isTouched: i == touchedIndex);
            case 5:
              return generateGroupData(5, JunSales,
                  isTouched: i == touchedIndex);
            case 6:
              return generateGroupData(6, JulSales,
                  isTouched: i == touchedIndex);
            case 7:
              return generateGroupData(7, AugSales,
                  isTouched: i == touchedIndex);
            case 8:
              return generateGroupData(8, SepSales,
                  isTouched: i == touchedIndex);
            case 9:
              return generateGroupData(9, OctSales,
                  isTouched: i == touchedIndex);
            case 10:
              return generateGroupData(10, NovSales,
                  isTouched: i == touchedIndex);
            case 11:
              return generateGroupData(11, DecSales,
                  isTouched: i == touchedIndex);
            default:
              return throw Error();
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    for (var element in saleYearly) {
      if ((element.date!).month == 1) {
        JanSales += num.parse(element.revenue.toString());
      } else if ((element.date!).month == 2) {
        FebSales += num.parse(element.revenue.toString());
      } else if ((element.date!).month == 3) {
        MarSales += num.parse(element.revenue.toString());
      } else if ((element.date!).month == 4) {
        AprSales += num.parse(element.revenue.toString());
      } else if ((element.date!).month == 5) {
        MaySales += num.parse(element.revenue.toString());
      } else if ((element.date!).month == 6) {
        JunSales += num.parse(element.revenue.toString());
      } else if ((element.date!).month == 7) {
        JulSales += num.parse(element.revenue.toString());
      } else if ((element.date!).month == 8) {
        AugSales += num.parse(element.revenue.toString());
      } else if ((element.date!).month == 9) {
        SepSales += num.parse(element.revenue.toString());
      } else if ((element.date!).month == 10) {
        OctSales += num.parse(element.revenue.toString());
      } else if ((element.date!).month == 11) {
        NovSales += num.parse(element.revenue.toString());
      } else if ((element.date!).month == 12) {
        DecSales += num.parse(element.revenue.toString());
      }
      // HERE at leats write for loop to avoid repetation
    }
    monthSales = [
      generateGroupData(0, JanSales),
      generateGroupData(1, FebSales),
      generateGroupData(2, MarSales),
      generateGroupData(3, AprSales),
      generateGroupData(4, MaySales),
      generateGroupData(5, JunSales),
      generateGroupData(6, JulSales),
      generateGroupData(7, AugSales),
      generateGroupData(8, SepSales),
      generateGroupData(9, OctSales),
      generateGroupData(10, NovSales),
      generateGroupData(11, DecSales),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                JanSales = 0;
                FebSales = 0;
                MarSales = 0;
                AprSales = 0;
                MaySales = 0;
                JunSales = 0;
                JulSales = 0;
                AugSales = 0;
                SepSales = 0;
                OctSales = 0;
                NovSales = 0;
                DecSales = 0;
                loadSaleData();
              },
              icon: const Icon(Icons.candlestick_chart_outlined)),
          Expanded(
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: const Color.fromARGB(255, 40, 40, 40),
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
                            text: (rod.toY - 1).toString(),
                            style: const TextStyle(
                              color: Color.fromRGBO(0, 188, 212, 1),
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
                      touchedIndex =
                          barTouchResponse.spot!.touchedBarGroupIndex;
                    });
                  },
                ),

                // alignment: BarChartAlignment.spaceBetween,
                // backgroundColor: Colors.red,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 23,
                    ),
                  ),
                ),
                // barTouchData: BarTouchData(
                //   touchTooltipData: BarTouchTooltipData(
                //     tooltipBgColor: const Color.fromARGB(255, 40, 40, 40),
                //   ),
                // ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                // barGroups: showMonthlySales(),
                barGroups: monthSales,
              ),
              swapAnimationDuration: animDuration,
            ),
          ),
        ],
      ),
    );
  }
}
