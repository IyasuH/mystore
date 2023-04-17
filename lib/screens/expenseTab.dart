// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, file_names

import 'dart:io';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages, library_prefixes
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../Widgets/yearlyExpense.dart';
import '../models/model.dart';
import '../models/yearMonthList.dart';

// ignore: must_be_immutable

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
  Color fixedExpColor = const Color.fromARGB(255, 225, 129, 143);
  Color variableExpColor = const Color.fromARGB(255, 142, 159, 225);
  Color expenseShadowColor = const Color.fromARGB(255, 172, 55, 75);
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
  // ignore: prefer_typing_uninitialized_variables
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "No file selected",
          ),
        ),
      );
    }
  }

  // This funtion is to process the given file and convert it into Map type
  getList() {
    expenseTbleRows.clear();
    expenseItemMap.clear();
    if (expenseSelectedExcel[expenseSheetName].rows.length <= 1) {
      // snackbar here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Row number is less than 1",
          ),
        ),
      );
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
        // print('date');
        // print(expenseTbleRows[i + 3]);
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

  String textFieldVlidMsg = "Please enter some value";
  final _formExpenseKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    TextEditingController expensesNameCont = TextEditingController();
    TextEditingController expenseAmountCont = TextEditingController();
    DateTime expenseDateCont = DateTime.now();
    int? currentSelection = 0;
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "File saved Successfully in \n /storage/emulated/0/Download/",
                      ),
                    ),
                  );
                  // print("Saved");
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
                    scrollable: true,
                    title: const Text('Add Expense'),
                    backgroundColor: Colors.black87,
                    content: Form(
                      key: _formExpenseKey,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Expenses'),
                              TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller: expensesNameCont,
                                decoration: const InputDecoration(
                                    hintText: 'Expenses Name'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return textFieldVlidMsg;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text('Amount'),
                              TextFormField(
                                controller: expenseAmountCont,
                                keyboardType: TextInputType.number,
                                decoration:
                                    const InputDecoration(hintText: 'Amount'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return textFieldVlidMsg;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text('Type'),
                              const SizedBox(height: 10),
                              CupertinoSlidingSegmentedControl(
                                groupValue: currentSelection,
                                padding: const EdgeInsets.all(5),
                                // backgroundColor: CupertinoColors.white,
                                // thumbColor: Color.fromARGB(255, 255, 20, 110),
                                thumbColor:
                                    const Color.fromARGB(255, 172, 55, 75),
                                children: const {
                                  0: Text("Fixed"),
                                  1: Text("Variable"),
                                },
                                onValueChanged: (value) {
                                  setState(() {
                                    currentSelection = value;
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
                                      cancelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                    onConfirm: (date) {
                                      expenseDateCont = date;
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    if (_formExpenseKey.currentState!
                                        .validate()) {
                                      // dbHelper.insertExpenses(type, name, amount, date)
                                      String typeOfExpen = "Fixed";
                                      if (currentSelection == 1) {
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "New Expese Added",
                                          ),
                                        ),
                                      );

                                      currentSelection = 1;
                                      expensesNameCont.text = "";
                                      expenseAmountCont.text = "";
                                      expenseDateCont = DateTime.now();
                                      Navigator.of(context, rootNavigator: true)
                                          .pop("dialog");
                                    }
                                  },
                                  child: const Text('Save New Expense'))
                            ],
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
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          // color: Colors.purple,
                          border: Border.all(
                            color: const Color.fromARGB(255, 172, 55, 75),
                            width: 1.5,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(17),
                            bottomLeft: Radius.circular(17),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 172, 55, 75),
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
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 172, 55, 75),
                            width: 1.5,
                          ),
                          color: Colors.black45,
                          // color: Colors.purple,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(17),
                            bottomRight: Radius.circular(17),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 172, 55, 75),
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
                decoration: BoxDecoration(
                  // color: Colors.amber
                  color: Colors.black45,
                  border: Border.all(
                    color: const Color.fromARGB(255, 172, 55, 75),
                    width: 1.5,
                  ),

                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 172, 55, 75),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Monthly Expenses',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color.fromARGB(255, 172, 55, 75),
                            // width: 1.5,
                          ),
                        ),
                      ),
                      height: 320,
                      // height: screenHeight - 550,
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
                                      expenseMonthly.sort((a, b) =>
                                          (a.name!).compareTo((b.name!)));
                                      if (!_sortAsc) {
                                        expenseMonthly.sort((a, b) =>
                                            (b.name!).compareTo((a.name!)));
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
                                      expenseMonthly.sort((a, b) =>
                                          (a.amount!).compareTo((b.amount!)));
                                      if (!_sortAsc) {
                                        expenseMonthly.sort((a, b) =>
                                            (b.amount!).compareTo((a.amount!)));
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
                                      expenseMonthly.sort(
                                          (a, b) => a.type!.compareTo(b.type!));
                                      if (!_sortAsc) {
                                        expenseMonthly.sort((a, b) =>
                                            b.type!.compareTo(a.type!));
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
                                      expenseMonthly.sort((a, b) =>
                                          (a.date!).compareTo((b.date!)));
                                      if (!_sortAsc) {
                                        expenseMonthly.sort((a, b) =>
                                            (b.date!).compareTo((a.date!)));
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
                    // height: screenHeight - 570,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 172, 55, 75),
                        width: 1.5,
                      ),

                      color: Colors.black45,
                      // color: Colors.blueAccent,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 172, 55, 75),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
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
                    // height: screenHeight - 570,
                    width: 185,
                    decoration: BoxDecoration(
                      // color: Colors.pinkAccent,
                      color: Colors.black45,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: const Color.fromARGB(255, 172, 55, 75),
                        width: 1.5,
                      ),

                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 172, 55, 75),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
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
                      palette: [variableExpColor, fixedExpColor],
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
                    // height: screenHeight - 570,
                    width: 185,
                    decoration: BoxDecoration(
                      // color: Colors.deepPurple,
                      border: Border.all(
                        color: const Color.fromARGB(255, 172, 55, 75),
                        width: 1.5,
                      ),

                      color: Colors.black45,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 172, 55, 75),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ],

                      borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                      palette: [variableExpColor, fixedExpColor],
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
                    // height: screenHeight - 570,
                    width: 185,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 172, 55, 75),
                        width: 1.5,
                      ),
                      color: Colors.black45,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 172, 55, 75),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                      palette: [variableExpColor, fixedExpColor],
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 390,
                  // height: screenHeight - 500,
                  child: ExpenseBarCharts(selectedYear: selectedYear)),
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
                    backgroundColor: Colors.black87,
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
                                if (await confirm(
                                  context,
                                  title: const Text('Confirm'),
                                  content:
                                      const Text('You sure to update data?'),
                                  textOK: const Text('Yes'),
                                  textCancel: const Text('Nah'),
                                )) {
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
                                }
                              },
                              child: const Text("Update"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (await confirm(context,
                                    title: const Text('Confirm'),
                                    content: const Text('Are you sure!'),
                                    textOK: const Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                    textCancel: const Text('No'))) {
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
                                }
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
