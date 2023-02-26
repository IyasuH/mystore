import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mystore/db/storeDB.dart';

import '../models/accounts.dart';
import '../models/sales.dart';

class CashTab extends StatefulWidget {
  const CashTab({super.key});

  @override
  State<CashTab> createState() => _CashTabState();
}

class _CashTabState extends State<CashTab> {
  @override
  void initState() {
    dbHelper.init();
    super.initState();
  }

  List cashSales = [];
  @override
  Widget build(BuildContext context) {
    cashSales = [];
    for (var element in sales) {
      // here assuming that bankId 1 is for cash
      if (element.bankId == 1) {
        cashSales.add(element);
      }
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 24, 13, 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: const [
                  Text(
                    'Cash',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 658,
              // padding: EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                'Account',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14,
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 7),
                          decoration: const BoxDecoration(
                            // color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Total in Accounts',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                  wordSpacing: 2.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Text(
                                '\$ 75,000',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 270,
                          margin: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 3),
                          decoration: const BoxDecoration(
                            // color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: FutureBuilder(
                              future: _query(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return ListView(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          showBottomBorder: true,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          columns: [
                                            const DataColumn(
                                                label: Text('Date')),
                                            const DataColumn(
                                                label: Text('Bank')),
                                            const DataColumn(
                                              label: Text('Amount'),
                                              numeric: true,
                                            ),
                                          ],
                                          rows: _accountsRow(snapshot.data),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                // ignore: prefer_const_constructors
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 110.0, horizontal: 7.0),
                                  child: const CircularProgressIndicator(
                                    color: Colors.amber,
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                'Cash',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 7,
                          ),
                          decoration: const BoxDecoration(
                            // color: Colors.greenAccent,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                'Total in Cash',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                  wordSpacing: 2.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              const Text(
                                '\$ 5000',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 270,
                          margin: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 3),
                          decoration: const BoxDecoration(
                            // color: Colors.greenAccent,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: ListView(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  showBottomBorder: true,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  columns: [
                                    const DataColumn(label: Text('Date')),
                                    const DataColumn(label: Text('Item Name')),
                                    const DataColumn(
                                      label: Text('Amount'),
                                      numeric: true,
                                    ),
                                  ],
                                  rows: _cashRows(),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final dbHelper = myStoreDatabaseHelper();

  _query() async {
    print("accounts:");
    List<Map> accounts = await dbHelper.queryAllAccount().timeout(
        const Duration(milliseconds: 3000),
        onTimeout: () => throw TimeoutException('can\'t load'));
    print(accounts);
    return accounts;
  }

  // two tables one for accounts and the other for cash
  TextEditingController bankNameUpdate = TextEditingController();
  TextEditingController bankAmountUpdate = TextEditingController();
  TextEditingController bankAmountAccNumber = TextEditingController();
  TextEditingController accountCreatedDate = TextEditingController();
  List<DataRow> _accountsRow(List<Map<String, dynamic>> datas) {
    return datas
        .map((data) => DataRow(
              onLongPress: (() {
                bankNameUpdate.text = data['bankName'];
                bankAmountUpdate.text = data['amount'].toString();
                bankAmountAccNumber.text = data['accountNumber'].toString();
                accountCreatedDate.text = data['accountCreatedDate'];
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: const Text('Account'),
                        backgroundColor: Colors.black54,
                        content: Column(children: [
                          // ignore: prefer_const_constructors
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Bank Name"),
                              TextFormField(
                                controller: bankNameUpdate,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text("Amount"),
                              TextFormField(
                                controller: bankAmountUpdate,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text("Account Number"),
                              TextFormField(
                                controller: bankAmountAccNumber,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text("Account Created Date"),
                              TextFormField(
                                controller: accountCreatedDate,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 13,
                          ),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    dbHelper.updateAccount(
                                        bankNameUpdate.text,
                                        bankAmountAccNumber.text,
                                        bankAmountUpdate.text,
                                        accountCreatedDate.text,
                                        data['_id']);
                                    Navigator.of(context, rootNavigator: true)
                                        .pop("dialog");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Account Updated Successfully",
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Update"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    dbHelper.deleteAccount(data['_id']);
                                    Navigator.of(context, rootNavigator: true)
                                        .pop("dialog");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Account Deleted Successfully",
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                  ),
                                  child: const Text("Delete"),
                                ),
                              ])
                        ]),
                      );
                    });
              }),
              cells: [
                DataCell(Text(data['accountCreatedDate'])),
                DataCell(Text(data['bankName'])),
                DataCell(Text(data['amount'].toString())),
              ],
            ))
        .toList();
  }

  List<DataRow> _cashRows() {
    return cashSales
        .map((e) => DataRow(
              onLongPress: (() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Cash'),
                        backgroundColor: Colors.black54,
                        content: SizedBox(
                          height: 400,
                          child: Column(),
                        ),
                      );
                    });
              }),
              cells: [
                DataCell(Text(e.soldDate)),
                DataCell(Text(e.itemId.toString())),
                DataCell(Text(e.salesRevenu.toString())),
              ],
            ))
        .toList();
  }
}
