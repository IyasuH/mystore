// ignore: file_names
import 'package:flutter/material.dart';

import '../models/sales.dart';
import 'homeTab.dart';

class SalesTab extends StatefulWidget {
  const SalesTab({super.key});

  @override
  State<SalesTab> createState() => _SalesTabState();
}

class _SalesTabState extends State<SalesTab> {
  var salesRow = SalesRow();
  String selectedValue = "Nov";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: SafeArea(
        child: PaginatedDataTable(
          sortColumnIndex: 7,
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Month'),
              DropdownButton(
                value: selectedValue,
                onChanged: (String? newValue) {
                  if (mounted) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Jan',
                    child: Text('Jan'),
                  ),
                  DropdownMenuItem(
                    value: 'Feb',
                    child: Text('Feb'),
                  ),
                  DropdownMenuItem(
                    value: 'Mar',
                    child: Text('Mar'),
                  ),
                  DropdownMenuItem(
                    value: 'Apr',
                    child: Text('Apr'),
                  ),
                  DropdownMenuItem(
                    value: 'May',
                    child: Text('May'),
                  ),
                  DropdownMenuItem(
                    value: 'Jun',
                    child: Text('Jun'),
                  ),
                  DropdownMenuItem(
                    value: 'Jul',
                    child: Text('Jul'),
                  ),
                  DropdownMenuItem(
                    value: 'Aug',
                    child: Text('Aug'),
                  ),
                  DropdownMenuItem(
                    value: 'Sep',
                    child: Text('Sep'),
                  ),
                  DropdownMenuItem(
                    value: 'Oct',
                    child: Text('Oct'),
                  ),
                  DropdownMenuItem(
                    value: 'Nov',
                    child: Text('Nov'),
                  ),
                  DropdownMenuItem(
                    value: 'Dec',
                    child: Text('Dec'),
                  ),
                ],
              ),
            ],
          ),
          columns: const [
            DataColumn(label: Text('Id')),
            DataColumn(label: Text('itemId')),
            DataColumn(label: Text('customerId')),
            DataColumn(label: Text('itemQuantity')),
            DataColumn(label: Text('soldDate')),
            DataColumn(label: Text('Revenu')),
            DataColumn(label: Text('bankId')),
            DataColumn(label: Text('addInfo')),
          ],
          source: salesRow,
        ),
      ),
    );
  }
}

class SalesRow extends DataTableSource {
  @override
  int get rowCount => sales.length;
  @override
  int get selectedRowCount => 0;
  @override
  bool get isRowCountApproximate => false;
  @override
  DataRow? getRow(int index) {
    final _sales = sales[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text('${_sales.salesId}')),
      DataCell(Text('${_sales.itemId}')),
      DataCell(Text('${_sales.customerId}')),
      DataCell(Text('${_sales.itemQuantity}')),
      DataCell(Text('${_sales.soldDate}')),
      DataCell(Text('${_sales.salesRevenu}')),
      DataCell(Text('${_sales.bankId}')),
      DataCell(Text(_sales.addInfo)),
    ]);
  }
}
