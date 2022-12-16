import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
// ignore: depend_on_referenced_packages
import 'package:avatars/avatars.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../models/clients.dart';

class AcoountTab extends StatefulWidget {
  const AcoountTab({super.key});

  @override
  State<AcoountTab> createState() => _AcoountTabState();
}

class _AcoountTabState extends State<AcoountTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 24, 13, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
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
                    icon: const Icon(Icons.notifications_active_outlined),
                  ),
                )
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
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey,
                          blurStyle: BlurStyle.outer,
                          blurRadius: 7,
                        )
                      ],
                      borderRadius: BorderRadius.all(
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
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'ETB 40,000',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 170,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey,
                          blurStyle: BlurStyle.outer,
                          blurRadius: 7,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Total Accounts',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          '10',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
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
                                title: const Text('Add Account'),
                                backgroundColor:
                                    const Color.fromARGB(255, 60, 59, 59),
                                content: SizedBox(
                                  height: 270,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Expenses'),
                                            TextFormField(
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              onChanged: ((value) {}),
                                              decoration: const InputDecoration(
                                                  hintText: 'Bank Name'),
                                            )
                                          ]),
                                      const SizedBox(height: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Amount'),
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                hintText: 'Current Amount'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Amount'),
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                hintText: 'Current Amount'),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        child: Text(
                                          DateFormat()
                                              .add_yMd()
                                              .format(DateTime.now()),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        onPressed: () {
                                          DatePicker.showDatePicker(
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
                                              print('confirm $date');
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
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
                          color: Colors.black12,
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
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Bank Accounts',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
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
                  height: 415,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: customers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 4.0),
                          height: 190,
                          // width: 314.8,
                          padding:
                              const EdgeInsets.fromLTRB(15, 11.0, 15.0, 5.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 7,
                              )
                            ],
                            color: Colors.black12,
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'CBE',
                                    style: TextStyle(
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
                                    const Text(
                                      '4567 1122 4595 7852',
                                      style: TextStyle(
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
                                  children: const [
                                    Text(
                                      'ETB 5,000',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800),
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
                                  const Text(
                                    'EYASU HAILEGEBRIEL',
                                    style: TextStyle(
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
                                    // backgroundImage:
                                    //     const AssetImage('assets/masterCard.png'),
                                    backgroundColor: Colors.black38,
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
