// ignore: file_names
// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, depend_on_referenced_packages, unnecessary_brace_in_string_interps
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/model.dart';
import '../models/yearMonthList.dart';
// since there is some kind of conflict with context i imported as Path
import 'package:path/path.dart' as Path;
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SalesBarChart extends StatefulWidget {
  String selectedYear;
  SalesBarChart({super.key, required this.selectedYear});

  @override
  State<SalesBarChart> createState() => _SalesBarChartState();
}

class _SalesBarChartState extends State<SalesBarChart> {
  Color salesColor = const Color.fromRGBO(0, 188, 212, 1);
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
      monthSales = [
        generateGroupData(1, JanSales),
        generateGroupData(2, FebSales),
        generateGroupData(3, MarSales),
        generateGroupData(4, AprSales),
        generateGroupData(5, MaySales),
        generateGroupData(6, JunSales),
        generateGroupData(7, JulSales),
        generateGroupData(8, AugSales),
        generateGroupData(9, SepSales),
        generateGroupData(10, OctSales),
        generateGroupData(11, NovSales),
        generateGroupData(12, DecSales),
      ];
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
            SizedBox(
              height: 205,
              width: 800,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceBetween,
                    backgroundColor: Colors.red,
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
              ]),
            ),
          ],
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
  List<Sale> saleSQFL = [];
  List<List> monthSalesFXL = [];
  List<Sale> saleMonthly = [];
  List<Item> itemSQFNAML = [];
  List<Client> clientSQFNAML = [];
  List<Bank> bankSQFNAML = [];
  loadBankDataNAM() async {
    bankSQFNAML = await Bank().select().toList();
  }

  loadClientDataNAM() async {
    clientSQFNAML = await Client().select().toList();
  }

  loadItemDataNAM() async {
    itemSQFNAML = await Item().select().toList();
  }

  List<String> salesTbleRows = [];
  List<Map> salesItemMap = [];
  String salesSheetName = "Sheet1"; // Expense
  int salesColuNum = 7;
  var salesSelectedExcel;

  // This function is just to pick XL file from folder
  pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
    if (result != null) {
      File xlFile = File(result.files.single.path!);
      var bytes = xlFile.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      salesSelectedExcel = excel;
      getList();
    } else {
      // snacbar here
      print("No file selected");
    }
  }

  // This funtion is to process the given file and convert it into Map type
  getList() {
    salesTbleRows.clear();
    salesItemMap.clear();
    if (salesSelectedExcel[salesSheetName].rows.length <= 1) {
      // snackbar here
      print("Row number is less than 1");
    } else {
      for (var i = 1; i < salesSelectedExcel[salesSheetName].rows.length; i++) {
        for (var row in salesSelectedExcel[salesSheetName].rows[i]) {
          salesTbleRows.add(row.value.toString());
        }
      }
      for (var i = 0; i < salesTbleRows.length; i += salesColuNum) {
        salesItemMap.add({
          "ItemId": int.parse(salesTbleRows[i + 0]),
          "ClientId": int.parse(salesTbleRows[i + 1]),
          "BankId": int.parse(salesTbleRows[i + 2]),
          "quantity": int.parse(salesTbleRows[i + 3]),
          "date": DateTime.parse(salesTbleRows[i + 4]),
          "revenue": double.parse(salesTbleRows[i + 5]),
          "info": salesTbleRows[i + 6],
        });
      }
      for (var ele in salesItemMap) {
        saveSales(ele);
      }
    }
    setState(() {});
  }

  // to save the loaded data to database
  saveSales(ele) async {
    // ITEM UPDATE
    // item - quantity, purchaseFreq, totPurchase
    var itemSold = await Item().select().id.equals(ele['ItemId']).toSingle();
    await Item().select().id.equals(ele['ItemId']).update({
      "quantity": itemSold!.quantity! - ele['quantity'],
      "purchaseFreq": itemSold.purchaseFreq! + ele['quantity'],
      "totPurchase": itemSold.totPurchase! + ele['revenue']
    });
    // CLIENT UPDATE
    // client - purchaseFreq, totPurchase
    var clientBuy =
        await Client().select().id.equals(ele['ClientId']).toSingle();
    await Client().select().id.equals(ele['ClientId']).update({
      "purchaseFreq": clientBuy!.purchaseFreq! + ele['quantity'],
      "totPurchase": clientBuy.totPurchase! + ele['revenue'],
    });
    // BANK UPDATE
    // bank - Amount
    var bankCredited =
        await Bank().select().id.equals(ele['BankId']).toSingle();
    await Bank()
        .select()
        .id
        .equals(ele['BankId'])
        .update({"amount": bankCredited!.amount! + ele['revenue']});
    // SALE INSERT
    // ALL
    Sale salesSQFList = Sale();
    salesSQFList.ItemId = ele['ItemId'];
    salesSQFList.ClientId = ele['ClientId'];
    salesSQFList.BankId = ele['BankId'];
    salesSQFList.quantity = ele['quantity'];
    salesSQFList.date = ele['date'];
    salesSQFList.revenue = ele['revenue'];
    salesSQFList.info = ele['info'];
    await salesSQFList.save();
    loadSaleData();
    loadBankDataNAM();
    loadClientDataNAM();
    loadItemDataNAM();
  }

  double monthlySalesRevenu = 0;
  loadSaleData() async {
    saleSQFL = await Sale().select().toList();
    saleMonthly = [];
    monthSalesFXL = [];
    monthlySalesRevenu = 0;
    for (var element in saleSQFL) {
      if ((element.date!).year == int.parse(selectedYear)) {
        if ((element.date!).month == int.parse(selectedMonth)) {
          monthlySalesRevenu += element.revenue!;
          saleMonthly.add(element);
        }
      }
    }
    monthSalesFXL.add([
      'SalesId',
      'ItemId',
      'ClientId',
      'BankId',
      'Quantity',
      'Date',
      'Revenue',
      'AddInfo'
    ]);
    for (var ele in saleMonthly) {
      monthSalesFXL.add([
        ele.id,
        ele.ItemId,
        ele.ClientId,
        ele.BankId,
        ele.quantity,
        DateFormat('yyy-MM-dd').format(ele.date!),
        ele.revenue,
        ele.info,
      ]);
    }
    setState(() {});
  }

  @override
  void initState() {
    // dbHelper.init();
    loadSaleData();
    loadItemDataNAM();
    loadClientDataNAM();
    loadBankDataNAM();
    super.initState();
  }

  // This for sake of sort
  bool _sortItemName = true;
  bool _sortQunantity = true;
  bool _sortAmount = true;
  bool _sortDate = true;
  bool _sortAsc = true;
  int _sortColumnIndex = 0;

  // This for sake of adding new sales to select item, cleint and bank ID
  // And I initailized all 1(so don't delete that)
  // Write query when deleting to avoid deleting
  //  query from DB and make the top one id here or...
  int selectedItem = 1;
  int selectedClient = 1;
  int selectedBank = 1;

  String selectedMonth =
      (DateFormat().add_M().format(DateTime.now())).toString();
  String selectedYear =
      (DateFormat().add_y().format(DateTime.now())).toString();
  // List monthlySales = [];
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    TextEditingController quantityCont = TextEditingController();
    DateTime itemSoldDateCont = DateTime.now();
    TextEditingController salesRevenu = TextEditingController();
    TextEditingController addInfoCont = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
        actions: [
          IconButton(
            onPressed: () async {
              var excel = Excel.createExcel();
              var sheetMSales = excel['Sheet1'];
              for (var ele in monthSalesFXL) {
                sheetMSales.appendRow(ele);
              }
              String outPutFile =
                  "/storage/emulated/0/Download/Sales_Month-${selectedMonth}_Year-$selectedYear.xlsx";
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
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return AlertDialog(
                      scrollable: true,
                      title: const Text('Add Sales(needs edit)'),
                      backgroundColor: Colors.black54,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Item'),
                          const SizedBox(height: 10),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                            ),
                            child: DropdownButton(
                              value: selectedItem,
                              onChanged: (int? newValue) {
                                if (mounted) {
                                  setState(() {
                                    selectedItem = newValue!;
                                  });
                                }
                              },
                              items: itemSQFNAML.map((data) {
                                return DropdownMenuItem(
                                    value: data.id,
                                    child: Text(
                                        '${data.name!}  ${data.quantity}  ${data.singlePrice}'));
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Client'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: 150,
                                decoration: const BoxDecoration(
                                  color: Colors.black26,
                                ),
                                child: DropdownButton(
                                  value: selectedClient,
                                  onChanged: (int? newValue) {
                                    if (mounted) {
                                      setState(() {
                                        selectedClient = newValue!;
                                      });
                                    }
                                  },
                                  items: clientSQFNAML.map((data) {
                                    return DropdownMenuItem(
                                        value: data.id,
                                        child: Text(
                                            '${data.name!}  ${data.companyName}'));
                                  }).toList(),
                                ),
                              ),
                              ElevatedButton(
                                child: const Text('New client'),
                                onPressed: () {},
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text('Bank'),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                            ),
                            child: DropdownButton(
                              value: selectedBank,
                              onChanged: (int? newValue) {
                                if (mounted) {
                                  setState(() {
                                    selectedBank = newValue!;
                                  });
                                }
                              },
                              items: bankSQFNAML.map((data) {
                                return DropdownMenuItem(
                                    value: data.id,
                                    child: Text(
                                        '${data.name!}  ${data.accountNumber}'));
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Quantity'),
                          TextFormField(
                            controller: quantityCont,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: 'Quantity'),
                          ),
                          const SizedBox(height: 10),
                          const Text('Sold Date'),
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
                                  print('date is $date');
                                  itemSoldDateCont = date;
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text('Price'),
                          TextFormField(
                            controller: salesRevenu,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Sales Revenue'),
                          ),
                          const SizedBox(height: 10),
                          const Text('Additional Info'),
                          TextFormField(
                            controller: addInfoCont,
                            keyboardType: TextInputType.multiline,
                            decoration:
                                const InputDecoration(hintText: 'Add Info'),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    // Before creating new row in Sales table first lets update parent tables
                                    // ITEM UPDATE
                                    // item - quantity, purchaseFreq, totPurchase
                                    var itemSold = await Item()
                                        .select()
                                        .id
                                        .equals(selectedItem)
                                        .toSingle();
                                    await Item()
                                        .select()
                                        .id
                                        .equals(selectedItem)
                                        .update({
                                      "quantity": itemSold!.quantity! -
                                          int.parse(quantityCont.text),
                                      "purchaseFreq": itemSold.purchaseFreq! +
                                          int.parse(quantityCont.text),
                                      "totPurchase": itemSold.totPurchase! +
                                          double.parse(salesRevenu.text)
                                    });
                                    // CLIENT UPDATE
                                    // client - purchaseFreq, totPurchase
                                    var clientBuy = await Client()
                                        .select()
                                        .id
                                        .equals(selectedClient)
                                        .toSingle();
                                    await Client()
                                        .select()
                                        .id
                                        .equals(selectedClient)
                                        .update({
                                      "purchaseFreq": clientBuy!.purchaseFreq! +
                                          int.parse(quantityCont.text),
                                      "totPurchase": clientBuy.totPurchase! +
                                          double.parse(salesRevenu.text),
                                    });
                                    // BANK UPDATE
                                    // bank - Amount
                                    var bankCredited = await Bank()
                                        .select()
                                        .id
                                        .equals(selectedBank)
                                        .toSingle();
                                    await Bank()
                                        .select()
                                        .id
                                        .equals(selectedBank)
                                        .update({
                                      "amount": bankCredited!.amount! +
                                          double.parse(salesRevenu.text),
                                    });
                                    // then finaly lets save the new row
                                    // SALE INSERT
                                    // ALL
                                    Sale saleSQF = Sale();
                                    saleSQF.ItemId = selectedItem;
                                    saleSQF.ClientId = selectedClient;
                                    saleSQF.BankId = selectedBank;
                                    saleSQF.quantity =
                                        int.parse(quantityCont.text);
                                    saleSQF.date = itemSoldDateCont;
                                    saleSQF.revenue =
                                        double.parse(salesRevenu.text);
                                    saleSQF.info = addInfoCont.text;
                                    await saleSQF.save();
                                    loadSaleData();
                                    loadBankDataNAM();
                                    loadClientDataNAM();
                                    loadItemDataNAM();
                                    // await Item().select().id.equals(selectedItem).update
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("New Sales info added"),
                                      ),
                                    );
                                    quantityCont.text = "";
                                    itemSoldDateCont = DateTime.now();
                                    salesRevenu.text = "";
                                    addInfoCont.text = "";
                                    Navigator.of(context, rootNavigator: true)
                                        .pop("dialog");
                                  },
                                  child: const Text('Save Sales Data'))
                            ],
                          )
                        ],
                      ),
                    );
                  });
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
                                loadSaleData();
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
                                color: Color.fromRGBO(0, 188, 212, 1),
                                blurStyle: BlurStyle.outer,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: DropdownButton(
                            value: selectedMonth,
                            onChanged: (String? newValue) {
                              loadSaleData();
                              if (mounted) {
                                setState(() {
                                  selectedMonth = newValue!;
                                });
                              }
                            },
                            items: myDefinefMonth.map((data) {
                              return DropdownMenuItem(
                                  value: data.numr, child: Text(data.accr));
                            }).toList(),
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
                                                _sortAsc = _sortItemName =
                                                    sortAscending;
                                              } else {
                                                _sortColumnIndex = columnIndex;
                                                _sortAsc = _sortItemName;
                                              }
                                              saleMonthly.sort((a, b) => num
                                                      .parse(
                                                          a.ItemId.toString())
                                                  .compareTo(num.parse(
                                                      b.ItemId.toString())));
                                              if (!_sortAsc) {
                                                saleMonthly.sort((a, b) => num
                                                        .parse(
                                                            b.ItemId.toString())
                                                    .compareTo(num.parse(
                                                        a.ItemId.toString())));
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
                                            if (columnIndex ==
                                                _sortColumnIndex) {
                                              _sortAsc = _sortQunantity =
                                                  sortAscending;
                                            } else {
                                              _sortColumnIndex = columnIndex;
                                              _sortAsc = _sortQunantity;
                                            }
                                            saleMonthly.sort((a, b) =>
                                                num.parse(a.quantity.toString())
                                                    .compareTo(num.parse(b
                                                        .quantity
                                                        .toString())));
                                            if (!_sortAsc) {
                                              saleMonthly.sort((a, b) => num
                                                      .parse(
                                                          b.quantity.toString())
                                                  .compareTo(num.parse(
                                                      a.quantity.toString())));
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
                                            if (columnIndex ==
                                                _sortColumnIndex) {
                                              _sortAsc =
                                                  _sortAmount = sortAscending;
                                            } else {
                                              _sortColumnIndex = columnIndex;
                                              _sortAsc = _sortAmount;
                                            }
                                            saleMonthly.sort((a, b) =>
                                                num.parse(a.revenue.toString())
                                                    .compareTo(num.parse(
                                                        b.revenue.toString())));
                                            if (!_sortAsc) {
                                              saleMonthly.sort((a, b) => num
                                                      .parse(
                                                          b.revenue.toString())
                                                  .compareTo(num.parse(
                                                      a.revenue.toString())));
                                            }
                                          });
                                        }
                                      },
                                    ),
                                    // date sort was causing error
                                    DataColumn(
                                      label: const Text('Date'),
                                      onSort: (columnIndex, sortAscending) {
                                        if (mounted) {
                                          setState(() {
                                            if (columnIndex ==
                                                _sortColumnIndex) {
                                              _sortAsc =
                                                  _sortDate = sortAscending;
                                            } else {
                                              _sortColumnIndex = columnIndex;
                                              _sortAsc = _sortDate;
                                            }
                                            saleMonthly.sort((a, b) =>
                                                num.parse(a.date.toString())
                                                    .compareTo(num.parse(
                                                        b.date.toString())));
                                            if (!_sortAsc) {
                                              saleMonthly.sort(
                                                (a, b) =>
                                                    num.parse(b.date.toString())
                                                        .compareTo(num.parse(
                                                            a.date.toString())),
                                              );
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
                          ))
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
                          Text(
                            '\$ $monthlySalesRevenu',
                            style: const TextStyle(
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
                          Text(
                            saleMonthly.length.toString(),
                            style: const TextStyle(
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
                SalesBarChart(selectedYear: selectedYear),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextEditingController quantityUpdate = TextEditingController();
  DateTime dateUpdate = DateTime.now();
  TextEditingController revenueUpdate = TextEditingController();
  TextEditingController addInfoUpdate = TextEditingController();

  int updatedItem = 1;
  int updatedClient = 1;
  int updatedBank = 1;
  List<DataRow> _salesRow() {
    Future<Item?> itemName;
    return saleMonthly
        .map(
          (data) => DataRow(
            onLongPress: () {
              updatedItem = data.ItemId!;
              updatedClient = data.ClientId!;
              updatedBank = data.BankId!;
              quantityUpdate.text = data.quantity.toString();
              dateUpdate = data.date!;
              revenueUpdate.text = data.revenue.toString();
              addInfoUpdate.text = data.info.toString();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return AlertDialog(
                      scrollable: true,
                      title: const Text('Sales'),
                      backgroundColor: Colors.black54,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Item Id"),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                            ),
                            child: DropdownButton(
                              value: updatedItem,
                              onChanged: (int? newValue) {
                                if (mounted) {
                                  setState(() {
                                    updatedItem = newValue!;
                                  });
                                }
                              },
                              items: itemSQFNAML.map((data) {
                                return DropdownMenuItem(
                                    value: data.id, child: Text(data.name!));
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text("Client Id"),

                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                            ),
                            child: DropdownButton(
                              value: updatedClient,
                              onChanged: (int? newValue) {
                                if (mounted) {
                                  setState(() {
                                    updatedClient = newValue!;
                                  });
                                }
                              },
                              items: clientSQFNAML.map((data) {
                                return DropdownMenuItem(
                                    value: data.id, child: Text(data.name!));
                              }).toList(),
                            ),
                          ),

                          const SizedBox(
                            height: 14,
                          ),
                          const Text("Bank Id"),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                            ),
                            child: DropdownButton(
                              value: updatedBank,
                              onChanged: (int? newValue) {
                                if (mounted) {
                                  setState(() {
                                    updatedBank = newValue!;
                                  });
                                }
                              },
                              items: bankSQFNAML.map((data) {
                                return DropdownMenuItem(
                                    value: data.id, child: Text(data.name!));
                              }).toList(),
                            ),
                          ),

                          const SizedBox(
                            height: 14,
                          ),
                          const Text("Quantity"),
                          TextFormField(
                            controller: quantityUpdate,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text("Date"),
                          // ignore: prefer_const_constructors
                          TextButton(
                            child: Text(
                              DateFormat().add_yMd().format(dateUpdate),
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
                                  dateUpdate = date;
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text("Revenue"),
                          TextFormField(
                            controller: revenueUpdate,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text("Add info"),
                          TextFormField(
                            controller: addInfoUpdate,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  // ITEM UPDATE
                                  // + quantity, - purchaseFreq, - totPurchase
                                  var itemUnsold = await Item()
                                      .select()
                                      .id
                                      .equals(data.ItemId)
                                      .toSingle();
                                  await Item()
                                      .select()
                                      .id
                                      .equals(data.ItemId)
                                      .update({
                                    "quantity":
                                        itemUnsold!.quantity! + data.quantity!,
                                    "purchaseFreq": itemUnsold.purchaseFreq! -
                                        data.quantity!,
                                    "totPurchase":
                                        itemUnsold.totPurchase! - data.revenue!,
                                  });
                                  // CLIENT UPDATE
                                  // - purchaseFreq, - totPurchase
                                  var clientUnUBuy = await Client()
                                      .select()
                                      .id
                                      .equals(data.ClientId)
                                      .toSingle();
                                  await Client()
                                      .select()
                                      .id
                                      .equals(data.ClientId)
                                      .update({
                                    "purchaseFreq":
                                        clientUnUBuy!.purchaseFreq! -
                                            data.quantity!,
                                    "totPurchase": clientUnUBuy.totPurchase! -
                                        data.revenue!,
                                  });
                                  // BANK UPDATE
                                  // - amount
                                  var bankDebited = await Bank()
                                      .select()
                                      .id
                                      .equals(data.BankId)
                                      .toSingle();
                                  await Bank()
                                      .select()
                                      .id
                                      .equals(data.BankId)
                                      .update({
                                    "amount":
                                        bankDebited!.amount! - data.revenue!,
                                  });
                                  await Sale()
                                      .select()
                                      .id
                                      .equals(data.id)
                                      .delete();
                                  loadSaleData();
                                  Navigator.of(context, rootNavigator: true)
                                      .pop("dialog");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Sale Deleted Successfully",
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Delete",
                                    style: TextStyle(color: Colors.redAccent)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
                  // ignore: prefer_const_constructors
                },
              );
            },
            cells: [
              DataCell(Text(data.id.toString())),
              // DataCell(Text(await Item().select().id.equals(data.ItemId!).toSingle().name)),
              DataCell(Text(data.ItemId.toString())),
              DataCell(Text(data.quantity.toString())),
              DataCell(Text(data.quantity.toString())),
              DataCell(Text(DateFormat('yyyy-MM-dd').format(data.date!))),
            ],
          ),
        )
        .toList();
  }
}
