// ignore: file_names
// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/model.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  // ignore: prefer_typing_uninitialized_variables
  List<Item> allItems = [];
  List<List> allItemsList = [];
  List<Client> allClients = [];
  List<List> allClientsList = [];
  // expense and sales data can be in month or some time bound relativel to others
  List<Expense> allExpenses = [];
  List<List> allExpensesList = [];
  List<Sale> allSales = [];
  List<List> allSalesList = [];
  loadAllSalesData() async {
    allSalesList = [];
    allSalesList.add([
      'SalesId',
      'ItemId',
      'ClientId',
      'BankId',
      'Quantity',
      'Date',
      'Revenue',
      'AddInfo'
    ]);
    allSales = await Sale().select().toList();
    for (var ele in allSales) {
      allSalesList.add([
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
  }

  loadAllExpensesData() async {
    allExpensesList = [];
    allExpensesList.add([
      'ExpenseId',
      'ExpesseName',
      'Amount',
      'Type',
      'Date',
    ]);
    allExpenses = await Expense().select().toList();
    for (var ele in allExpenses) {
      allExpensesList.add([
        ele.id,
        ele.name,
        ele.amount,
        ele.type,
        DateFormat('yyy-MM-dd').format(ele.date!)
      ]);
    }
  }

  loadAllClinetData() async {
    allClientsList = [];
    allClientsList.add([
      'ClientId',
      'ClientName',
      'CompanyName',
      'BankName',
      'BankAccountNumber',
      'TinNumber',
      'City',
      'PhoneNumber',
      'PurchaseFrqeuncy',
      'TotalPurchase',
    ]);
    allClients = await Client().select().toList();
    for (var ele in allClients) {
      allClientsList.add([
        ele.id,
        ele.name,
        ele.companyName,
        ele.bankName,
        ele.bankNumber,
        ele.tinNumber,
        ele.city,
        ele.phoneN,
        ele.purchaseFreq,
        ele.totPurchase
      ]);
    }
  }

  loadAllItemsData() async {
    allItemsList = [];
    allItemsList.add([
      'ItemId',
      'ItemName',
      'Quantity',
      'SinglePrice',
      'BulkPrice',
      'Purchased Frequency',
      'Total Purchase'
    ]);
    allItems = await Item().select().toList();
    for (var ele in allItems) {
      allItemsList.add([
        ele.id,
        ele.name,
        ele.quantity,
        ele.singlePrice,
        ele.bulkPrice,
        ele.purchaseFreq,
        ele.totPurchase
      ]);
    }
    setState(() {});
  }

  var personOne;
  loadPersonData() async {
    personOne = await Personal().select().id.equals(1).toSingle();
    setState(() {});
  }

  TextEditingController perosonalNameUpdate = TextEditingController();
  @override
  void initState() {
    loadAllSalesData();
    loadAllExpensesData();
    loadAllClinetData();
    loadAllItemsData();
    loadPersonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12.0, top: 12, bottom: 7),
              child: Text(
                'ACCOUNT',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.8,
                  color: Colors.white54,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(10),
              // height: 250,
              width: 400,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 63, 63, 63),
                  // color: Colors.brown,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.white60,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    // This Thing alsomaking error
                    // I think it is because it is trying to load name before it load from database
                    // error says `getter 'name' was called on null`
                    personOne.name,
                    // 'Eyasu',
                    style: const TextStyle(
                        fontSize: 17,
                        wordSpacing: 1.5,
                        letterSpacing: 1.2,
                        height: 1.6,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${personOne.name}@mystore.co',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 145, 145, 145)),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(),
                    onPressed: () async {
                      perosonalNameUpdate.text = personOne.name;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.black54,
                              scrollable: true,
                              title: const Text('Personal Info'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Name"),
                                  TextFormField(
                                      controller: perosonalNameUpdate),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            personOne.name =
                                                perosonalNameUpdate.text;
                                            await personOne.save();
                                            loadPersonData();
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop("dialog");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Personal Info Updated Successfully",
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text('Update'))
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Edit Profile'),
                          Icon(Icons.chevron_right_sharp)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12.0, bottom: 10),
              child: Text(
                'DATA',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.8,
                  color: Colors.white60,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    // here when convert everything on data base to excel file
                    // Items sheet
                    var excel = Excel.createExcel();
                    var sheetItems = excel['Items'];
                    for (var ele in allItemsList) {
                      sheetItems.appendRow(ele);
                    }
                    // Clients sheet
                    var sheetClients = excel['Clients'];
                    for (var ele in allClientsList) {
                      sheetClients.appendRow(ele);
                    }
                    // Expense Sheet
                    var sheetExpenses = excel['Expenses'];
                    for (var ele in allExpensesList) {
                      sheetExpenses.appendRow(ele);
                    }
                    // Sales Sheet
                    var sheetSales = excel['Sales'];
                    for (var ele in allSalesList) {
                      sheetSales.appendRow(ele);
                    }
                    String outPutFile =
                        "/storage/emulated/0/Download/AllDataNew.xlsx";
                    List<int>? fileBytes = excel.save();
                    var res = await Permission.storage.request();
                    if (res.isGranted) {
                      if (fileBytes != null) {
                        File(join(outPutFile))
                          ..createSync(recursive: true)
                          ..writeAsBytesSync(fileBytes);
                        print("Saved");
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              right: 10,
                            ),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 210, 232, 255),
                                borderRadius: BorderRadius.circular(30)),
                            child: const Icon(
                              Icons.data_saver_off_sharp,
                              size: 25,
                              color: Color(0xFF3EBACE),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Export Data',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.4)),
                        ],
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(23)),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ]),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12.0, bottom: 10),
              child: Text(
                'SETTINGS',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.8,
                  color: Colors.white60,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              // height: 426,
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(255, 63, 63, 63),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_constructors
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              right: 10,
                            ),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 210, 232, 255),
                                borderRadius: BorderRadius.circular(30)),
                            child: const Icon(
                              Icons.notifications_none_rounded,
                              size: 25,
                              color: Color(0xFF3EBACE),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Notifications',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.4)),
                        ],
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(23)),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_constructors
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 210, 232, 255),
                                borderRadius: BorderRadius.circular(30)),
                            child: const Icon(
                              Icons.mode_night_outlined,
                              size: 25,
                              color: Color(0xFF3EBACE),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Dark Mode',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.4)),
                        ],
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(23)),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_constructors
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 210, 232, 255),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Icon(
                                Icons.help_outline_rounded,
                                size: 25,
                                color: Color(0xFF3EBACE),
                              )),
                          // ignore: prefer_const_constructors
                          SizedBox(
                            width: 10,
                          ),
                          const Text('Help',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.4)),
                        ],
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(23)),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          size: 35,
                        ),
                      )
                    ],
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
