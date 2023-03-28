// ignore_for_file: file_names, implementation_imports
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/src/widgets/basic.dart';

class DailyBarChart extends StatefulWidget {
  const DailyBarChart({super.key});

  @override
  State<DailyBarChart> createState() => _DailyBarChartState();
}

class _DailyBarChartState extends State<DailyBarChart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 8.0, top: 20.0, left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text('Sunday',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
              )),
          // const SizedBox(
          //   height: 0,
          // ),
          const Text(
            'March 26, 2023',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    '\$ 4000',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 84, 195, 88),
                    ),
                  ),
                  Text(
                    'Sales',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey.shade600,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                    '\$ 2,500',
                    style: TextStyle(
                      color: Color.fromRGBO(76, 175, 80, 1),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Todays Profit',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                      letterSpacing: 1.5,
                      wordSpacing: 1.8,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('\$ 500',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 84, 195, 88),
                      )),
                  Text(
                    'Expense',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 125,
            width: 380,
            // color: Colors.amber
            decoration: const BoxDecoration(
              // color: Colors.black26,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      height: 120,
                      width: 110,
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.all(Radius.circular(23)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Sat',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            '\$ 1000',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '03/23',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
