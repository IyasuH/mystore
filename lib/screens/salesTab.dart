// ignore: file_names
// ignore_for_file: non_constant_identifier_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../models/sales.dart';
import 'homeTab.dart';
import 'package:intl/intl.dart';

class SalesBarChart extends StatelessWidget {
  SalesBarChart(this.selectedYear, {super.key});
  final String selectedYear;
  static const salesColor = Color.fromRGBO(0, 188, 212, 1);
  // static const betweenSapce = 200;
  BarChartGroupData generateGroupData(
    int x,
    double sales,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          toY: sales,
          fromY: 0,
          color: salesColor,
          width: 10,
        )
      ],
    );
  }

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

  double JanSales = 0;
  double FebSales = 0;
  double MarSales = 0;
  double AprSales = 0;
  double MaySales = 0;
  double JunSales = 0;
  double JulSales = 0;
  double AugSales = 0;
  double SepSales = 0;
  double OctSales = 0;
  double NovSales = 0;
  double DecSales = 0;

  List<BarChartGroupData> monthSales = [];
  @override
  Widget build(BuildContext context) {
    for (var element in sales) {
      if (element.soldDate.substring(6, 10) == selectedYear) {
        if (element.soldDate.substring(3, 5) == '01') {
          JanSales += element.salesRevenu;
        } else if (element.soldDate.substring(3, 5) == '02') {
          FebSales += element.salesRevenu;
        } else if (element.soldDate.substring(3, 5) == '03') {
          MarSales += element.salesRevenu;
        } else if (element.soldDate.substring(3, 5) == '04') {
          AprSales += element.salesRevenu;
        } else if (element.soldDate.substring(3, 5) == '05') {
          MaySales += element.salesRevenu;
        } else if (element.soldDate.substring(3, 5) == '06') {
          JunSales += element.salesRevenu;
        } else if (element.soldDate.substring(3, 5) == '07') {
          JulSales += element.salesRevenu;
        } else if (element.soldDate.substring(3, 5) == '08') {
          AugSales += element.salesRevenu;
        } else if (element.soldDate.substring(3, 5) == '09') {
          SepSales += element.salesRevenu;
        } else if (element.soldDate.substring(3, 5) == '10') {
          OctSales += element.salesRevenu;
        } else if (element.soldDate.substring(3, 5) == '11') {
          NovSales += element.salesRevenu;
        } else if (element.soldDate.substring(3, 5) == '12') {
          DecSales += element.salesRevenu;
        }
        monthSales = [
          generateGroupData(01, JanSales),
          generateGroupData(02, FebSales),
          generateGroupData(03, MarSales),
          generateGroupData(04, AprSales),
          generateGroupData(05, MaySales),
          generateGroupData(06, JunSales),
          generateGroupData(07, JulSales),
          generateGroupData(08, AugSales),
          generateGroupData(09, SepSales),
          generateGroupData(10, OctSales),
          generateGroupData(11, NovSales),
          generateGroupData(12, DecSales),
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
            color: Color.fromRGBO(0, 188, 212, 1),
            blurStyle: BlurStyle.outer,
            blurRadius: 5,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: SizedBox(
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
              barGroups: monthSales,
            ),
          ),
        ),
      ),
    );
  }
}

class SalesTab extends StatefulWidget {
  const SalesTab({super.key});

  @override
  State<SalesTab> createState() => _SalesTabState();
}

class _SalesTabState extends State<SalesTab> {
  bool _sortItemName = true;
  bool _sortQunantity = true;
  bool _sortAmount = true;
  bool _sortDate = true;
  bool _sortAsc = true;
  int _sortColumnIndex = 0;
  String selectedMonth =
      (DateFormat().add_M().format(DateTime.now())).toString();
  String selectedYear =
      (DateFormat().add_y().format(DateTime.now())).toString();
  List monthlySales = [];
  @override
  Widget build(BuildContext context) {
    monthlySales = [];
    for (var element in sales) {
      if (element.soldDate.substring(3, 5) == selectedMonth &&
          element.soldDate.substring(6, 10) == selectedYear) {
        monthlySales.add(element);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Add Sales'),
                    backgroundColor: Colors.black87,
                    content: SizedBox(
                      height: 380,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            keyboardAppearance: Brightness.dark,
                            keyboardType: TextInputType.number,
                            onChanged: ((value) {}),
                            decoration:
                                const InputDecoration(hintText: 'Item Id'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            keyboardAppearance: Brightness.dark,
                            decoration:
                                const InputDecoration(hintText: 'Customer Id'),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: 'Bank Id'),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: 'Quantity'),
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
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Sales Revenue'),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            decoration:
                                const InputDecoration(hintText: 'Add Info'),
                          ),
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
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        // ignore: prefer_const_constructors
                        children: const [
                          Text(
                            'Year',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' / Month',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
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
                                color: Color.fromRGBO(0, 188, 212, 1),
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
                          margin: const EdgeInsets.only(
                              top: 12, bottom: 7, right: 10),
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
                                color: Color.fromRGBO(0, 188, 212, 1),
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
                  ],
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    // color: Colors.amber
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 188, 212, 1),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('Monthly Sales'),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color.fromRGBO(0, 188, 212, 1),
                              // width: 1.5,
                            ),
                          ),
                        ),
                        height: 300,
                        child: ListView(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                // ignore: prefer_const_literals_to_create_immutables
                                showBottomBorder: true,
                                sortColumnIndex: _sortColumnIndex,
                                sortAscending: _sortAsc,
                                columns: [
                                  const DataColumn(label: Text('Id')),
                                  DataColumn(
                                      label: Text('Item'),
                                      onSort: ((columnIndex, sortAscending) {
                                        if (mounted) {
                                          setState(() {
                                            if (columnIndex ==
                                                _sortColumnIndex) {
                                              _sortAsc =
                                                  _sortItemName = sortAscending;
                                            } else {
                                              _sortColumnIndex = columnIndex;
                                              _sortAsc = _sortItemName;
                                            }
                                            sales.sort((a, b) =>
                                                a.itemId.compareTo(b.itemId));
                                            if (!_sortAsc) {
                                              sales.sort((a, b) =>
                                                  b.itemId.compareTo(a.itemId));
                                            }
                                          });
                                        }
                                      })),
                                  DataColumn(
                                    label: const Text('Qunantity'),
                                    numeric: true,
                                    onSort: (columnIndex, sortAscending) {
                                      if (mounted) {
                                        setState(() {
                                          if (columnIndex == _sortColumnIndex) {
                                            _sortAsc =
                                                _sortQunantity = sortAscending;
                                          } else {
                                            _sortColumnIndex = columnIndex;
                                            _sortAsc = _sortQunantity;
                                          }
                                          sales.sort((a, b) => a.itemQuantity
                                              .compareTo(b.itemQuantity));
                                          if (!_sortAsc) {
                                            sales.sort((a, b) => b.itemQuantity
                                                .compareTo(a.itemQuantity));
                                          }
                                        });
                                      }
                                    },
                                  ),
                                  DataColumn(
                                    label: const Text('Amount'),
                                    numeric: true,
                                    onSort: (columnIndex, sortAscending) {
                                      if (mounted) {
                                        setState(() {
                                          if (columnIndex == _sortColumnIndex) {
                                            _sortAsc =
                                                _sortAmount = sortAscending;
                                          } else {
                                            _sortColumnIndex = columnIndex;
                                            _sortAsc = _sortAmount;
                                          }
                                          sales.sort((a, b) => a.salesRevenu
                                              .compareTo(b.salesRevenu));
                                          if (!_sortAsc) {
                                            sales.sort((a, b) => b.salesRevenu
                                                .compareTo(a.salesRevenu));
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
                                                _sortDate = sortAscending;
                                          } else {
                                            _sortColumnIndex = columnIndex;
                                            _sortAsc = _sortDate;
                                          }
                                          sales.sort((a, b) =>
                                              a.soldDate.compareTo(b.soldDate));
                                          if (!_sortAsc) {
                                            sales.sort((a, b) => b.soldDate
                                                .compareTo(a.soldDate));
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ],
                                rows: _salesRow(),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 150,
                      width: 170,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 188, 212, 1),
                            blurStyle: BlurStyle.outer,
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            '\$ 5,000',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Text(
                            'Total Sales Revenue',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'This Month',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 170,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 188, 212, 1),
                            blurStyle: BlurStyle.outer,
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            '49',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Text(
                            'Total Item Sold',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'This Month',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SalesBarChart(selectedYear),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<DataRow> _salesRow() {
    return monthlySales
        .map(
          (e) => DataRow(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // ignore: prefer_const_constructors
                  return AlertDialog(
                    title: const Text('Sales'),
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
              DataCell(Text(e.salesId.toString())),
              DataCell(Text(e.itemId.toString())),
              DataCell(Text(e.itemQuantity.toString())),
              DataCell(Text(e.salesRevenu.toString())),
              DataCell(Text(e.soldDate))
            ],
          ),
        )
        .toList();
  }
}
