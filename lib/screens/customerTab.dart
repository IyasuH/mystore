import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../db/storeDB.dart';
import '../models/clients.dart';

class CustomerTab extends StatefulWidget {
  const CustomerTab({super.key});

  @override
  State<CustomerTab> createState() => _CustomerTabState();
}

class _CustomerTabState extends State<CustomerTab> {
  final bankDB = myStoreDatabaseHelper();

  @override
  void initState() {
    bankDB.init();
    super.initState();
  }

  String customLen = customers.length.toString();
  @override
  Widget build(BuildContext context) {
    TextEditingController customerNameCont = TextEditingController();
    TextEditingController companyNameCont = TextEditingController();
    TextEditingController tinNumberCont = TextEditingController();
    TextEditingController cityCont = TextEditingController();
    TextEditingController phoneNumberCont = TextEditingController();
    DateFormat dateFormat = DateFormat("yyyy/MM/dd");
    String accountCreatedAtCont = dateFormat.format(DateTime.now());
    // TextEditingController accountCreatedAtCont = TextEditingController();
    TextEditingController frequencyOfPurchCont = TextEditingController();
    TextEditingController totalPurchCont = TextEditingController();
    TextEditingController bankAccountCont = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Customers'), actions: [
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
                  content: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Cutomer Name'),
                          TextFormField(
                            controller: customerNameCont,
                            textCapitalization: TextCapitalization.sentences,
                            decoration:
                                const InputDecoration(hintText: 'Cutomer Name'),
                          ),
                          const SizedBox(height: 5),
                          const Text('Company Name'),
                          TextFormField(
                            controller: companyNameCont,
                            textCapitalization: TextCapitalization.sentences,
                            decoration:
                                const InputDecoration(hintText: 'Company Name'),
                          ),
                          const SizedBox(height: 5),
                          const Text('Tin Number'),
                          TextFormField(
                            controller: tinNumberCont,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: 'Tin Number'),
                          ),
                          const SizedBox(height: 5),
                          const Text('City'),
                          TextFormField(
                            controller: cityCont,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(hintText: 'City'),
                          ),
                          const SizedBox(height: 5),
                          const Text('Phone Number'),
                          TextFormField(
                            controller: phoneNumberCont,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: 'Phone Number'),
                          ),
                          const SizedBox(height: 5),
                          const Text('Account Created At'),
                          TextButton(
                            child: Text(
                              DateFormat().add_yMd().format(DateTime.now()),
                              style: const TextStyle(fontSize: 16),
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
                                  itemStyle: TextStyle(color: Colors.white),
                                  doneStyle: TextStyle(color: Colors.white),
                                  cancelStyle: TextStyle(color: Colors.white),
                                ),
                                onConfirm: (date) {
                                  accountCreatedAtCont =
                                      dateFormat.format(date);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 5),
                          const Text('Frequency Of Purchase'),
                          TextFormField(
                            controller: frequencyOfPurchCont,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Frequency Of Purchase'),
                          ),
                          const SizedBox(height: 5),
                          const Text('Total Purchase'),
                          TextFormField(
                            controller: totalPurchCont,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                hintText: 'Total Purchase'),
                          ),
                          const SizedBox(height: 5),
                          const Text('Bank Account'),
                          TextFormField(
                            controller: bankAccountCont,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(hintText: 'Bank Account'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              bankDB.insertCustomer(
                                customerNameCont.text,
                                companyNameCont.text,
                                tinNumberCont.text,
                                cityCont.text,
                                phoneNumberCont.text,
                                accountCreatedAtCont,
                                frequencyOfPurchCont.text,
                                totalPurchCont.text,
                                bankAccountCont.text,
                              );
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
                              accountCreatedAtCont =
                                  dateFormat.format(DateTime.now());
                              frequencyOfPurchCont.text = "";
                              totalPurchCont.text = "";
                              bankAccountCont.text = "";
                              Navigator.of(context, rootNavigator: true)
                                  .pop("dialog");
                            },
                            child: const Text('Create New Customer'),
                          )
                        ],
                      )
                    ],
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
                          blurRadius: 5,
                        )
                      ],
                      color: Colors.black12,
                      // color: Color.fromARGB(50, 203, 145, 0),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
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
                          customLen,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                        // Container(
                        //   width: 43,
                        //   height: 43,
                        //   decoration: const BoxDecoration(
                        //     color: Color.fromARGB(255, 235, 164, 45),
                        //     borderRadius: BorderRadius.all(
                        //       Radius.circular(10),
                        //     ),
                        //   ),
                        //   child: IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(
                        //       Icons.keyboard_arrow_right,
                        //       size: 28,
                        //     ),
                        //   ),
                        // )
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
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          // color: Color.fromARGB(50, 203, 145, 0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 234, 164, 45),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 5,
                            )
                          ],

                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              '58',
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
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          // color: Color.fromARGB(50, 203, 145, 0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 234, 164, 45),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 5,
                            )
                          ],

                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              '170',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              'New Customers',
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
                    decoration: const BoxDecoration(
                      // color: Color.fromARGB(50, 203, 145, 0),
                      color: Colors.black12,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 234, 164, 45),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 5,
                        )
                      ],

                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    child: Row(
                      // ignore: prefer_const_constructors
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'All Customers',
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
                            color: Colors.black12,
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 235, 164, 45),
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
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                        // color: Colors.amber,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Color.fromARGB(50, 203, 145, 0),
                        //     blurStyle: BlurStyle.solid,
                        //   )
                        // ],
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 234, 164, 45),
                            blurStyle: BlurStyle.outer,
                            blurRadius: 5,
                          )
                        ],

                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: FutureBuilder(
                          future: _query(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              // datas = snapshot.data;
                              return ListView.builder(
                                itemCount: customers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: <Widget>[
                                      const CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.blueGrey,
                                      ),
                                      Container(
                                        width: 274,
                                        height: 80,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 235, 164, 45),
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    customers[index]
                                                        .customerName,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  Text(
                                                    customers[index]
                                                        .companyName,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      letterSpacing: 1.05,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                    decoration:
                                                        const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            5)),
                                                            color:
                                                                Color.fromARGB(
                                                                    50,
                                                                    89,
                                                                    225,
                                                                    54)),
                                                    height: 27,
                                                    child: Text(
                                                      customers[index]
                                                          .membership,
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            204, 89, 225, 54),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'ETB ${customers[index].totalPurchase}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.more_vert,
                                          ))
                                    ],
                                  );
                                },
                              );
                            }
                            return Container(
                              // ignore: prefer_const_constructors
                              padding: EdgeInsets.symmetric(
                                  vertical: 110.0, horizontal: 7.0),
                              child: CircularProgressIndicator(),
                            );
                          })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _query() async {
    List<Map> customer = await bankDB.queryAllAccount();
    return customer;
  }
}
