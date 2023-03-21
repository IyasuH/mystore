// ignore: file_names
// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:avatars/avatars.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../models/model.dart';

class AcoountTab extends StatefulWidget {
  const AcoountTab({super.key});

  @override
  State<AcoountTab> createState() => _AcoountTabState();
}

class _AcoountTabState extends State<AcoountTab> {
  List<Bank> bankTotList = [];
  double totalInBalance = 0;
  loadTotBank() async {
    totalInBalance = 0;
    bankTotList = await Bank().select().toList();
    for (var ele in bankTotList) {
      totalInBalance += ele.amount!;
    }
    setState(() {});
  }

  @override
  void initState() {
    loadTotBank();
    super.initState();
  }

  String textFieldVlidMsg = "Please enter some value";
  final _formBankKey = GlobalKey<FormState>();
  final bankSQF = Bank();
  @override
  Widget build(BuildContext context) {
    TextEditingController bankNameCont = TextEditingController();
    TextEditingController bankNumCont = TextEditingController();
    TextEditingController bankAmountCont = TextEditingController();
    DateFormat dateFormat = DateFormat("yyyy/MM/dd");
    DateTime bankCreatedateFCont = DateTime.now();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 24, 13, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blueGrey,
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ],
                      border: Border.all(color: Colors.blueGrey, width: 2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Total Balance',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            letterSpacing: 1.3,
                            wordSpacing: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '\$ $totalInBalance',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(24),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blueGrey,
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ],
                      border: Border.all(color: Colors.blueGrey, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Total Accounts',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            letterSpacing: 1.3,
                            wordSpacing: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          bankTotList.length.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ignore: prefer_const_constructors
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DottedBorder(
                    // padding: EdgeInsets.symmetric(vertical: 7),
                    color: Colors.blueGrey,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(24),
                    strokeWidth: 2,
                    dashPattern: const [10, 5],
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // ignore: prefer_const_constructors
                              return AlertDialog(
                                backgroundColor: Colors.black87,
                                scrollable: true,
                                title: const Text('Add Account'),
                                // backgroundColor:
                                //     const Color.fromARGB(255, 60, 59, 59),
                                content: Form(
                                  key: _formBankKey,
                                  child: Column(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Bank'),
                                        const SizedBox(height: 5),
                                        TextFormField(
                                          controller: bankNameCont,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          onChanged: ((value) {}),
                                          decoration: const InputDecoration(
                                              hintText: 'Bank Name'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return textFieldVlidMsg;
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        const Text('Account Number'),
                                        TextFormField(
                                          controller: bankNumCont,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              hintText: 'Account Number'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return textFieldVlidMsg;
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        const Text('Amount'),
                                        TextFormField(
                                          controller: bankAmountCont,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              hintText: 'Current Amount'),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return textFieldVlidMsg;
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        const Text("Account Created At"),
                                        TextButton(
                                          child: Text(
                                            DateFormat()
                                                .add_yMd()
                                                .format(DateTime.now()),
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                              // currentTime: ,
                                              context,
                                              showTitleActions: true,
                                              minTime: DateTime(2022, 1, 1),
                                              maxTime: DateTime(2030, 12, 30),
                                              theme: const DatePickerTheme(
                                                headerColor: Colors.black,
                                                backgroundColor: Colors.black,
                                                itemStyle: TextStyle(
                                                    color: Colors.white),
                                                doneStyle: TextStyle(
                                                    color: Colors.white),
                                                cancelStyle: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onConfirm: (date) {
                                                bankCreatedateFCont = date;
                                                print('confirm $date');
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (_formBankKey.currentState!
                                            .validate()) {
                                          bankSQF.name = bankNameCont.text;
                                          bankSQF.accountNumber =
                                              bankNumCont.text;
                                          bankSQF.amount =
                                              double.parse(bankAmountCont.text);
                                          bankSQF.accountDate =
                                              bankCreatedateFCont;
                                          await bankSQF.save();
                                          loadTotBank();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "New Expese Added",
                                              ),
                                            ),
                                          );
                                          bankNameCont.text = "";
                                          bankNumCont.text = "";
                                          bankAmountCont.text = "";
                                          bankCreatedateFCont = DateTime.now();
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop("dialog");
                                        }
                                        ;
                                      },
                                      child: const Text("Save New Account"),
                                    ),
                                  ]),
                                ),
                              );
                            });
                      },
                      borderRadius: const BorderRadius.all(
                        Radius.circular(24),
                      ),
                      child: Container(
                        // margin: const EdgeInsets.only(bottom: 7.0, top: 10.0),
                        padding: const EdgeInsets.only(bottom: 0.0, top: 0),
                        alignment: Alignment.center,
                        width: 400,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Bank Accounts',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.4,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      // color: Colors.amber,
                      ),
                  height: 425,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: bankTotList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 4.0),
                          height: 200,
                          // width: 314.8,
                          padding:
                              const EdgeInsets.fromLTRB(15, 6.0, 15.0, 5.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 4,
                              )
                            ],
                            border:
                                Border.all(color: Colors.blueGrey, width: 2),
                            color: Colors.black45,
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    bankTotList[index].name!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.more_horiz_rounded),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, top: 5.0),
                                child: Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text(
                                      bankTotList[index].accountNumber!,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        letterSpacing: 1.6,
                                        wordSpacing: 2.5,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  // ignore: prefer_const_constructors
                                  children: [
                                    Text(
                                      '\$ ${bankTotList[index].amount!}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.5),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // bankTotList[index].accountDate.toString(),
                                    DateFormat('yyyy-MM-dd').format(
                                        bankTotList[index].accountDate!),
                                    style: const TextStyle(
                                      letterSpacing: 2.0,
                                      wordSpacing: 4.0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Avatar(
                                    // radius: 30,
                                    sources: [
                                      GenericSource(
                                        const AssetImage(
                                            'assets/MasterCard.png'),
                                      )
                                    ],
                                    backgroundColor: Colors.black54,
                                    shape: AvatarShape.rectangle(
                                      75,
                                      55,
                                      const BorderRadius.all(
                                        Radius.circular(3.0),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
