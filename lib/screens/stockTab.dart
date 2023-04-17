// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import '../models/model.dart';

class StockTab extends StatefulWidget {
  const StockTab({super.key});

  @override
  State<StockTab> createState() => _StockTabState();
}

class _StockTabState extends State<StockTab> {
  List<Item> itemSQFL = [];
  List<Item> newItemMonthly = [];
  // best selling item ever not limited by month or year
  List<Item> bestSellItem = [];
  double totalitemAmount = 0;
  int totalitemNum = 0;
  DateTime today = DateTime.now();
  List<String> stockTbleRows = [];
  List<Map> stockItemMap = [];
  String itemSheetName = "Sheet1"; // Item
  // every `Item` sheet should have the 6 column length
  int itemColuNum = 6;
  // ignore: prefer_typing_uninitialized_variables
  var itemSelectedExcel;
  // This function is just to pick XL file from folder
  pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
    if (result != null) {
      File xlFile = File(result.files.single.path!);
      var bytes = xlFile.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      itemSelectedExcel = excel;
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
      // print("No file selected");
    }
  }

  // This funtion is to process the given file and convert it into Map type
  getList() {
    stockTbleRows.clear();
    stockItemMap.clear();
    if (itemSelectedExcel[itemSheetName].rows.length <= 1) {
      // so here return someMsg on screen
      // snacbar here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Row number is less than 1",
          ),
        ),
      );

      // print("Row number is less than 1");
    } else {
      for (var i = 1; i < itemSelectedExcel[itemSheetName].rows.length; i++) {
        for (var row in itemSelectedExcel[itemSheetName].rows[i]) {
          stockTbleRows.add(row.value.toString());
        }
      }
      // print("stock list");
      // print(stockTbleRows);
      for (var i = 0; i < stockTbleRows.length; i += itemColuNum) {
        stockItemMap.add({
          "name": stockTbleRows[i + 0],
          "quantity": stockTbleRows[i + 1],
          "singlePrice": stockTbleRows[i + 2],
          "bulkPrice": stockTbleRows[i + 3],
          "purchaseFreq": stockTbleRows[i + 4],
          "totPurchase": stockTbleRows[i + 5],
        });
      }
      // print("stock maps");
      // print(stockItemMap);
      for (var ele in stockItemMap) {
        saveItem(ele);
      }
    }
    setState(() {});
  }

  // to save the loaded data to database
  saveItem(ele) async {
    Item itemSQFList = Item();
    itemSQFList.name = ele['name'];
    itemSQFList.quantity = int.parse(ele['quantity']);
    itemSQFList.singlePrice = double.parse(ele['singlePrice']);
    itemSQFList.bulkPrice = double.parse(ele['bulkPrice']);
    itemSQFList.purchaseFreq = int.parse(ele['purchaseFreq']);
    itemSQFList.totPurchase = double.parse(ele['totPurchase']);
    await itemSQFList.save();
    // snacbar here
    loadItemData();
  }

  loadBestSell() async {
    bestSellItem =
        await Item().select().orderByDesc("totPurchase").top(3).toList();
    setState(() {});
  }

  loadItemData() async {
    totalitemAmount = 0;
    totalitemNum = 0;
    newItemMonthly = [];
    itemSQFL = await Item().select().toList();
    for (var ele in itemSQFL) {
      totalitemAmount +=
          (ele.quantity! * num.parse(ele.singlePrice.toString()));
      totalitemNum += ele.quantity!;
      if ((ele.createdAt!).year == today.year &&
          (ele.createdAt!).month == today.month) {
        newItemMonthly.add(ele);
      }
    }
    setState(() {});
  }

  bool _sortNameAsc = true;
  bool _sortQuantityAsc = true;
  bool _sortPriceAsc = true;
  bool _sortAsc = true;
  int _sortColumnIndex = 0;

  @override
  void initState() {
    // bankDB.init();
    loadBestSell();
    loadItemData();
    super.initState();
  }

  String textFieldVliMdg = "Please enter some value";
  final _formStockKey = GlobalKey<FormState>();
  // final itemSQF = Item();
  // double screenHeight = 0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController itemNameCont = TextEditingController();
    TextEditingController itemQuantityCont = TextEditingController();
    TextEditingController itemSSellingPriceCont = TextEditingController();
    TextEditingController itemBSellingPriceCont = TextEditingController();
    TextEditingController itemPurchaseFreq = TextEditingController();
    TextEditingController itemTotPurchase = TextEditingController();

    // DateTime itemUpdatedCont = DateTime.now();
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 23, 13, 9),
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
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        border: Border.all(color: Colors.blueGrey, width: 1.5),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.blueGrey,
                            blurStyle: BlurStyle.outer,
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          pickFile();
                        },
                        icon: const Icon(Icons.file_present),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        color: Colors.black45,
                        border: Border.all(color: Colors.blueGrey, width: 1.5),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.blueGrey,
                            blurStyle: BlurStyle.outer,
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.black87,
                                  scrollable: true,
                                  title: const Text('Add Stock'),
                                  content: Form(
                                    key: _formStockKey,
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            const Text("Item Name"),
                                            TextFormField(
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              controller: itemNameCont,
                                              decoration: const InputDecoration(
                                                  hintText: 'Item Name'),
                                              // tried to automate the validation by the defining function
                                              // and calling the same validation for all but did't works
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return textFieldVliMdg;
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 5),
                                            const Text("Item Quantity"),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: itemQuantityCont,
                                              decoration: const InputDecoration(
                                                  hintText: 'Item Quantity'),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return textFieldVliMdg;
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 5),
                                            const Text(
                                                "Single Item Selling Price"),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: itemSSellingPriceCont,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      'Single Selling Price'),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return textFieldVliMdg;
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 5),
                                            const Text("Bulk Selling Price"),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: itemBSellingPriceCont,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      'Bulk Selling Price'),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return textFieldVliMdg;
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            const Text("Purchase Frequency"),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: itemPurchaseFreq,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      'Purchase Frequency'),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return textFieldVliMdg;
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            const Text("Total Frequency"),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: itemTotPurchase,
                                              decoration: const InputDecoration(
                                                  hintText: 'Total Frequency'),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return textFieldVliMdg;
                                                }
                                                return null;
                                              },
                                            ),

                                            // updateAt date value is set automatically by the day item inserted
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    if (_formStockKey
                                                        .currentState!
                                                        .validate()) {
                                                      Item itemSQF = Item();
                                                      itemSQF.name =
                                                          itemNameCont.text;
                                                      itemSQF.quantity =
                                                          int.parse(
                                                              itemQuantityCont
                                                                  .text);
                                                      itemSQF.singlePrice =
                                                          double.parse(
                                                              itemSSellingPriceCont
                                                                  .text);
                                                      itemSQF.bulkPrice =
                                                          double.parse(
                                                              itemBSellingPriceCont
                                                                  .text);
                                                      itemSQF.purchaseFreq =
                                                          int.parse(
                                                              itemPurchaseFreq
                                                                  .text);
                                                      itemSQF.totPurchase =
                                                          double.parse(
                                                              itemTotPurchase
                                                                  .text);
                                                      await itemSQF.save();
                                                      loadItemData();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        // ignore: prefer_const_constructors
                                                        SnackBar(
                                                          // ignore: prefer_const_constructors
                                                          content: Text(
                                                            "New Item Created",
                                                          ),
                                                        ),
                                                      );
                                                      itemNameCont.text = "";
                                                      itemQuantityCont.text =
                                                          "";
                                                      itemSSellingPriceCont
                                                          .text = "";
                                                      itemBSellingPriceCont
                                                          .text = "";
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop("dialog");
                                                    }
                                                  },
                                                  child: const Text(
                                                      "Create New Item"))
                                            ])
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            // height: 660,
            height: screenHeight - 196,
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
                        // height: screenHeight - 750,
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
                                        // fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Item Name',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                                const Text(
                                  'Revenue',
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            SizedBox(
                                height: 155,
                                child: ListView.builder(
                                  itemCount: bestSellItem.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      height: 60,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            width: 1.5,
                                            color: Color.fromARGB(
                                                255, 85, 97, 103),
                                          ),
                                        ),
                                      ),
                                      // )
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            bestSellItem[index].name!,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "x ${bestSellItem[index].purchaseFreq!.toString()}"),
                                                Text(
                                                  "\$ ${bestSellItem[index].totPurchase!.toString()}",
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ))
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
            decoration: BoxDecoration(
              color: Colors.black45,
              border: Border.all(color: Colors.blueGrey, width: 1.5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.blueGrey,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 4,
                )
              ],
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            // margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  totalitemNum.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '$totalitemAmount \$',
                  style: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 1.5,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
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
            decoration: BoxDecoration(
              color: Colors.black45,
              border: Border.all(color: Colors.blueGrey, width: 1.5),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.blueGrey,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 4,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  newItemMonthly.length.toString(),
                  style: const TextStyle(
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
      // height: screenHeight - 750,
      decoration: BoxDecoration(
        color: Colors.black45,
        border: Border.all(color: Colors.blueGrey, width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Colors.blueGrey,
            blurStyle: BlurStyle.outer,
            blurRadius: 4,
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
                          itemSQFL.sort((a, b) => a.name!.compareTo(b.name!));
                          if (!_sortAsc) {
                            itemSQFL.sort((a, b) => b.name!.compareTo(a.name!));
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
                          itemSQFL.sort(
                              (a, b) => a.quantity!.compareTo(b.quantity!));
                          if (!_sortAsc) {
                            itemSQFL.sort(
                                (a, b) => b.quantity!.compareTo(a.quantity!));
                          }
                        });
                      } else {
                        return;
                      }
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
                          itemSQFL.sort((a, b) =>
                              a.singlePrice!.compareTo(b.singlePrice!));
                          if (!_sortAsc) {
                            itemSQFL.sort((a, b) =>
                                b.singlePrice!.compareTo(a.singlePrice!));
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

  TextEditingController itemNameUpdate = TextEditingController();
  TextEditingController itemQuantityUpdate = TextEditingController();
  TextEditingController itemSinglePriceUpdate = TextEditingController();
  TextEditingController itemBulkPriceUpdat = TextEditingController();
  TextEditingController itemPurchaseFreqUpdate = TextEditingController();
  TextEditingController itemTotPurchaseUpdate = TextEditingController();

  List<DataRow> _stockRows() {
    return itemSQFL
        .map((data) => DataRow(
                onLongPress: (() {
                  itemNameUpdate.text = data.name.toString();
                  itemQuantityUpdate.text = data.quantity.toString();
                  itemSinglePriceUpdate.text = data.singlePrice.toString();
                  itemBulkPriceUpdat.text = data.bulkPrice.toString();
                  itemPurchaseFreqUpdate.text = data.purchaseFreq.toString();
                  itemTotPurchaseUpdate.text = data.totPurchase.toString();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // ignore: prefer_const_constructors
                        return AlertDialog(
                          scrollable: true,
                          title: const Text('Stock Edit'),
                          backgroundColor: Colors.black87,
                          content: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Name"),
                                  TextFormField(
                                    controller: itemNameUpdate,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text("Quantity"),
                                  TextFormField(
                                    controller: itemQuantityUpdate,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text("Single Price"),
                                  TextFormField(
                                    controller: itemSinglePriceUpdate,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text("Bulk Price"),
                                  TextFormField(
                                    controller: itemBulkPriceUpdat,
                                  ),
                                  const Text("Purchase Frequency"),
                                  TextFormField(
                                    controller: itemPurchaseFreqUpdate,
                                  ),
                                  const Text("Total purchase"),
                                  TextFormField(
                                    controller: itemTotPurchaseUpdate,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                          data.name = itemNameUpdate.text;
                                          data.quantity = int.parse(
                                              itemQuantityUpdate.text);
                                          data.singlePrice = double.parse(
                                              itemSinglePriceUpdate.text);
                                          data.bulkPrice = double.parse(
                                              itemBulkPriceUpdat.text);
                                          data.updatedAt = DateTime.now();
                                          await data.save();
                                          loadItemData();
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop("dialog");
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Stock Updated Successfully",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text("Update"),
                                    ),
                                    // # on This and another delete function some apply kind of comfirmation
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (await confirm(context,
                                            title: const Text('Confirm'),
                                            content:
                                                const Text('Are you sure!'),
                                            textOK: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color: Colors.redAccent),
                                            ),
                                            textCancel: const Text('No'))) {
                                          await Item()
                                              .select()
                                              .id
                                              .equals(data.id)
                                              .delete();
                                          loadItemData();
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop("dialog");
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Stock Deleted Successfully",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(),
                                      child: const Text("Delete",
                                          style: TextStyle(
                                              color: Colors.redAccent)),
                                    ),
                                  ])
                            ],
                          ),
                        );
                      });
                }),
                cells: [
                  DataCell(Text(data.id.toString())),
                  DataCell(Text(data.name.toString())),
                  DataCell(Text(data.quantity.toString())),
                  DataCell(Text(data.singlePrice.toString())),
                  DataCell(
                    Text(
                      (data.quantity! * num.parse(data.singlePrice.toString()))
                          .toString(),
                    ),
                  ),
                ]))
        .toList();
  }
}
