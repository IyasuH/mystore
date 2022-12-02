import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:avatars/avatars.dart';

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
                  'Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active_outlined),
                )
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Current Balance'),
                    Text('ETB 40,000'),
                  ],
                ),
              ],
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Bank Accounts'),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 165,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  width: 315,
                  margin: const EdgeInsets.symmetric(vertical: 0),
                  decoration: const BoxDecoration(
                      // color: Colors.amber,
                      ),
                  height: 165,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: customers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 260,
                          margin: const EdgeInsets.only(right: 20),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
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
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text('.... 1122 4595 7852'),
                                ],
                              ),
                              Row(
                                // ignore: prefer_const_constructors
                                children: const [Text('ETB 5,000')],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('EAYASU HAILEGEBRIEL'),
                                  Avatar(
                                    // radius: 30,
                                    sources: [
                                      GenericSource(
                                          AssetImage('assets/MasterCard.png'))
                                    ],
                                    // backgroundImage:
                                    //     const AssetImage('assets/masterCard.png'),
                                    backgroundColor: Colors.green,
                                    shape: AvatarShape.rectangle(
                                      75,
                                      60,
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
