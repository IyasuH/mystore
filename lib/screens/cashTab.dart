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
                          child: ListView(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  showBottomBorder: true,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  columns: [
                                    const DataColumn(label: Text('Date')),
                                    const DataColumn(label: Text('Bank')),
                                    const DataColumn(
                                      label: Text('Amount'),
                                      numeric: true,
                                    ),
                                  ],
                                  rows: _accountsRow(),
                                ),
                              )
                            ],
                          ),
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
    List<Map> accounts = await dbHelper.queryAllAccount();
    return accounts;
  }

  // two tables one for accounts and the othe for cash

  List<DataRow> _accountsRow() {
    return _query()
        .map((e) => DataRow(
              onLongPress: (() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Account'),
                        backgroundColor: Colors.black54,
                        content: SizedBox(
                          height: 400,
                          child: Column(),
                        ),
                      );
                    });
              }),
              cells: [
                DataCell(Text(e['accountCreatedDate'].toIso8601String())),
                DataCell(Text(e['bankName'])),
                DataCell(Text(e['amount'].toString())),
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
