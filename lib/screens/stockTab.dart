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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showBottomBorder: true,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAsc,
          // ignore: prefer_const_literals_to_create_immutables
          columns: [
            const DataColumn(
              label: Text('Id'),
            ),
            DataColumn(
              label: const Text('Item'),
              onSort: (columnIndex, sortAscending) {
                setState(() {
                  if (columnIndex == _sortColumnIndex) {
                    _sortAsc = _sortNameAsc = sortAscending;
                  } else {
                    _sortColumnIndex = columnIndex;
                    _sortAsc = _sortNameAsc;
                  }
                  stocks.sort((a, b) => a.itemName.compareTo(b.itemName));
                  if (!_sortAsc) {
                    stocks.sort((a, b) => b.itemName.compareTo(a.itemName));
                  }
                });
              },
            ),
            DataColumn(
              label: const Text('Quantity'),
              numeric: true,
              onSort: (columnIndex, sortAscending) {
                setState(() {
                  if (columnIndex == _sortColumnIndex) {
                    _sortAsc = _sortQuantityAsc = sortAscending;
                  } else {
                    _sortColumnIndex = columnIndex;
                    _sortAsc = _sortQuantityAsc;
                  }
                  stocks
                      .sort((a, b) => a.itemQuantity.compareTo(b.itemQuantity));
                  if (!_sortAsc) {
                    stocks.sort(
                        (a, b) => b.itemQuantity.compareTo(a.itemQuantity));
                  }
                });
              },
            ),
            DataColumn(
              label: const Text('Price'),
              numeric: true,
              onSort: (columnIndex, sortAscending) {
                setState(() {
                  if (columnIndex == _sortColumnIndex) {
                    _sortAsc = _sortPriceAsc = sortAscending;
                  } else {
                    _sortColumnIndex = columnIndex;
                    _sortAsc = _sortPriceAsc;
                  }
                  stocks.sort((a, b) => a.singlePrice.compareTo(b.singlePrice));
                  if (!_sortAsc) {
                    stocks
                        .sort((a, b) => b.singlePrice.compareTo(a.singlePrice));
                  }
                });
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
