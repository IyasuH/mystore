import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mystore/models/stock.dart';

class StockTab extends StatefulWidget {
  const StockTab({super.key});

  @override
  State<StockTab> createState() => _StockTabState();
}

class _StockTabState extends State<StockTab> {
  // this bool variables are to decide to use which column sorting
  bool _sortNameAsc = true;
  bool _sortQuantityAsc = true;
  bool _sortPriceAsc = true;
  bool _sortAsc = true;
  int _sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 24, 13, 10),
            // margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Stocks',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // to add stocks custom add is manually but there will
                // also be option to import form othre file in this popUp
                Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey,
                        blurStyle: BlurStyle.outer,
                        blurRadius: 7,
                      )
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 650,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: ListView(children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: Column(
                    children: [
                      itemsList(),
                      totalStock_MonthlyChange_Row(),
                      Container(
                        height: 250,
                        decoration: const BoxDecoration(
                          // color: Colors.pink,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              blurStyle: BlurStyle.outer,
                              blurRadius: 7,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 20, 14, 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Best Selling Items ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Item Name',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                const Text(
                                  'Revenue',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  totalStock_MonthlyChange_Row() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 140,
            width: 160,
            decoration: const BoxDecoration(
              // color: Colors.blue,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 7,
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            // margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  '954',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'total items',
                  style: TextStyle(
                    height: .5,
                    fontSize: 17,
                    letterSpacing: 2.5,
                    wordSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'In stock',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 140,
            width: 160,
            decoration: const BoxDecoration(
              // color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 7,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  '56',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'New Items',
                  style: TextStyle(
                    height: .5,
                    fontSize: 17,
                    letterSpacing: 2.5,
                    wordSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'This month',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  itemsList() {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      height: 350,
      decoration: const BoxDecoration(
        // color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey,
            blurStyle: BlurStyle.outer,
            blurRadius: 7,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: ListView(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                showBottomBorder: true,
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAsc,
                // decoration: BoxDecoration(color: Colors.green),
                // dataRowColor: const [Colors.amber],
                // ignore: prefer_const_literals_to_create_immutables
                columns: [
                  const DataColumn(
                    label: Text('Id'),
                  ),
                  DataColumn(
                    label: const Text('Item'),
                    onSort: (columnIndex, sortAscending) {
                      if (mounted) {
                        setState(() {
                          if (columnIndex == _sortColumnIndex) {
                            _sortAsc = _sortNameAsc = sortAscending;
                          } else {
                            _sortColumnIndex = columnIndex;
                            _sortAsc = _sortNameAsc;
                          }
                          stocks
                              .sort((a, b) => a.itemName.compareTo(b.itemName));
                          if (!_sortAsc) {
                            stocks.sort(
                                (a, b) => b.itemName.compareTo(a.itemName));
                          }
                        });
                      }
                    },
                  ),
                  DataColumn(
                    label: const Text('Quantity'),
                    numeric: true,
                    onSort: (columnIndex, sortAscending) {
                      if (mounted) {
                        setState(() {
                          if (columnIndex == _sortColumnIndex) {
                            _sortAsc = _sortQuantityAsc = sortAscending;
                          } else {
                            _sortColumnIndex = columnIndex;
                            _sortAsc = _sortQuantityAsc;
                          }
                          stocks.sort((a, b) =>
                              a.itemQuantity.compareTo(b.itemQuantity));
                          if (!_sortAsc) {
                            stocks.sort((a, b) =>
                                b.itemQuantity.compareTo(a.itemQuantity));
                          }
                        });
                      } else
                        return;
                    },
                  ),
                  DataColumn(
                    label: const Text('Price'),
                    numeric: true,
                    onSort: (columnIndex, sortAscending) {
                      if (mounted) {
                        setState(() {
                          if (columnIndex == _sortColumnIndex) {
                            _sortAsc = _sortPriceAsc = sortAscending;
                          } else {
                            _sortColumnIndex = columnIndex;
                            _sortAsc = _sortPriceAsc;
                          }
                          stocks.sort(
                              (a, b) => a.singlePrice.compareTo(b.singlePrice));
                          if (!_sortAsc) {
                            stocks.sort((a, b) =>
                                b.singlePrice.compareTo(a.singlePrice));
                          }
                        });
                      }
                    },
                  ),
                  const DataColumn(
                    label: Text('Total'),
                    numeric: true,
                  ),
                ],
                rows: _stockRows(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _stockRows() {
    return stocks
        .map((e) => DataRow(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // ignore: prefer_const_constructors
                        return AlertDialog(
                          title: const Text('This is my message'),
                          backgroundColor: Colors.black54,
                          content: SizedBox(
                            height: 400,
                            child: Column(),
                          ),
                        );
                      });
                },
                cells: [
                  DataCell(Text(e.itemId.toString())),
                  DataCell(Text(e.itemName)),
                  DataCell(Text(e.itemQuantity.toString())),
                  DataCell(Text(e.singlePrice.toString())),
                  DataCell(Text((e.itemQuantity * e.singlePrice).toString())),
                ]))
        .toList();
  }
}
