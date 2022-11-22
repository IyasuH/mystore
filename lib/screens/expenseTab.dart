import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:pie_chart/pie_chart.dart';

import '../models/expenses.dart';

class ExpensesTab extends StatefulWidget {
  const ExpensesTab({super.key});

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
  String selectedValue = "12";
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
      if (element.date.substring(3, 5) == selectedValue) {
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
    print(fixedMonthlyExpense);
    print(variableMonthlyExpense);
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
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Month'),
                  DropdownButton(
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
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
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  showBottomBorder: true,
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAsc,
                  columns: [
                    const DataColumn(label: Text('Id'), numeric: true),
                    DataColumn(
                      label: const Text('Expense'),
                      onSort: ((columnIndex, sortAscending) {
                        setState(() {
                          if (columnIndex == _sortColumnIndex) {
                            _sortAsc = _sortExpenseName = sortAscending;
                          } else {
                            _sortColumnIndex = columnIndex;
                            _sortAsc = _sortExpenseName;
                          }
                          expenses.sort((a, b) => a.name.compareTo(b.name));
                          if (!_sortAsc) {
                            expenses.sort((a, b) => b.name.compareTo(a.name));
                          }
                        });
                      }),
                    ),
                    DataColumn(
                      label: const Text('Amount'),
                      numeric: true,
                      onSort: (columnIndex, sortAscending) {
                        setState(() {
                          if (columnIndex == _sortColumnIndex) {
                            _sortAsc = _sortExpenseAmount = sortAscending;
                          } else {
                            _sortColumnIndex = columnIndex;
                            _sortAsc = _sortExpenseAmount;
                          }
                          expenses.sort((a, b) => a.amount.compareTo(b.amount));
                          if (!_sortAsc) {
                            expenses
                                .sort((a, b) => b.amount.compareTo(a.amount));
                          }
                        });
                      },
                    ),
                    DataColumn(
                      label: const Text('Fixed'),
                      onSort: (columnIndex, sortAscending) {
                        setState(() {
                          if (columnIndex == _sortColumnIndex) {
                            _sortAsc = _sortExpenseFixed = sortAscending;
                          } else {
                            _sortColumnIndex = columnIndex;
                            _sortAsc = _sortExpenseFixed;
                          }
                          expenses.sort((a, b) =>
                              a.fixed.toString().compareTo(b.fixed.toString()));
                          if (!_sortAsc) {
                            expenses.sort((a, b) => b.fixed
                                .toString()
                                .compareTo(a.fixed.toString()));
                          }
                        });
                      },
                    ),
                    DataColumn(
                      label: const Text('Date'),
                      onSort: (columnIndex, sortAscending) {
                        setState(() {
                          if (columnIndex == _sortColumnIndex) {
                            _sortAsc = _sortExpenseDate = sortAscending;
                          } else {
                            _sortColumnIndex = columnIndex;
                            _sortAsc = _sortExpenseDate;
                          }
                          expenses.sort((a, b) => a.date.compareTo(b.date));
                          if (!_sortAsc) {
                            expenses.sort((a, b) => b.date.compareTo(a.date));
                          }
                        });
                      },
                    ),
                  ],
                  rows: _exepensesRows(selectedValue),
                ),
              ),
              // this is for Circular Pie Chart(to compare fixed and variable expenses)
              SfCircularChart(
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
              SfCircularChart(
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
              SfCircularChart(
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
            ],
          ),
        ]),
      ),
    );
  }

  List<DataRow> _exepensesRows(String month) {
    monthlyExpense = [];
    for (var element in expenses) {
      if (element.date.substring(3, 5) == month) {
        monthlyExpense.add(element);
      }
    }
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
