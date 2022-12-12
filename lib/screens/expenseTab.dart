// ignore: file_names
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../models/expenses.dart';

class ExpenseBarChart extends StatelessWidget {
  ExpenseBarChart(this.selectedYear);
  final String selectedYear;
  static const fixedExpColor = Colors.red;
  static const variableExpColor = Colors.blue;
  static const betweenSpace = 200;
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
          width: 10,
        ),
        BarChartRodData(
          fromY: fixe + betweenSpace,
          toY: fixe + betweenSpace + variabl,
          color: variableExpColor,
          width: 10,
        ),
      ],
    );
  }

  Color expensePrimaryColor = const Color.fromARGB(255, 255, 20, 110);
  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Color.fromARGB(255, 187, 187, 187),
        fontSize: 12,
        fontWeight: FontWeight.w500);
    String text;
    switch (value.toInt()) {
      case 01:
        text = 'Jan';
        break;
      case 02:
        text = 'Feb';
        break;
      case 03:
        text = 'Mar';
        break;
      case 04:
        text = 'Apr';
        break;
      case 05:
        text = 'May';
        break;
      case 06:
        text = 'Jun';
        break;
      case 07:
        text = 'Jul';
        break;
      case 08:
        text = 'Aug';
        break;
      case 09:
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
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  double JanFixed = 0;
  double JanVariable = 0;
  double FebFixed = 0;
  double FebVariable = 0;
  double MarFixed = 0;
  double MarVariable = 0;
  double AprFixed = 0;
  double AprVariable = 0;
  double MayFixed = 0;
  double MayVariable = 0;
  double JunFixed = 0;
  double JunVariable = 0;
  double JulFixed = 0;
  double JulVariable = 0;
  double AugFixed = 0;
  double AugVariable = 0;
  double SepFixed = 0;
  double SepVariable = 0;
  double OctFixed = 0;
  double OctVariable = 0;
  double NovFixed = 0;
  double NovVariable = 0;
  double DecFixed = 0;
  double DecVariable = 0;

  List<BarChartGroupData> monthExpenses = [];
  // String year = '2022';
  @override
  Widget build(BuildContext context) {
    for (var element in expenses) {
      if (element.date.substring(6, 10) == selectedYear) {
        if (element.date.substring(3, 5) == '01') {
          element.fixed == true
              ? JanFixed += element.amount
              : JanVariable += element.amount;
        } else if (element.date.substring(3, 5) == '02') {
          element.fixed == true
              ? FebFixed += element.amount
              : FebVariable += element.amount;
        } else if (element.date.substring(3, 5) == '03') {
          element.fixed == true
              ? MarFixed += element.amount
              : MarVariable += element.amount;
        } else if (element.date.substring(3, 5) == '04') {
          element.fixed == true
              ? AprFixed += element.amount
              : AprVariable += element.amount;
        } else if (element.date.substring(3, 5) == '05') {
          element.fixed == true
              ? MayFixed += element.amount
              : MayVariable += element.amount;
        } else if (element.date.substring(3, 5) == '06') {
          element.fixed == true
              ? JunFixed += element.amount
              : JunVariable += element.amount;
        } else if (element.date.substring(3, 5) == '07') {
          element.fixed == true
              ? JulFixed += element.amount
              : JulVariable += element.amount;
        } else if (element.date.substring(3, 5) == '08') {
          element.fixed == true
              ? AugFixed += element.amount
              : AugVariable += element.amount;
        } else if (element.date.substring(3, 5) == '09') {
          element.fixed == true
              ? SepFixed += element.amount
              : SepVariable += element.amount;
        } else if (element.date.substring(3, 5) == '10') {
          element.fixed == true
              ? OctFixed += element.amount
              : OctVariable += element.amount;
        } else if (element.date.substring(3, 5) == '11') {
          element.fixed == true
              ? NovFixed += element.amount
              : NovVariable += element.amount;
        } else if (element.date.substring(3, 5) == '12') {
          element.fixed == true
              ? DecFixed += element.amount
              : DecVariable += element.amount;
        }
        monthExpenses = [
          generateGroupData(01, JanFixed, JanVariable),
          generateGroupData(02, FebFixed, FebVariable),
          generateGroupData(03, MarFixed, MarVariable),
          generateGroupData(04, AprFixed, AprVariable),
          generateGroupData(05, MayFixed, MayVariable),
          generateGroupData(06, JunFixed, JunVariable),
          generateGroupData(07, JulFixed, JulVariable),
          generateGroupData(08, AugFixed, AugVariable),
          generateGroupData(09, SepFixed, SepVariable),
          generateGroupData(10, OctFixed, OctVariable),
          generateGroupData(11, NovFixed, NovVariable),
          generateGroupData(12, DecFixed, DecVariable),
        ];
      }
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 5, 7, 10),
      decoration: const BoxDecoration(
        color: Colors.black26,
        // color: Colors.indigo,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 255, 20, 110),
            blurStyle: BlurStyle.outer,
            blurRadius: 5,
          )
        ],
      ),
      child: Padding(
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
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            // LegendWidget(),
            Container(
              height: 200,
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
                        reservedSize: 20,
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: const Color.fromARGB(255, 40, 40, 40),
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
      ),
    );
  }
}

class ExpensesTab extends StatefulWidget {
  const ExpensesTab({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpensesTab> createState() => _ExpensesTabState();
}

class FixedVariableData {
  FixedVariableData(
    this.x,
    this.y,
    // this.color,
  );
  final String x;
  final double y;
  // final Color color;
}

class _ExpensesTabState extends State<ExpensesTab> {
  bool _sortExpenseName = true;
  bool _sortExpenseAmount = true;
  bool _sortExpenseFixed = true;
  bool _sortExpenseDate = true;
  bool _sortAsc = true;
  int _sortColumnIndex = 0;
  int fixedExpenses = 0;
  // ignore: use_function_type_syntax_for_parameters
  String selectedMonth =
      (DateFormat().add_M().format(DateTime.now())).toString();
  String selectedYear =
      (DateFormat().add_y().format(DateTime.now())).toString();
  List monthlyExpense = [];
  int fixedMonthlyExpense = 0;
  int variableMonthlyExpense = 0;
  List<FixedVariableData> fixedExpenseData = [];
  List<FixedVariableData> variableExpenseData = [];
  @override
  Widget build(BuildContext context) {
    fixedMonthlyExpense = 0;
    variableMonthlyExpense = 0;
    monthlyExpense = [];
    fixedExpenseData = [];
    variableExpenseData = [];
    for (var element in expenses) {
      // here also the year must be checked
      if (element.date.substring(3, 5) == selectedMonth &&
          element.date.substring(6, 10) == selectedYear) {
        monthlyExpense.add(element);
      }
    }
    for (var ele in monthlyExpense) {
      if (ele.fixed == true) {
        fixedExpenseData.add(FixedVariableData(ele.name, ele.amount));
        fixedMonthlyExpense = (fixedMonthlyExpense + ele.amount).toInt();
      } else {
        variableExpenseData.add(FixedVariableData(ele.name, ele.amount));
        variableMonthlyExpense = (variableMonthlyExpense + ele.amount).toInt();
      }
    }
    // int fixedExpensesPercent = fixedMonthlyExpense.length;
    List<FixedVariableData> expensesType = [
      FixedVariableData(
          "Fixed", fixedMonthlyExpense == 0 ? 0 : fixedMonthlyExpense.toDouble()
          // Colors.red,
          ),
      FixedVariableData("Variable",
          variableMonthlyExpense == 0 ? 0 : variableMonthlyExpense.toDouble()
          // Colors.blue,
          )
    ];

    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // ignore: prefer_const_constructors
                  return AlertDialog(
                    title: const Text('Add Expense'),
                    backgroundColor: Colors.black87,
                    content: SizedBox(
                      height: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Expenses'),
                                TextFormField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  onChanged: ((value) {}),
                                  decoration: const InputDecoration(
                                      hintText: 'Expenses Name'),
                                )
                              ]),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Amount'),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    const InputDecoration(hintText: 'Amount'),
                              ),
                            ],
                          ),
                          TextButton(
                            child: Text(
                              DateFormat().add_yMd().format(DateTime.now()),
                              style: const TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime(2022, 1, 1),
                                maxTime: DateTime(2030, 12, 30),
                                theme: const DatePickerTheme(
                                  headerColor: Colors.black,
                                  backgroundColor: Colors.black,
                                  itemStyle: TextStyle(color: Colors.white),
                                  doneStyle: TextStyle(color: Colors.white),
                                  cancelStyle: TextStyle(color: Colors.white),
                                ),
                                onConfirm: (date) {
                                  print('confirm $date');
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 7, top: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      // color: Colors.purple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        bottomLeft: Radius.circular(14),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 20, 110),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ],
                    ),
                    child: DropdownButton(
                      value: selectedYear,
                      onChanged: (String? newValue) {
                        if (mounted) {
                          setState(() {
                            selectedYear = newValue!;
                          });
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: '2022',
                          child: Text('2022'),
                        ),
                        DropdownMenuItem(
                          value: '2023',
                          child: Text('2023'),
                        ),
                        DropdownMenuItem(
                          value: '2024',
                          child: Text('2024'),
                        ),
                        DropdownMenuItem(
                          value: '2025',
                          child: Text('2025'),
                        ),
                        DropdownMenuItem(
                          value: '2026',
                          child: Text('2026'),
                        ),
                        DropdownMenuItem(
                          value: '2027',
                          child: Text('2027'),
                        ),
                        DropdownMenuItem(
                          value: '2028',
                          child: Text('2028'),
                        ),
                        DropdownMenuItem(
                          value: '2029',
                          child: Text('2029'),
                        ),
                        DropdownMenuItem(
                          value: '2030',
                          child: Text('2030'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 12, bottom: 7, right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      // color: Colors.purple,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 20, 110),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ],
                      // border: Border(
                      //   top: BorderSide(
                      //     color: Colors.redAccent,
                      //     width: 1.1,
                      //   ),
                      // ),
                    ),
                    child: DropdownButton(
                      value: selectedMonth,
                      onChanged: (String? newValue) {
                        if (mounted) {
                          setState(() {
                            selectedMonth = newValue!;
                          });
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: '01',
                          child: Text('Jan'),
                        ),
                        DropdownMenuItem(
                          value: '02',
                          child: Text('Feb'),
                        ),
                        DropdownMenuItem(
                          value: '03',
                          child: Text('Mar'),
                        ),
                        DropdownMenuItem(
                          value: '04',
                          child: Text('Apr'),
                        ),
                        DropdownMenuItem(
                          value: '05',
                          child: Text('May'),
                        ),
                        DropdownMenuItem(
                          value: '06',
                          child: Text('Jun'),
                        ),
                        DropdownMenuItem(
                          value: '07',
                          child: Text('Jul'),
                        ),
                        DropdownMenuItem(
                          value: '08',
                          child: Text('Aug'),
                        ),
                        DropdownMenuItem(
                          value: '09',
                          child: Text('Sep'),
                        ),
                        DropdownMenuItem(
                          value: '10',
                          child: Text('Oct'),
                        ),
                        DropdownMenuItem(
                          value: '11',
                          child: Text('Nov'),
                        ),
                        DropdownMenuItem(
                          value: '12',
                          child: Text('Dec'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  // color: Colors.amber
                  color: Colors.black26,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 20, 110),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('Monthly Expenses'),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color.fromARGB(255, 255, 20, 110),
                            // width: 1.5,
                          ),
                        ),
                      ),
                      height: 300,
                      child: ListView(children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            showBottomBorder: true,
                            sortColumnIndex: _sortColumnIndex,
                            sortAscending: _sortAsc,
                            columns: [
                              const DataColumn(
                                  label: Text('Id'), numeric: true),
                              DataColumn(
                                label: const Text('Expense'),
                                onSort: ((columnIndex, sortAscending) {
                                  if (mounted) {
                                    setState(() {
                                      if (columnIndex == _sortColumnIndex) {
                                        _sortAsc =
                                            _sortExpenseName = sortAscending;
                                      } else {
                                        _sortColumnIndex = columnIndex;
                                        _sortAsc = _sortExpenseName;
                                      }
                                      expenses.sort(
                                          (a, b) => a.name.compareTo(b.name));
                                      if (!_sortAsc) {
                                        expenses.sort(
                                            (a, b) => b.name.compareTo(a.name));
                                      }
                                    });
                                  }
                                }),
                              ),
                              DataColumn(
                                label: const Text('Amount'),
                                numeric: true,
                                onSort: (columnIndex, sortAscending) {
                                  if (mounted) {
                                    setState(() {
                                      if (columnIndex == _sortColumnIndex) {
                                        _sortAsc =
                                            _sortExpenseAmount = sortAscending;
                                      } else {
                                        _sortColumnIndex = columnIndex;
                                        _sortAsc = _sortExpenseAmount;
                                      }
                                      expenses.sort((a, b) =>
                                          a.amount.compareTo(b.amount));
                                      if (!_sortAsc) {
                                        expenses.sort((a, b) =>
                                            b.amount.compareTo(a.amount));
                                      }
                                    });
                                  }
                                },
                              ),
                              DataColumn(
                                label: const Text('Fixed'),
                                onSort: (columnIndex, sortAscending) {
                                  if (mounted) {
                                    setState(() {
                                      if (columnIndex == _sortColumnIndex) {
                                        _sortAsc =
                                            _sortExpenseFixed = sortAscending;
                                      } else {
                                        _sortColumnIndex = columnIndex;
                                        _sortAsc = _sortExpenseFixed;
                                      }
                                      expenses.sort((a, b) => a.fixed
                                          .toString()
                                          .compareTo(b.fixed.toString()));
                                      if (!_sortAsc) {
                                        expenses.sort((a, b) => b.fixed
                                            .toString()
                                            .compareTo(a.fixed.toString()));
                                      }
                                    });
                                  }
                                },
                              ),
                              DataColumn(
                                label: const Text('Date'),
                                onSort: (columnIndex, sortAscending) {
                                  if (mounted) {
                                    setState(() {
                                      if (columnIndex == _sortColumnIndex) {
                                        _sortAsc =
                                            _sortExpenseDate = sortAscending;
                                      } else {
                                        _sortColumnIndex = columnIndex;
                                        _sortAsc = _sortExpenseDate;
                                      }
                                      expenses.sort(
                                          (a, b) => a.date.compareTo(b.date));
                                      if (!_sortAsc) {
                                        expenses.sort(
                                            (a, b) => b.date.compareTo(a.date));
                                      }
                                    });
                                  }
                                },
                              ),
                            ],
                            rows: _exepensesRows(),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              // this is for Circular Pie Chart(to compare fixed and variable expenses)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 185,
                    height: 300,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      // color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 20, 110),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Column(
                      children: const [
                        Text(
                          'Total Expense',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 185,
                    decoration: const BoxDecoration(
                      // color: Colors.pinkAccent,
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 20, 110),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: SfCircularChart(
                      title: ChartTitle(text: 'Expenses Type'),
                      legend: Legend(
                        position: LegendPosition.auto,
                        isVisible: true,
                        isResponsive: false,
                        overflowMode: LegendItemOverflowMode.wrap,
                        shouldAlwaysShowScrollbar: false,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CircularSeries>[
                        PieSeries<FixedVariableData, String>(
                          dataSource: expensesType,
                          // pointColorMapper: (FixedVariableData data, _) => data.color,
                          xValueMapper: (FixedVariableData data, _) => data.x,
                          yValueMapper: (FixedVariableData data, _) => data.y,
                          explode: true,
                          explodeIndex: 1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: 185,
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: SfCircularChart(
                      title: ChartTitle(text: 'Fixed Expenses'),
                      legend: Legend(
                        position: LegendPosition.auto,
                        isVisible: true,
                        isResponsive: false,
                        overflowMode: LegendItemOverflowMode.wrap,
                        shouldAlwaysShowScrollbar: false,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CircularSeries>[
                        DoughnutSeries<FixedVariableData, String>(
                          dataSource: fixedExpenseData,
                          // pointColorMapper: (FixedVariableData data, _) => data.color,
                          xValueMapper: (FixedVariableData data, _) => data.x,
                          yValueMapper: (FixedVariableData data, _) => data.y,
                          enableTooltip: true,
                          explode: true,
                          explodeIndex: 1,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 185,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: SfCircularChart(
                      title: ChartTitle(text: 'Variable Expenses'),
                      legend: Legend(
                        position: LegendPosition.auto,
                        isVisible: true,
                        isResponsive: false,
                        overflowMode: LegendItemOverflowMode.wrap,
                        shouldAlwaysShowScrollbar: false,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CircularSeries>[
                        DoughnutSeries<FixedVariableData, String>(
                          dataSource: variableExpenseData,
                          // pointColorMapper: (FixedVariableData data, _) => data.color,
                          enableTooltip: true,
                          xValueMapper: (FixedVariableData data, _) => data.x,
                          yValueMapper: (FixedVariableData data, _) => data.y,
                          explode: true,
                          explodeIndex: 1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              ExpenseBarChart(selectedYear),
            ],
          ),
        ]),
      ),
    );
  }

  List<DataRow> _exepensesRows() {
    return monthlyExpense
        .map(
          (e) => DataRow(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // ignore: prefer_const_constructors
                  return AlertDialog(
                    title: const Text('Expense'),
                    backgroundColor: Colors.black54,
                    content: SizedBox(
                      height: 400,
                      child: Column(),
                    ),
                  );
                },
              );
            },
            cells: [
              DataCell(Text(e.id.toString())),
              DataCell(Text(e.name)),
              DataCell(Text(e.amount.toString())),
              DataCell(Text(e.fixed.toString())),
              DataCell(Text(e.date))
            ],
          ),
        )
        .toList();
  }
}
