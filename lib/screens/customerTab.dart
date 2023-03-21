// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:io';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mystore/models/model.dart';

class CustomerTab extends StatefulWidget {
  const CustomerTab({super.key});

  @override
  State<CustomerTab> createState() => _CustomerTabState();
}

class _CustomerTabState extends State<CustomerTab> {
  List<Client> clientSQFL = [];
  List<Client> newClientMonthly = [];
  DateTime today = DateTime.now();
  List<String> clientTbleRows = [];
  List<Map> clientItemMap = [];
  String clientSheetName = "Sheet1"; // Client
  // every `Client` sheet should have the 6 column length
  int clientColuNum = 9;

  var clientSelectedExcel;
  // This function is just to pick XL file from folder
  pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);
    if (result != null) {
      File xlFile = File(result.files.single.path!);
      var bytes = xlFile.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      clientSelectedExcel = excel;
      getList();
    } else {
      // snacbar here
      print("No file selected");
    }
  }

  // This funtion is to process the given file and convert it into Map type
  getList() {
    clientTbleRows.clear();
    clientItemMap.clear();
    if (clientSelectedExcel[clientSheetName].rows.length <= 1) {
      // snacbar here
      print("Row number is less than 1");
    } else {
      for (var i = 1;
          i < clientSelectedExcel[clientSheetName].rows.length;
          i++) {
        for (var row in clientSelectedExcel[clientSheetName].rows[i]) {
          clientTbleRows.add(row.value.toString());
        }
      }
      for (var i = 0; i < clientTbleRows.length; i += clientColuNum) {
        clientItemMap.add({
          "name": clientTbleRows[i + 0],
          "companyName": clientTbleRows[i + 1],
          "bankName": clientTbleRows[i + 2],
          "bankNumber": clientTbleRows[i + 3],
          "tinNumber": clientTbleRows[i + 4],
          "city": clientTbleRows[i + 5],
          "phoneN": clientTbleRows[i + 6],
          "purchaseFreq": clientTbleRows[i + 7],
          "totPurchase": clientTbleRows[i + 8]
        });
      }
      for (var ele in clientItemMap) {
        saveClient(ele);
      }
    }
    setState(() {});
  }

  // to save the loaded data to database
  saveClient(ele) async {
    Client clientSQFList = Client();
    clientSQFList.name = ele['name'];
    clientSQFList.companyName = ele['companyName'];
    clientSQFList.bankName = ele['bankName'];
    clientSQFList.bankNumber = ele['bankNumber'];
    clientSQFList.tinNumber = ele['tinNumber'];
    clientSQFList.city = ele['city'];
    clientSQFList.phoneN = ele['phoneN'];
    clientSQFList.purchaseFreq = int.parse(ele['purchaseFreq']);
    clientSQFList.totPurchase = double.parse(ele['totPurchase']);
    await clientSQFList.save();
    // snacbar here to that tells data saved
    loadClientData();
  }

  loadClientData() async {
    newClientMonthly = [];
    clientSQFL = await Client().select().toList();
    for (var ele in clientSQFL) {
      if ((ele.createdAt!).year == today.year &&
          (ele.createdAt!).month == today.month) {
        newClientMonthly.add(ele);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    loadClientData();
    super.initState();
  }

  final _fromClientKey = GlobalKey<FormState>();
  String textFieldVlidMsg = "Please enter some value";
  final clientSQF = Client();
  @override
  Widget build(BuildContext context) {
    // TextField controllers for inserting new client
    TextEditingController customerNameCont = TextEditingController();
    TextEditingController companyNameCont = TextEditingController();
    TextEditingController bankNameCont = TextEditingController();
    TextEditingController bankAccountCont = TextEditingController();
    TextEditingController tinNumberCont = TextEditingController();
    TextEditingController cityCont = TextEditingController();
    TextEditingController phoneNumberCont = TextEditingController();

    // TextField for updating clients info
    TextEditingController clientNameUpdate = TextEditingController();
    TextEditingController companyNameUpdate = TextEditingController();
    TextEditingController bankNameUpdate = TextEditingController();
    TextEditingController bankNumberUpdate = TextEditingController();
    TextEditingController tinNumberUpdate = TextEditingController();
    TextEditingController cityUpdate = TextEditingController();
    TextEditingController phoneNumberUpdate = TextEditingController();
    TextEditingController frequencyOfPurchUpdate = TextEditingController();
    TextEditingController totalPurchUpdate = TextEditingController();

    // String accountCreatedAtCont = dateFormat.format(DateTime.now());
    // TextEditingController accountCreatedAtCont = TextEditingController();
    TextEditingController frequencyOfPurchCont = TextEditingController();
    TextEditingController totalPurchCont = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Customers'), actions: [
        IconButton(
            onPressed: () {
              pickFile();
            },
            icon: Icon(Icons.file_present)),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // ignore: prefer_const_constructors
                return AlertDialog(
                  scrollable: true,
                  title: const Text('New Customer'),
                  backgroundColor: Colors.black54,
                  // ignore: prefer_const_constructors
                  content: Form(
                    key: _fromClientKey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Name'),
                            TextFormField(
                              controller: customerNameCont,
                              textCapitalization: TextCapitalization.sentences,
                              decoration:
                                  const InputDecoration(hintText: 'Name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return textFieldVlidMsg;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            const Text('Company Name'),
                            TextFormField(
                              controller: companyNameCont,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration(
                                  hintText: 'Company Name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return textFieldVlidMsg;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            const Text('Bank Name'),
                            TextFormField(
                              controller: bankNameCont,
                              textCapitalization: TextCapitalization.sentences,
                              decoration:
                                  const InputDecoration(hintText: 'Bank Name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return textFieldVlidMsg;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            const Text('Bank Account'),
                            TextFormField(
                              controller: bankAccountCont,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Bank Number'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return textFieldVlidMsg;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            const Text('Tin Number'),
                            TextFormField(
                              controller: tinNumberCont,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(hintText: 'Tin Number'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return textFieldVlidMsg;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            const Text('City'),
                            TextFormField(
                              controller: cityCont,
                              textCapitalization: TextCapitalization.sentences,
                              decoration:
                                  const InputDecoration(hintText: 'City'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return textFieldVlidMsg;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            const Text('Phone Number'),
                            TextFormField(
                              controller: phoneNumberCont,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Phone Number'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return textFieldVlidMsg;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            const SizedBox(height: 5),
                            const Text('Frequency Of Purchase'),
                            TextFormField(
                              controller: frequencyOfPurchCont,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Frequency Of Purchase'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return textFieldVlidMsg;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            const Text('Total Purchase'),
                            TextFormField(
                              controller: totalPurchCont,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Total Purchase'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return textFieldVlidMsg;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                if (_fromClientKey.currentState!.validate()) {
                                  Client clientSQF = Client();
                                  clientSQF.name = customerNameCont.text;
                                  clientSQF.companyName = companyNameCont.text;
                                  clientSQF.bankName = bankNameCont.text;
                                  clientSQF.bankNumber = bankAccountCont.text;
                                  clientSQF.tinNumber = tinNumberCont.text;
                                  clientSQF.city = cityCont.text;
                                  clientSQF.phoneN = phoneNumberCont.text;
                                  clientSQF.purchaseFreq =
                                      int.parse(frequencyOfPurchCont.text);
                                  clientSQF.totPurchase =
                                      double.parse(totalPurchCont.text);
                                  await clientSQF.save();
                                  loadClientData();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    // ignore: prefer_const_constructors
                                    SnackBar(
                                      content: const Text("New Customer Added"),
                                    ),
                                  );
                                  customerNameCont.text = "";
                                  companyNameCont.text = "";
                                  tinNumberCont.text = "";
                                  cityCont.text = "";
                                  phoneNumberCont.text = "";
                                  frequencyOfPurchCont.text = "";
                                  totalPurchCont.text = "";
                                  bankAccountCont.text = "";
                                  Navigator.of(context, rootNavigator: true)
                                      .pop("dialog");
                                }
                              },
                              child: const Text('Create New Customer'),
                            )
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
      ]),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  // Last checked this was causing some kind of error
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 30),
                    height: 80,
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                          color: Color.fromARGB(255, 234, 164, 45),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ],
                      border: Border.all(
                        color: const Color.fromARGB(255, 234, 164, 45),
                        width: 1.5,
                      ),

                      color: Colors.black45,
                      // color: Color.fromARGB(50, 203, 145, 0),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Customers',
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          clientSQFL.length.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 160,
                        height: 140,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 234, 164, 45),
                            width: 1.5,
                          ),

                          color: Colors.black45,
                          // color: Color.fromARGB(50, 203, 145, 0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 234, 164, 45),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 5,
                            )
                          ],

                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              '',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'Total Views',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            const Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 140,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          border: Border.all(
                            color: const Color.fromARGB(255, 234, 164, 45),
                            width: 1.5,
                          ),

                          // color: Color.fromARGB(50, 203, 145, 0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 234, 164, 45),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 4,
                            )
                          ],

                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              newClientMonthly.length.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'New Clients',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'This month',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 52,
                    decoration: BoxDecoration(
                      // color: Color.fromARGB(50, 203, 145, 0),
                      color: Colors.black45,
                      border: Border.all(
                        color: const Color.fromARGB(255, 234, 164, 45),
                        width: 1.5,
                      ),

                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 234, 164, 45),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Row(
                      // ignore: prefer_const_constructors
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'All Clients',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          height: 33,
                          width: 155,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 235, 164, 45),
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.search,
                                color: Color.fromARGB(255, 235, 164, 45),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: TextField(
                                  autocorrect: false,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Quick Search',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 3, bottom: 7, top: 5),
                    height: 395,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      border: Border.all(
                        color: const Color.fromARGB(255, 234, 164, 45),
                        width: 1.5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 234, 164, 45),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: clientSQFL.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            clientNameUpdate.text = clientSQFL[index].name!;
                            companyNameUpdate.text =
                                clientSQFL[index].companyName!;
                            bankNameUpdate.text = clientSQFL[index].bankName!;
                            bankNumberUpdate.text =
                                clientSQFL[index].bankNumber!;
                            tinNumberUpdate.text = clientSQFL[index].tinNumber!;
                            cityUpdate.text = clientSQFL[index].city!;
                            phoneNumberUpdate.text = clientSQFL[index].phoneN!;
                            frequencyOfPurchUpdate.text =
                                clientSQFL[index].purchaseFreq.toString();
                            totalPurchUpdate.text =
                                clientSQFL[index].totPurchase.toString();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.black87,
                                    scrollable: true,
                                    title: const Text('Client Info'),
                                    // ignore: prefer_const_constructors
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Id"),
                                        Text(clientSQFL[index].id.toString()),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text("Name"),
                                        TextFormField(
                                            controller: clientNameUpdate),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text("Company Name"),
                                        TextFormField(
                                            controller: companyNameUpdate),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text("BankName"),
                                        TextFormField(
                                          controller: bankNameUpdate,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text("Bank Number"),
                                        TextFormField(
                                          controller: bankNumberUpdate,
                                          keyboardType: TextInputType.number,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text("Tin Number"),
                                        TextFormField(
                                          controller: tinNumberUpdate,
                                          keyboardType: TextInputType.number,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text("City"),
                                        TextFormField(
                                          controller: cityUpdate,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text("Phone Number"),
                                        TextFormField(
                                          controller: phoneNumberUpdate,
                                          keyboardType: TextInputType.number,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text("Purchase Frequency"),
                                        TextFormField(
                                          controller: frequencyOfPurchUpdate,
                                          keyboardType: TextInputType.number,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text("Total Purchase"),
                                        TextFormField(
                                          controller: totalPurchUpdate,
                                          keyboardType: TextInputType.number,
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
                                                    title:
                                                        const Text('Confirm'),
                                                    content: const Text(
                                                        'You sure to update data?'),
                                                    textOK: const Text('Yes'),
                                                    textCancel:
                                                        const Text('Nah'),
                                                  )) {
                                                    clientSQFL[index].name =
                                                        clientNameUpdate.text;
                                                    clientSQFL[index]
                                                            .companyName =
                                                        companyNameUpdate.text;
                                                    clientSQFL[index].bankName =
                                                        bankNameUpdate.text;
                                                    clientSQFL[index]
                                                            .bankNumber =
                                                        bankNumberUpdate.text;
                                                    clientSQFL[index]
                                                            .tinNumber =
                                                        tinNumberUpdate.text;
                                                    clientSQFL[index].city =
                                                        cityUpdate.text;
                                                    clientSQFL[index].phoneN =
                                                        phoneNumberUpdate.text;
                                                    clientSQFL[index]
                                                            .purchaseFreq =
                                                        int.parse(
                                                            frequencyOfPurchUpdate
                                                                .text);
                                                    clientSQFL[index]
                                                            .totPurchase =
                                                        double.parse(
                                                            totalPurchUpdate
                                                                .text);
                                                    await clientSQFL[index]
                                                        .save();
                                                    loadClientData();
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop("dialog");
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          "Client Info Updated Successfully",
                                                        ),
                                                      ),
                                                    );

                                                    // clientSQFL[index]. = clientNameUpdate.text;
                                                  }
                                                },
                                                child: const Text("Update")),
                                            ElevatedButton(
                                              onPressed: () async {
                                                if (await confirm(context,
                                                    title:
                                                        const Text('Confirm'),
                                                    content: const Text(
                                                        'Are you sure!'),
                                                    textOK: const Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                    ),
                                                    textCancel:
                                                        const Text('No'))) {
                                                  await Client()
                                                      .select()
                                                      .id
                                                      .equals(
                                                          clientSQFL[index].id)
                                                      .delete();
                                                  loadClientData();
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop("dialog");
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          "Client Info deleted Successfully"),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blueGrey,
                              ),
                              Container(
                                width: 305,
                                height: 80,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromARGB(255, 235, 164, 45),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            clientSQFL[index].name!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            clientSQFL[index].companyName!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1.05,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: Color.fromARGB(
                                                    50, 89, 225, 54)),
                                            height: 27,
                                            child: Text(
                                              clientSQFL[index]
                                                  .purchaseFreq
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    204, 89, 225, 54),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'ETB ${clientSQFL[index].totPurchase}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 235, 164, 45),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
