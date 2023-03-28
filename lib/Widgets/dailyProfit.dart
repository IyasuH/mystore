// ignore_for_file: file_names, implementation_imports
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/src/widgets/basic.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DailyBarChart extends StatefulWidget {
  List last7daysProfit;
  double todaySales;
  double todaysExpense;
  DailyBarChart({
    super.key,
    required this.todaySales,
    required this.todaysExpense,
    required this.last7daysProfit,
  });

  @override
  State<DailyBarChart> createState() => _DailyBarChartState();
}

class _DailyBarChartState extends State<DailyBarChart> {
  // double zeroProfit = 0;
  List<String> last7MY = [];
  List<String> last7Days = [];
  DateTime today = DateTime.now();
  loadDays() {
    last7Days = [];
    for (var i = 1; i <= 7; i++) {
      last7MY.add(DateFormat('m/y').format(today.subtract(Duration(days: i))));
      last7Days.add(DateFormat.E().format(today.subtract(Duration(days: i))));
    }
    // last7Days = last7Days.sublist(1);
  }

  @override
  void initState() {
    // zeroProfit = 0;
    print("todays sales");
    print(widget.todaySales.toString());
    // zeroProfit = ((widget.todaySales * .25) - widget.todaysExpense);
    loadDays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 8.0, top: 20.0, left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(DateFormat.EEEE().format(today),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
              )),
          // const SizedBox(
          //   height: 0,
          // ),
          Text(
            DateFormat('MMMM d, y').format(today),
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    widget.todaySales.toString(),
                    style: const TextStyle(
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
                children: [
                  Text(
                    ((widget.todaySales * .25) - widget.todaysExpense)
                        .toString(),
                    style: const TextStyle(
                      color: Color.fromRGBO(76, 175, 80, 1),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
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
                  Text(widget.todaysExpense.toString(),
                      style: const TextStyle(
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
                  // itemCount: last7Days.length,
                  itemCount: widget.last7daysProfit.length,
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
                        children: [
                          Text(
                            last7Days[index],
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            widget.last7daysProfit[index].toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            last7MY[index],
                            style: const TextStyle(color: Colors.grey),
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
