import 'package:flutter/material.dart';

import '../models/clients.dart';

class CustomerTab extends StatefulWidget {
  const CustomerTab({super.key});

  @override
  State<CustomerTab> createState() => _CustomerTabState();
}

class _CustomerTabState extends State<CustomerTab> {
  @override
  Widget build(BuildContext context) {
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
                  title: const Text('New Customer'),
                  backgroundColor: Colors.black54,
                  // ignore: prefer_const_constructors
                  content: SizedBox(
                    height: 400,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Cutomer Name'),
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: ((value) {}),
                              decoration: const InputDecoration(
                                  hintText: 'Cutomer Name'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Company Name'),
                            TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: ((value) {}),
                              decoration: const InputDecoration(
                                  hintText: 'Cutomer Name'),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Save'),
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
                        vertical: 23, horizontal: 30),
                    height: 100,
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Clients',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              customers.length.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 235, 164, 45),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.keyboard_arrow_right,
                              size: 28,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 45,
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 3, bottom: 7),
                    height: 365,
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
                    child: ListView.builder(
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
                              height: 75,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 235, 164, 45),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, right: 2),
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
                                          customers[index].customerName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          customers[index].companyName,
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
                                            customers[index].membership,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  204, 89, 225, 54),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'ETB ${customers[index].totalPurchase}',
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
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_vert,
                                ))
                          ],
                        );
                      },
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
                        child: const Text('Views'),
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
                        child: Text('Active Clients'),
                      ),
                    ],
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
                        child: Text('New This Month'),
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
                        child: Text('Top Clients'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
