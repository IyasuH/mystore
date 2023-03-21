// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../models/model.dart';

class CashTab extends StatefulWidget {
  const CashTab({super.key});

  @override
  State<CashTab> createState() => _CashTabState();
}

class _CashTabState extends State<CashTab> {
  List<Bank> bankSQF = [];
  List<Sale> cashSales = [];
  List<Bank> bankTTM = [];
  double totalInlCash = 0;
  double totalInAcc = 0;
  int selectedBank = 1;
  int cashAccId = 1;
  loadBankDataTTM() async {
    bankTTM = await Bank().select().toList();
  }

  loadCashSalesData() async {
    totalInlCash = 0;
    cashSales = await Sale().select().BankId.equals(1).toList();
    for (var ele in cashSales) {
      totalInlCash += ele.revenue!;
    }
    setState(() {});
  }

  loadBankData() async {
    // here I make the query greater than because
    // id 1 is for cash
    totalInAcc = 0;
    bankSQF = await Bank().select().id.greaterThan(1).toList();
    for (var ele in bankSQF) {
      totalInAcc += ele.amount!;
    }
    setState(() {});
  }

  @override
  void initState() {
    loadBankDataTTM();
    loadCashSalesData();
    loadBankData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 23, 13, 8.5),
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
              height: 663,
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
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(color: Colors.blueGrey, width: 1.5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ignore: prefer_const_constructors
                              Text(
                                'Total in Accounts',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                  wordSpacing: 2.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              Text(
                                '\$ $totalInAcc',
                                style: const TextStyle(
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
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(color: Colors.blueGrey, width: 1.5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 4,
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
                                    const DataColumn(label: Text('Bank')),
                                    const DataColumn(
                                      label: Text('Amount'),
                                      numeric: true,
                                    ),
                                    const DataColumn(
                                        label: Text('Account No.')),
                                    const DataColumn(
                                        label: Text('Created Day')),
                                  ],
                                  rows: _accountsRow(),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 5),
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
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(color: Colors.blueGrey, width: 1.5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 4,
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
                              Text(
                                '\$ $totalInlCash',
                                style: const TextStyle(
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
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            border:
                                Border.all(color: Colors.blueGrey, width: 1.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 4,
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

  // two tables one for accounts and the other for cash
  TextEditingController bankNameUpdate = TextEditingController();
  TextEditingController bankAmountUpdate = TextEditingController();
  TextEditingController bankAmountAccNumberUp = TextEditingController();
  DateTime accountCreatedDateUp = DateTime.now();

  List<DataRow> _accountsRow() {
    return bankSQF
        .map((data) => DataRow(
              onLongPress: (() {
                bankNameUpdate.text = data.name.toString();
                bankAmountUpdate.text = data.amount.toString();
                bankAmountAccNumberUp.text = data.accountNumber.toString();
                accountCreatedDateUp = data.accountDate!;
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: const Text('Account'),
                        backgroundColor: Colors.black87,
                        content: Column(children: [
                          // ignore: prefer_const_constructors
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Bank Id"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(data.id.toString(),
                                  style: const TextStyle(color: Colors.blue)),
                              const SizedBox(
                                height: 15,
                              ),
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
                                controller: bankAmountAccNumberUp,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text("Account Created Date"),
                              TextButton(
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2022, 1, 1),
                                      maxTime: DateTime(2030, 12, 30),
                                      theme: const DatePickerTheme(
                                        headerColor: Colors.black,
                                        backgroundColor: Colors.black,
                                        itemStyle:
                                            TextStyle(color: Colors.white),
                                        doneStyle:
                                            TextStyle(color: Colors.white),
                                        cancelStyle:
                                            TextStyle(color: Colors.white),
                                      ), onConfirm: (date) {
                                    accountCreatedDateUp = date;
                                  });
                                },
                                child: Text(DateFormat()
                                    .add_yMd()
                                    .format(accountCreatedDateUp)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 13,
                          ),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (await confirm(
                                      context,
                                      title: const Text('Confirm'),
                                      content: const Text(
                                          'You sure to update data?'),
                                      textOK: const Text('Yes'),
                                      textCancel: const Text('Nah'),
                                    )) {
                                      data.name = bankNameUpdate.text;
                                      data.amount =
                                          double.parse(bankAmountUpdate.text);
                                      data.accountNumber =
                                          bankAmountAccNumberUp.text;
                                      data.accountDate = accountCreatedDateUp;
                                      data.updatedAt = DateTime.now();
                                      await data.save();
                                      loadBankData();
                                      Navigator.of(context, rootNavigator: true)
                                          .pop("dialog");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Account Updated Successfully",
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
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        textCancel: const Text('No'))) {
                                      // delete using ID
                                      await Bank()
                                          .select()
                                          .id
                                          .equals(data.id)
                                          .delete();
                                      loadBankData();
                                      Navigator.of(context, rootNavigator: true)
                                          .pop("dialog");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Account Deleted Successfully",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text("Delete",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                      )),
                                ),
                              ])
                        ]),
                      );
                    });
              }),
              cells: [
                DataCell(Text(data.name.toString())),
                DataCell(Text(data.amount.toString())),
                DataCell(Text(data.accountNumber.toString())),
                // DataCell(Text(data.accountDate.toString())),
                DataCell(
                    Text(DateFormat('yyyy-MM-dd').format(data.accountDate!))),
              ],
            ))
        .toList();
  }

  List<DataRow> _cashRows() {
    return cashSales
        .map((data) => DataRow(
              onLongPress: (() async {
                var itemSelecetd =
                    await Item().select().id.equals(data.ItemId).toSingle();
                var clientSelected =
                    await Client().select().id.equals(data.ClientId).toSingle();
                var cashId =
                    await Bank().select().id.equals(data.BankId).toSingle();
                TextStyle topicStyle = const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 1.4,
                    color: Colors.grey);
                TextStyle infoStyle =
                    const TextStyle(fontSize: 15, color: Colors.blueGrey);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                            scrollable: true,
                            title: const Text('Cash'),
                            backgroundColor: Colors.black87,
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Item Name", style: topicStyle),
                                Text(itemSelecetd!.name!, style: infoStyle),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Clinet Name", style: topicStyle),
                                Text(clientSelected!.name!, style: infoStyle),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Quantity", style: topicStyle),
                                Text(data.quantity.toString(),
                                    style: infoStyle),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Date", style: topicStyle),
                                Text(
                                    DateFormat('yyyy-MM-dd').format(data.date!),
                                    style: infoStyle),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Revenue", style: topicStyle),
                                Text(data.revenue.toString(), style: infoStyle),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Add Info", style: topicStyle),
                                Text(data.info!, style: infoStyle),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black26),
                                        child: DropdownButton(
                                          value: selectedBank,
                                          onChanged: (int? newValue) {
                                            if (mounted) {
                                              setState(() {
                                                selectedBank = newValue!;
                                              });
                                            }
                                          },
                                          items: bankTTM.map((data) {
                                            return DropdownMenuItem(
                                                value: data.id,
                                                child: Text(data.name!));
                                          }).toList(),
                                        )),
                                    ElevatedButton(
                                      onPressed: () async {
                                        // This method to update sales to bankId and
                                        // and to update Bank amount
                                        // (decrease from cash and increase to the other bank)
                                        var bankDeposit = await Bank()
                                            .select()
                                            .id
                                            .equals(selectedBank)
                                            .toSingle();
                                        // increase the deposit amount
                                        await Bank()
                                            .select()
                                            .id
                                            .equals(selectedBank)
                                            .update({
                                          "amount": bankDeposit!.amount! +
                                              data.revenue!
                                        });

                                        var cashAcc = await Bank()
                                            .select()
                                            .id
                                            .equals(cashAccId)
                                            .toSingle();
                                        // decrease the cash amunt
                                        await Bank()
                                            .select()
                                            .id
                                            .equals(cashAccId)
                                            .update({
                                          "amount":
                                              cashAcc!.amount! - data.revenue!
                                        });
                                        data.BankId = selectedBank;
                                        await data.save();
                                        loadCashSalesData();
                                        loadBankData();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text("Sales Revenue deposited"),
                                          ),
                                        );
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop("dialog");
                                      },
                                      child: const Text('Deposit to cash'),
                                    ),
                                  ],
                                )
                              ],
                            ));
                      });
                    });
              }),
              cells: [
                DataCell(Text(DateFormat('yyyy-MM-dd').format(data.date!))),
                DataCell(Text(data.ItemId.toString())),
                DataCell(Text(data.revenue.toString())),
              ],
            ))
        .toList();
  }
}
