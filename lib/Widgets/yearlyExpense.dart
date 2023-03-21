// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';

class ExpenseBarCharts extends StatefulWidget {
  String selectedYear;
  ExpenseBarCharts({super.key, required this.selectedYear});

  @override
  State<ExpenseBarCharts> createState() => _ExpenseBarChartsState();
}

class _ExpenseBarChartsState extends State<ExpenseBarCharts> {
  Color fixedExpColor = const Color.fromARGB(255, 225, 129, 143);
  Color variableExpColor = const Color.fromARGB(255, 142, 159, 225);
  int betweenSpace = 0;
  List<Expense> expenseSQFL = [];
  List<Expense> expenseYearly = [];
  loadExpenseData() async {
    expenseSQFL = await Expense().select().toList();
    print("reloading expenseSQFL");
    expenseYearly = [];
    for (var element in expenseSQFL) {
      if ((element.date!).year == int.parse(widget.selectedYear)) {
        expenseYearly.add(element);
      }
    }
    print(expenseYearly);
    setState(() {});
    build(context);
  }

  @override
  void initState() {
    loadExpenseData();
    super.initState();
  }

  BarChartGroupData generateGroupData(
    int x,
    double fixe,
    double variabl,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: fixe,
          color: fixedExpColor,
          width: 15,
        ),
        BarChartRodData(
          fromY: fixe + betweenSpace,
          toY: fixe + betweenSpace + variabl,
          color: variableExpColor,
          width: 15,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 187, 187, 187),
      fontSize: 12,
      fontWeight: FontWeight.w600,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Jan';
        break;
      case 2:
        text = 'Feb';
        break;
      case 3:
        text = 'Mar';
        break;
      case 4:
        text = 'Apr';
        break;
      case 5:
        text = 'May';
        break;
      case 6:
        text = 'Jun';
        break;
      case 7:
        text = 'Jul';
        break;
      case 8:
        text = 'Aug';
        break;
      case 9:
        text = 'Sep';
        break;
      case 10:
        text = 'Oct';
        break;
      case 11:
        text = 'Nov';
        break;
      case 12:
        text = 'Dec';
        break;
      default:
        text = '';
    }
    // then return the names of the month
    // that is being put at the bottom of the chart
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  double JanFixed = 0,
      JanVariable = 0,
      FebFixed = 0,
      FebVariable = 0,
      MarFixed = 0,
      MarVariable = 0,
      AprFixed = 0,
      AprVariable = 0,
      MayFixed = 0,
      MayVariable = 0,
      JunFixed = 0,
      JunVariable = 0,
      JulFixed = 0,
      JulVariable = 0,
      AugFixed = 0,
      AugVariable = 0,
      SepFixed = 0,
      SepVariable = 0,
      OctFixed = 0,
      OctVariable = 0,
      NovFixed = 0,
      NovVariable = 0,
      DecFixed = 0,
      DecVariable = 0;

  // This function is first to check for selected month and
  // call generateGroupData to return the 2(fixed and variable) column graph for all months
  List<BarChartGroupData> monthExpenses = [];

  @override
  Widget build(BuildContext context) {
    for (var element in expenseYearly) {
      if ((element.date!).month == 1) {
        element.type == "Fixed"
            ? JanFixed += num.parse(element.amount.toString())
            : JanVariable += num.parse(element.amount.toString());
      } else if ((element.date!).month == 2) {
        element.type == "Fixed"
            ? FebFixed += num.parse(element.amount.toString())
            : FebVariable += num.parse(element.amount.toString());
      } else if ((element.date!).month == 3) {
        element.type == "Fixed"
            ? MarFixed += num.parse(element.amount.toString())
            : MarVariable += num.parse(element.amount.toString());
      } else if ((element.date!).month == 4) {
        element.type == "Fixed"
            ? AprFixed += num.parse(element.amount.toString())
            : AprVariable += num.parse(element.amount.toString());
      } else if ((element.date!).month == 5) {
        element.type == "Fixed"
            ? MayFixed += num.parse(element.amount.toString())
            : MayVariable += num.parse(element.amount.toString());
      } else if ((element.date!).month == 6) {
        element.type == "Fixed"
            ? JunFixed += num.parse(element.amount.toString())
            : JunVariable += num.parse(element.amount.toString());
      } else if ((element.date!).month == 7) {
        element.type == "Fixed"
            ? JulFixed += num.parse(element.amount.toString())
            : JulVariable += num.parse(element.amount.toString());
      } else if ((element.date!).month == 8) {
        element.type == "Fixed"
            ? AugFixed += num.parse(element.amount.toString())
            : AugVariable += num.parse(element.amount.toString());
      } else if ((element.date!).month == 9) {
        element.type == "Fixed"
            ? SepFixed += num.parse(element.amount.toString())
            : SepVariable += num.parse(element.amount.toString());
      } else if ((element.date!).month == 10) {
        element.type == "Fixed"
            ? OctFixed += num.parse(element.amount.toString())
            : OctVariable += num.parse(element.amount.toString());
      } else if ((element.date!).month == 11) {
        element.type == "Fixed"
            ? NovFixed += num.parse(element.amount.toString())
            : NovVariable += num.parse(element.amount.toString());
      } else if ((element.date!).month == 12) {
        element.type == "Fixed"
            ? DecFixed += num.parse(element.amount.toString())
            : DecVariable += num.parse(element.amount.toString());
      }
      monthExpenses = [
        generateGroupData(1, JanFixed, JanVariable),
        generateGroupData(2, FebFixed, FebVariable),
        generateGroupData(3, MarFixed, MarVariable),
        generateGroupData(4, AprFixed, AprVariable),
        generateGroupData(5, MayFixed, MayVariable),
        generateGroupData(6, JunFixed, JunVariable),
        generateGroupData(7, JulFixed, JulVariable),
        generateGroupData(8, AugFixed, AugVariable),
        generateGroupData(9, SepFixed, SepVariable),
        generateGroupData(10, OctFixed, OctVariable),
        generateGroupData(11, NovFixed, NovVariable),
        generateGroupData(12, DecFixed, DecVariable),
      ];
      // }
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text('Legend'),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: fixedExpColor,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text('Fixed'),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 10,
                height: 10,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: variableExpColor,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text('Variable'),
              IconButton(
                  onPressed: () {
                    JanFixed = 0;
                    JanVariable = 0;
                    FebFixed = 0;
                    FebVariable = 0;
                    MarFixed = 0;
                    MarVariable = 0;
                    AprFixed = 0;
                    AprVariable = 0;
                    MayFixed = 0;
                    MayVariable = 0;
                    JunFixed = 0;
                    JunVariable = 0;
                    JulFixed = 0;
                    JulVariable = 0;
                    AugFixed = 0;
                    AugVariable = 0;
                    SepFixed = 0;
                    SepVariable = 0;
                    OctFixed = 0;
                    OctVariable = 0;
                    NovFixed = 0;
                    NovVariable = 0;
                    DecFixed = 0;
                    DecVariable = 0;
                    loadExpenseData();
                  },
                  icon: const Icon(Icons.candlestick_chart_outlined))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          // LegendWidget(),
          Expanded(
            // height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(),
                  rightTitles: AxisTitles(),
                  topTitles: AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 23,
                    ),
                  ),
                ),
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
                            style: TextStyle(
                              color: fixedExpColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                barGroups: monthExpenses,
                // maxY: 10 + (betweenSpace * 3),
              ),
            ),
          )
        ],
      ),
    );
  }
}
