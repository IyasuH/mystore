// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mystore/Widgets/dailyProfit.dart';
import 'package:mystore/Widgets/monthlyProfit.dart';
import 'package:mystore/Widgets/yearlyProfit.dart';

import '../Widgets/weeklyProfit.dart';
import '../models/model.dart';

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class ProfitTab extends StatefulWidget {
  const ProfitTab({super.key});

  @override
  State<ProfitTab> createState() => _ProfitTabState();
}

class _ProfitTabState extends State<ProfitTab> {
  List<Sale> salesAll = [];
  List<Sale> salesTY = [];
  List<Sale> salesTM = [];
  List<Sale> weeklySales = [];
  List<Sale> last7daysSales = [];
  List<Expense> expenseAll = [];
  List<Expense> expenseTY = [];
  List<Expense> expenseTM = [];
  List<Expense> weeklyExpense = [];
  List<Expense> last7daysExpense = [];
  List<double> last7daysProfit = [];
  List<double> monthlyProfit = [];
  double totalProfitThisMonth = 0;
  double avgMonthlyProfit = 0;
  double todaySales = 0;
  double totalSalesRTY = 0;
  double totalExpeseATY = 0;
  // total profit this year
  double totalProfit = 0;
  // total weekly profit
  double totalWeeklyprofit = 0;
  double avgWeeklyProfit = 0;
  double JanProfit = 0,
      FebProfit = 0,
      MarProfit = 0,
      AprProfit = 0,
      MayProfit = 0,
      JunProfit = 0,
      JulProfit = 0,
      AugProfit = 0,
      SepProfit = 0,
      OctProfit = 0,
      NovProfit = 0,
      DecProfit = 0,
      //
      JanExpen = 0,
      FebExpen = 0,
      MarExpen = 0,
      AprExpen = 0,
      MayExpen = 0,
      JunExpen = 0,
      JulExpen = 0,
      AugExpen = 0,
      SepExpen = 0,
      OctExpen = 0,
      NovExpen = 0,
      DecExpen = 0,
      //
      JanSales = 0,
      FebSales = 0,
      MarSales = 0,
      AprSales = 0,
      MaySales = 0,
      JunSales = 0,
      JulSales = 0,
      AugSales = 0,
      SepSales = 0,
      OctSales = 0,
      NovSales = 0,
      DecSales = 0,
      //
      monProfit = 0,
      tuesProfit = 0,
      wedProfit = 0,
      thurProfit = 0,
      firProfit = 0,
      satProfit = 0,
      sunProfit = 0,
      //
      monSales = 0,
      tuesSales = 0,
      wedSales = 0,
      thurSales = 0,
      firSales = 0,
      satSales = 0,
      sunSales = 0,
      //
      monExpes = 0,
      tuesExpes = 0,
      wedPExpes = 0,
      thurExpes = 0,
      firExpes = 0,
      satExpes = 0,
      sunExpes = 0,
      //
      zeroDSales = 0, // which means today
      firstDSales = 0,
      secondDSales = 0,
      thirdDSales = 0,
      fourthDSales = 0,
      fithDSales = 0,
      sixDSales = 0,
      //
      zeroDExpes = 0, // which means today
      firstDExpes = 0,
      secondDExpes = 0,
      thirdDExpes = 0,
      fourthDExpes = 0,
      fithDExpes = 0,
      sixDExpes = 0;

  loadYearlyData() async {
    salesAll = await Sale().select().toList();
    expenseAll = await Expense().select().toList();
    salesTY = [];
    salesTM = [];
    expenseTY = [];
    expenseTM = [];
    totalSalesRTY = 0;
    totalExpeseATY = 0;
    for (var ele in salesAll) {
      if ((ele.date!).year == (DateTime.now().year)) {
        salesTY.add(ele);
        totalSalesRTY += (ele.revenue!);
        if ((ele.date!).month == (DateTime.now().month)) {
          print("at least one sales");
          salesTM.add(ele);
        }
      }
    }
    for (var ele in expenseAll) {
      if ((ele.date!).year == (DateTime.now().year)) {
        expenseTY.add(ele);
        totalExpeseATY += (ele.amount!);
        if ((ele.date!).month == DateTime.now().month) {
          expenseTM.add(ele);
        }
      }
    }
    loadMonthlyData();
    loadWeekData();
    loadLast7daysData();
    todaySales = (zeroDSales * .25) - zeroDExpes;
    for (var element in salesTY) {
      if ((element.date!).month == 1) {
        JanSales += element.revenue!;
      } else if ((element.date!).month == 2) {
        FebSales += element.revenue!;
      } else if ((element.date!).month == 3) {
        MarSales += element.revenue!;
      } else if ((element.date!).month == 4) {
        AprSales += element.revenue!;
      } else if ((element.date!).month == 5) {
        MaySales += element.revenue!;
      } else if ((element.date!).month == 6) {
        JunSales += element.revenue!;
      } else if ((element.date!).month == 7) {
        JulSales += element.revenue!;
      } else if ((element.date!).month == 8) {
        AugSales += element.revenue!;
      } else if ((element.date!).month == 9) {
        SepSales += element.revenue!;
      } else if ((element.date!).month == 10) {
        OctSales += element.revenue!;
      } else if ((element.date!).month == 11) {
        NovSales += element.revenue!;
      } else if ((element.date!).month == 12) {
        DecSales += element.revenue!;
      }
    }

    for (var element in expenseTY) {
      if ((element.date!).month == 1) {
        JanExpen += element.amount!;
      } else if ((element.date!).month == 2) {
        FebExpen += element.amount!;
      } else if ((element.date!).month == 3) {
        MarExpen += element.amount!;
      } else if ((element.date!).month == 4) {
        AprExpen += element.amount!;
      } else if ((element.date!).month == 5) {
        MayExpen += element.amount!;
      } else if ((element.date!).month == 6) {
        JunExpen += element.amount!;
      } else if ((element.date!).month == 7) {
        JulExpen += element.amount!;
      } else if ((element.date!).month == 8) {
        AugExpen += element.amount!;
      } else if ((element.date!).month == 9) {
        SepExpen += element.amount!;
      } else if ((element.date!).month == 10) {
        OctExpen += element.amount!;
      } else if ((element.date!).month == 11) {
        NovExpen += element.amount!;
      } else if ((element.date!).month == 12) {
        DecExpen += element.amount!;
      }
    }

    JanProfit = JanSales * .25 - JanExpen;
    FebProfit = FebSales * .25 - FebExpen;
    MarProfit = MarSales * .25 - MarExpen;
    AprProfit = AprSales * .25 - AprExpen;
    MayProfit = MaySales * .25 - MayExpen;
    JunProfit = JunSales * .25 - JunExpen;
    JulProfit = JulSales * .25 - JulExpen;
    AugProfit = AugSales * .25 - AprExpen;
    SepProfit = SepSales * .25 - SepExpen;
    OctProfit = OctSales * .25 - OctExpen;
    NovProfit = NovSales * .25 - NovExpen;
    DecProfit = DecSales * .25 - DecExpen;
    totalProfit = totalSalesRTY * .25 - totalExpeseATY;
    setState(() {});
  }

  sepcificProfit(int forDay) {
    num thisDaySales = 0;
    num thisDayExpense = 0;
    for (var ele in salesTM) {
      if ((ele.date!).day == forDay) {
        thisDaySales += (ele.revenue!);
      }
    }
    for (var ele in expenseTM) {
      if ((ele.date!).day == forDay) {
        thisDayExpense += (ele.amount!);
      }
    }
    return thisDaySales * .25 - thisDayExpense;
  }

  loadMonthlyData() {
    monthlyProfit = [];
    totalProfitThisMonth = 0;
    int numDay = DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
    for (var day = 1; day <= numDay; day++) {
      totalProfitThisMonth += sepcificProfit(day);
      monthlyProfit.add(sepcificProfit(day));
    }
    // 22 is average working day per month in ETH
    avgMonthlyProfit = totalProfitThisMonth / 22;
  }

  // here frst geting the monday date
  DateTime monstRecentMonday(DateTime date) {
    return DateTime(date.year, date.month, date.day - (date.weekday - 1));
  }
  // load7daysData(){

  // }
  DateTime today = DateTime.now();
  loadWeekData() {
    weeklySales = [];
    weeklyExpense = [];
    DateTime startDate = monstRecentMonday(today);
    for (var ele in salesTY) {
      if ((ele.date!.isAfter(startDate) ||
              ele.date!.isAtSameMomentAs(startDate)) &&
          (ele.date!.isBefore(today) || ele.date!.isAtSameMomentAs(today))) {
        weeklySales.add(ele);
      }
    }
    for (var ele in expenseTY) {
      if ((ele.date!.isAfter(startDate) ||
              ele.date!.isAtSameMomentAs(startDate)) &&
          (ele.date!.isBefore(today) || ele.date!.isAtSameMomentAs(today))) {
        weeklyExpense.add(ele);
      }
    }
    for (var ele in weeklySales) {
      if (DateFormat.EEEE().format(ele.date!) == 'Monday') {
        monSales += ele.revenue!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Tuesday') {
        tuesSales += ele.revenue!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Wednsday') {
        wedSales += ele.revenue!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Thursday') {
        thurSales += ele.revenue!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Friday') {
        firSales += ele.revenue!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Saturday') {
        satSales += ele.revenue!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Sunday') {
        sunSales += ele.revenue!;
      }
    }

    for (var ele in weeklyExpense) {
      if (DateFormat.EEEE().format(ele.date!) == 'Monday') {
        monExpes += ele.amount!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Tuseday') {
        tuesExpes += ele.amount!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Wednsday') {
        wedPExpes += ele.amount!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Thursday') {
        thurExpes += ele.amount!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Friday') {
        firExpes += ele.amount!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Saturday') {
        satExpes += ele.amount!;
      } else if (DateFormat.EEEE().format(ele.date!) == 'Sunday') {
        sunExpes += ele.amount!;
      }
    }
    monProfit = monSales * .25 - monExpes;
    tuesProfit = tuesSales * .25 - tuesExpes;
    wedProfit = wedSales * .25 - wedPExpes;
    thurProfit = thurSales * .25 - thurExpes;
    firProfit = firSales * .25 - firExpes;
    satProfit = satSales * .25 - satExpes;
    sunProfit = sunSales * .25 - sunExpes;
    totalWeeklyprofit = monProfit +
        tuesProfit +
        wedProfit +
        thurProfit +
        firProfit +
        satProfit +
        sunProfit;
    avgWeeklyProfit = totalWeeklyprofit / 7;
  }

  loadLast7daysData() {
    last7daysSales = [];
    last7daysExpense = [];
    // print("last 7 days func");
    DateTime startDate = today.subtract(Duration(days: 7));
    for (var ele in salesTY) {
      if ((ele.date!.isAfter(startDate) ||
              ele.date!.isAtSameMomentAs(startDate)) &&
          (ele.date!.isBefore(today) || ele.date!.isAtSameMomentAs(today))) {
        last7daysSales.add(ele);
      }
    }
    for (var ele in last7daysSales) {
      // if (ele.date!.compareTo(today) == 0) {
      if (DateUtils.isSameDay(ele.date!, today)) {
        // print("there is profit today");
        // print(ele.date);
        zeroDSales += ele.revenue!;
      } else if (DateUtils.isSameDay(
          ele.date!, today.subtract(Duration(days: 1)))) {
        firstDSales += ele.revenue!;
      } else if (DateUtils.isSameDay(
          ele.date!, today.subtract(Duration(days: 2)))) {
        secondDSales += ele.revenue!;
      } else if (DateUtils.isSameDay(
          ele.date!, today.subtract(Duration(days: 3)))) {
        thirdDSales += ele.revenue!;
      } else if (DateUtils.isSameDay(
          ele.date!, today.subtract(Duration(days: 4)))) {
        fourthDSales += ele.revenue!;
      } else if (DateUtils.isSameDay(
          ele.date!, today.subtract(Duration(days: 5)))) {
        fithDSales += ele.revenue!;
      } else if (DateUtils.isSameDay(
          ele.date!, today.subtract(Duration(days: 6)))) {
        sixDSales += ele.revenue!;
      }
    }
    for (var ele in expenseTY) {
      if ((ele.date!.isAfter(startDate) ||
              ele.date!.isAtSameMomentAs(startDate)) &&
          (ele.date!.isBefore(today) || ele.date!.isAtSameMomentAs(today))) {
        last7daysExpense.add(ele);
      }
    }
    for (var ele in last7daysExpense) {
      if (ele.date! == today) {
        zeroDExpes += ele.amount!;
      } else if (ele.date! == today.subtract(Duration(days: 1))) {
        firstDExpes += ele.amount!;
      } else if (ele.date! == today.subtract(Duration(days: 2))) {
        secondDExpes += ele.amount!;
      } else if (ele.date! == today.subtract(Duration(days: 1))) {
        thirdDExpes += ele.amount!;
      } else if (ele.date! == today.subtract(Duration(days: 1))) {
        fourthDExpes += ele.amount!;
      } else if (ele.date! == today.subtract(Duration(days: 1))) {
        fithDExpes += ele.amount!;
      } else if (ele.date! == today.subtract(Duration(days: 1))) {
        sixDExpes += ele.amount!;
      }
    }
    // zeroDSales * .25 - zeroDExpes,
    last7daysProfit = [
      // zeroDSales * .25 - zeroDExpes,
      firstDSales * .25 - firstDExpes,
      secondDSales * .25 - secondDExpes,
      thirdDSales * .25 - thirdDExpes,
      fourthDSales * .25 - fourthDExpes,
      fithDSales * .25 - fithDExpes,
      sixDSales * 25 - sixDExpes,
    ];
  }

  @override
  void initState() {
    // print("Is this loading!");
    loadYearlyData();
    super.initState();
  }

  Color thirtyPerCentColor = Colors.grey;
  int _selectedIndex = 0;
  final List<String> _profitTimely = ["D", "W", "M", "Y"];
  Widget _buildTimelyChoose(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 55.0,
        width: 55.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedIndex == index ? Colors.green : Colors.white10,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _selectedIndex == index
                  ? const Color.fromARGB(255, 1, 203, 105)
                  : Colors.black26,
              // spreadRadius: 1.5,
              blurRadius: 5,
              blurStyle: BlurStyle.outer,
            )
          ],
          borderRadius: BorderRadius.circular(19),
        ),
        child: Center(
          child: Text(
            _profitTimely[index],
            // textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: _selectedIndex == index
                  ? const Color.fromARGB(255, 1, 203, 105)
                  : Colors.white,
              fontWeight:
                  _selectedIndex == index ? FontWeight.w500 : FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _profitTimely
                    .asMap()
                    .entries
                    .map(
                      (MapEntry map) => _buildTimelyChoose(map.key),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // calling diferent graphs based on different timely choices
            SizedBox(
              height: 350,
              child: _selectedIndex == 0
                  ? DailyBarChart(
                      todaySales: zeroDSales,
                      todaysExpense: zeroDExpes,
                      last7daysProfit: last7daysProfit,
                    )
                  : _selectedIndex == 1
                      ? WeeklyBarChart(
                          monProfit: monProfit,
                          tuesProfit: tuesProfit,
                          wedProfit: wedProfit,
                          thurProfit: thurProfit,
                          firProfit: firProfit,
                          satProfit: satProfit,
                          sunProfit: sunProfit,
                        )
                      : _selectedIndex == 2
                          ? MonthlyBarChart(monthlyProfit: monthlyProfit)
                          : YearlyBarChart(
                              AprProfit: AprProfit,
                              AugProfit: AugProfit,
                              DecProfit: DecProfit,
                              FebProfit: FebProfit,
                              JanProfit: JanProfit,
                              JulProfit: JulProfit,
                              JunProfit: JunProfit,
                              MarProfit: MarProfit,
                              MayProfit: MayProfit,
                              NovProfit: NovProfit,
                              OctProfit: OctProfit,
                              SepProfit: SepProfit,
                              TotalProfit: totalProfit,
                            ),
            ),
            Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 185,
                        width: 180,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            top: 14, bottom: 7, right: 7, left: 14),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                              width: 1.2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 1, 203, 105),
                                blurStyle: BlurStyle.outer,
                                blurRadius: 3,
                              )
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(23)),
                            color: Colors.black45),
                        // ignore: prefer_const_literals_to_create_immutables
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '\$ $todaySales',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Total Profit',
                              style: TextStyle(
                                height: .5,
                                fontSize: 17,
                                letterSpacing: 2.5,
                                wordSpacing: 3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 240,
                        width: 180,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            top: 7, bottom: 14, right: 7, left: 14),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 1.2,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 1, 203, 105),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 3,
                            )
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(23)),
                          color: Colors.black45,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '\$ $totalProfitThisMonth',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Total Profit',
                              style: TextStyle(
                                height: .5,
                                fontSize: 17,
                                letterSpacing: 2.5,
                                wordSpacing: 3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'This Month',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '\$ $avgMonthlyProfit',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Average Profit',
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
                      )
                    ],
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 240,
                        width: 180,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            top: 14, bottom: 7, right: 13, left: 7),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 1.2,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 1, 203, 105),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 3,
                            )
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(23)),
                          color: Colors.black45,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '\$ $totalWeeklyprofit',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Total Profit',
                              style: TextStyle(
                                height: .5,
                                fontSize: 17,
                                letterSpacing: 2.5,
                                wordSpacing: 3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'This Week',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '\$ $avgWeeklyProfit',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Average Profit',
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
                      ),
                      Container(
                        height: 185,
                        width: 180,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            top: 7, bottom: 14, right: 13, left: 7),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 1.2,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 1, 203, 105),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 3,
                            )
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(23)),
                          color: Colors.black45,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '\$ $totalProfit',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Total Profit',
                              style: TextStyle(
                                height: .5,
                                fontSize: 17,
                                letterSpacing: 2.5,
                                wordSpacing: 3,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'This year',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ])
          ],
        ),
      ),
    );
  }
}
