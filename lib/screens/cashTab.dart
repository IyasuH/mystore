import 'package:flutter/material.dart';

class CashTab extends StatefulWidget {
  const CashTab({super.key});

  @override
  State<CashTab> createState() => _CashTabState();
}

class _CashTabState extends State<CashTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 24, 13, 10),
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
              height: 658,
              // padding: EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: [
                        // ignore: prefer_const_constructors
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              height: 40,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(top: 10, left: 5),
                              decoration: const BoxDecoration(
                                // color: Colors.amber,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey,
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: const Text(
                                'Cash',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              width: 120,
                              height: 40,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(top: 10, right: 5),
                              decoration: const BoxDecoration(
                                // color: Colors.amber,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey,
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: const Text(
                                'Deposit',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 270,
                          margin: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 3),
                          decoration: const BoxDecoration(
                            // color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 5,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              height: 40,
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 5),
                              decoration: const BoxDecoration(
                                // color: Colors.greenAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey,
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: const Text(
                                'Account',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              width: 120,
                              height: 40,
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsets.only(right: 5),
                              decoration: const BoxDecoration(
                                // color: Colors.greenAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey,
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: const Text(
                                'Deposit',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 270,
                          margin: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 3),
                          decoration: const BoxDecoration(
                            // color: Colors.greenAccent,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 5,
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
}
