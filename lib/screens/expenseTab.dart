// ignore: file_names
// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../models/model.dart';
import '../models/yearMonthList.dart';

// ignore: must_be_immutable
class ExpenseBarCharts extends StatefulWidget {
  String selectedYear;
  ExpenseBarCharts({super.key, required this.selectedYear});

  @override
  State<ExpenseBarCharts> createState() => _ExpenseBarChartsState();
}

class _ExpenseBarChartsState extends State<ExpenseBarCharts> {
  Color fixedExpColor = Colors.red;
  Color variableExpColor = Colors.blue;
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
  List<List> monthExpenseFXL = [];
  List<Expense> expenseSQFL = [];
  List<Expense> expenseMonthly = [];
  loadExpenseData() async {
    expenseSQFL = await Expense().select().toList();
    expenseMonthly = [];
    monthExpenseFXL = [];
    for (var element in expenseSQFL) {
      if ((element.date!).year == int.parse(selectedYear)) {
        if ((element.date!).month == int.parse(selectedMonth)) {
          expenseMonthly.add(element);
        }
      }
    }
    monthExpenseFXL.add([
      'ExpenseId',
      'ExpesseName',
      'Amount',
      'Type',
      'Date',
    ]);
    for (var ele in expenseMonthly) {
      monthExpenseFXL.add([
        ele.id,
        ele.name,
        ele.amount,
        ele.type,
        DateFormat('yyy-MM-dd').format(ele.date!)
      ]);
    }
    setState(() {});
  }

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

  List<String> expenseTbleRows = [];
  List<Map> expenseItemMap = [];
  String expenseSheetName = "Sheet1"; // Expense
  int expenseColuNum = 4;
  var expenseSelectedExcel;

  // This function is just to pick XL file from folder
  pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
    if (result != null) {
      File xlFile = File(result.files.single.path!);
      var bytes = xlFile.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      expenseSelectedExcel = excel;
      getList();
    } else {
      // snacbar here
      print("No file selected");
    }
  }

  // This funtion is to process the given file and convert it into Map type
  getList() {
    expenseTbleRows.clear();
    expenseItemMap.clear();
    if (expenseSelectedExcel[expenseSheetName].rows.length <= 1) {
      // snackbar here
      print("Row number is less than 1");
    } else {
      for (var i = 1;
          i < expenseSelectedExcel[expenseSheetName].rows.length;
          i++) {
        for (var row in expenseSelectedExcel[expenseSheetName].rows[i]) {
          expenseTbleRows.add(row.value.toString());
        }
      }
      for (var i = 0; i < expenseTbleRows.length; i += expenseColuNum) {
        expenseItemMap.add({
          "name": expenseTbleRows[i + 0],
          "amount": expenseTbleRows[i + 1],
          "type": expenseTbleRows[i + 2],
          "date": expenseTbleRows[i + 3],
        });
        print('date');
        print(expenseTbleRows[i + 3]);
      }
      for (var ele in expenseItemMap) {
        saveExpense(ele);
      }
    }
    setState(() {});
  }

  // to save the loaded data to database
  saveExpense(ele) async {
    Expense expenseSQFList = Expense();
    expenseSQFList.name = ele['name'];
    expenseSQFList.amount = double.parse(ele['amount']);
    expenseSQFList.type = ele['type'];
    expenseSQFList.date = DateTime.parse(ele['date']);
    await expenseSQFList.save();
    loadExpenseData();
  }

  @override
  void initState() {
    loadExpenseData();
    // dbHelper.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController expensesNameCont = TextEditingController();
    TextEditingController expenseAmountCont = TextEditingController();
    DateFormat dateFormat = DateFormat("yyyy/MM/dd");
    DateTime expenseDateCont = DateTime.now();
    int? _currentSelection = 0;
    fixedMonthlyExpense = 0;
    variableMonthlyExpense = 0;
    monthlyExpense = [];
    fixedExpenseData = [];
    variableExpenseData = [];
    double monthlyFixedCost = 0;
    double monthlyVariableCost = 0;
    for (var ele in expenseMonthly) {
      if (ele.type == "Fixed") {
        monthlyFixedCost += ele.amount!;
        fixedExpenseData.add(FixedVariableData(ele.name!, ele.amount!));
        fixedMonthlyExpense = (fixedMonthlyExpense + ele.amount!).toInt();
      } else if (ele.type == "Variable") {
        print(ele.amount);
        monthlyVariableCost += ele.amount!;
        variableExpenseData.add(FixedVariableData(ele.name!, ele.amount!));
        variableMonthlyExpense = (variableMonthlyExpense + ele.amount!).toInt();
      }
    }
    // ###################
    // ###################
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
            onPressed: () async {
              var excel = Excel.createExcel();
              var sheetMExpense = excel['Sheet1'];
              for (var ele in monthExpenseFXL) {
                sheetMExpense.appendRow(ele);
              }
              String outPutFile =
                  "/storage/emulated/0/Download/Expense_Month-${selectedMonth}_Year-$selectedYear.xlsx";
              List<int>? fileBytes = excel.save();
              var res = await Permission.storage.request();
              if (res.isGranted) {
                if (fileBytes != null) {
                  File(Path.join(outPutFile))
                    ..createSync(recursive: true)
                    ..writeAsBytesSync(fileBytes);
                  // here snackbar to tell the file name
                  print("Saved");
                }
              }
            },
            icon: const Icon(Icons.file_upload_outlined),
          ),
          IconButton(
              onPressed: () {
                pickFile();
              },
              icon: const Icon(Icons.file_present)),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // ignore: prefer_const_constructors
                  return AlertDialog(
                    title: const Text('Add Expense'),
                    backgroundColor: Colors.black54,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Expenses'),
                        TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: expensesNameCont,
                          decoration:
                              const InputDecoration(hintText: 'Expenses Name'),
                        ),
                        const SizedBox(height: 10),
                        const Text('Amount'),
                        TextFormField(
                          controller: expenseAmountCont,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: 'Amount'),
                        ),
                        const SizedBox(height: 10),
                        const Text('Type'),
                        const SizedBox(height: 10),
                        CupertinoSlidingSegmentedControl(
                          groupValue: _currentSelection,
                          padding: const EdgeInsets.all(5),
                          // backgroundColor: CupertinoColors.white,
                          // thumbColor: Color.fromARGB(255, 255, 20, 110),
                          thumbColor: Colors.redAccent,
                          children: const {
                            0: Text("Fixed"),
                            1: Text("Variable"),
                          },
                          onValueChanged: (value) {
                            setState(() {
                              _currentSelection = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Expense Date'),
                        const SizedBox(
                          height: 10,
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
                                expenseDateCont = date;
                                print('confirm $date');
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  // dbHelper.insertExpenses(type, name, amount, date)
                                  String typeOfExpen = "Fixed";
                                  if (_currentSelection == 1) {
                                    typeOfExpen = "Variable";
                                  }
                                  Expense expenseSQF = Expense();
                                  expenseSQF.name = expensesNameCont.text;
                                  expenseSQF.type = typeOfExpen;
                                  expenseSQF.amount =
                                      double.parse(expenseAmountCont.text);
                                  expenseSQF.date = expenseDateCont;
                                  await expenseSQF.save();
                                  loadExpenseData();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "New Expese Added",
                                      ),
                                    ),
                                  );

                                  _currentSelection = 1;
                                  expensesNameCont.text = "";
                                  expenseAmountCont.text = "";
                                  expenseDateCont = DateTime.now();
                                  Navigator.of(context, rootNavigator: true)
                                      .pop("dialog");
                                },
                                child: const Text('Save New Expense'))
                          ],
                        )
                      ],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                              color: Color.fromARGB(255, 255, 20, 110),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 4,
                            )
                          ],
                        ),
                        // This is year drop down from 2022-2030
                        child: DropdownButton(
                          value: selectedYear,
                          onChanged: (String? newValue) {
                            loadExpenseData();
                            if (mounted) {
                              setState(() {
                                selectedYear = newValue!;
                              });
                            }
                          },
                          items: myYear.map((data) {
                            return DropdownMenuItem(
                                value: data, child: Text(data));
                          }).toList(),
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
                              color: Color.fromARGB(255, 255, 20, 110),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 4,
                            )
                          ],
                        ),
                        // this is for month drop downs
                        child: DropdownButton(
                            value: selectedMonth,
                            onChanged: (String? newValue) {
                              loadExpenseData();
                              if (mounted) {
                                setState(() {
                                  selectedMonth = newValue!;
                                });
                              }
                            },
                            items: myDefinefMonth.map((data) {
                              return DropdownMenuItem(
                                  value: data.numr, child: Text(data.accr));
                            }).toList()),
                      ),
                    ],
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
                                      expenseMonthly.sort((a, b) => num.parse(
                                              a.name.toString())
                                          .compareTo(
                                              num.parse(b.name.toString())));
                                      if (!_sortAsc) {
                                        expenseMonthly.sort((a, b) => (b.name
                                                .toString())
                                            .compareTo((a.name.toString())));
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
                                      expenseMonthly.sort((a, b) => num.parse(
                                              a.amount.toString())
                                          .compareTo(
                                              num.parse(b.amount.toString())));
                                      if (!_sortAsc) {
                                        expenseMonthly.sort((a, b) =>
                                            num.parse(b.amount.toString())
                                                .compareTo(num.parse(
                                                    a.amount.toString())));
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
                                      expenseMonthly.sort((a, b) => a.type
                                          .toString()
                                          .compareTo(b.type.toString()));
                                      if (!_sortAsc) {
                                        expenseMonthly.sort((a, b) => b.type
                                            .toString()
                                            .compareTo(a.type.toString()));
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
                                      expenseMonthly.sort((a, b) => num.parse(
                                              a.date.toString())
                                          .compareTo(
                                              num.parse(b.date.toString())));
                                      if (!_sortAsc) {
                                        expenseMonthly.sort((a, b) => num.parse(
                                                b.date.toString())
                                            .compareTo(
                                                num.parse(a.date.toString())));
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Total Expense',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text("\$ ${monthlyVariableCost + monthlyFixedCost}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Variable: \$ $monthlyVariableCost',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Fixed: \$ $monthlyFixedCost',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600))
                          ],
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
                      // color: Colors.deepPurple,
                      color: Colors.black26,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 20, 110),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ],

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
                      // color: Colors.deepOrange,
                      color: Colors.black26,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 20, 110),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ],
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
              ExpenseBarCharts(selectedYear: selectedYear),
            ],
          ),
        ]),
      ),
    );
  }

  TextEditingController expenseNameUpdate = TextEditingController();
  TextEditingController expenseAmountUpdate = TextEditingController();
  TextEditingController expenseTypeUpdate = TextEditingController();
  DateTime expenseDateUpdate = DateTime.now();

  // And this is the table to list expenses for given month and year
  List<DataRow> _exepensesRows() {
    return expenseMonthly
        .map(
          (data) => DataRow(
            onLongPress: () {
              expenseNameUpdate.text = data.name.toString();
              expenseAmountUpdate.text = data.amount.toString();
              expenseTypeUpdate.text = data.type.toString();
              expenseDateUpdate = data.date!;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // ignore: prefer_const_constructors
                  return AlertDialog(
                    scrollable: true,
                    title: const Text('Expense'),
                    backgroundColor: Colors.black54,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Expense Id"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(data.id.toString(),
                            style: const TextStyle(color: Colors.blue)),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Name"),
                        TextFormField(
                          controller: expenseNameUpdate,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Amount"),
                        TextFormField(controller: expenseAmountUpdate),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Type (change needed!)"),
                        TextFormField(controller: expenseTypeUpdate),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Date"),
                        TextButton(
                          child: Text(
                              DateFormat().add_yMd().format(expenseDateUpdate)),
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2022, 1, 1),
                                maxTime: DateTime(2030, 12, 30),
                                theme: const DatePickerTheme(
                                  headerColor: Colors.black,
                                  backgroundColor: Colors.black,
                                  itemStyle: TextStyle(color: Colors.white),
                                  doneStyle: TextStyle(color: Colors.white),
                                  cancelStyle: TextStyle(color: Colors.white),
                                ), onConfirm: (date) {
                              expenseDateUpdate = date;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                data.name = expenseNameUpdate.text;
                                data.amount =
                                    double.parse(expenseAmountUpdate.text);
                                data.type = expenseTypeUpdate.text;
                                data.date = expenseDateUpdate;
                                await data.save();
                                loadExpenseData();
                                Navigator.of(context, rootNavigator: true)
                                    .pop("dialog");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Expesnse Updated Successfully",
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Update"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await Expense()
                                    .select()
                                    .id
                                    .equals(data.id)
                                    .delete();
                                loadExpenseData();
                                Navigator.of(context, rootNavigator: true)
                                    .pop("dialog");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Expense Deleted Successfully",
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
            cells: [
              DataCell(Text(data.id.toString())),
              DataCell(Text(data.name.toString())),
              DataCell(Text(data.amount.toString())),
              DataCell(Text(data.type.toString())),
              DataCell(Text(DateFormat('yyyy-MM-dd').format(data.date!))),
            ],
          ),
        )
        .toList();
  }
}
