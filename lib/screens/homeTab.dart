import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mystore/screens/expenseTab.dart';
import 'package:mystore/screens/salesTab.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../Widgets/circularProgressBars.dart';
import '../Widgets/splineAreaCart.dart';
import '../models/clients.dart';
import '../models/weeklyData.dart';
import 'customerTab.dart';
import 'proftTab.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // _HomeTabState();
  _salesContainer() {
    Color salesPrimaryColor = const Color.fromRGBO(0, 188, 212, 1);
    Color salesSecondaryColor = const Color.fromARGB(30, 0, 169, 181);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SalesTab(),
        ),
      ),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: salesSecondaryColor,
              blurStyle: BlurStyle.outer,
              blurRadius: 5,
              spreadRadius: 1.1,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 12, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Sales',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'Today\'s Sales',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\$ 500',
                  style: TextStyle(
                    color: salesPrimaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 140,
              child: SplineAreaChart(
                chartName: 'Sales',
                primaryColor: salesPrimaryColor,
                secondaryColor: salesSecondaryColor,
                chartData: salesData,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircualrProgressBar(
                  value: 37,
                  primaryColor: salesPrimaryColor,
                  secondaryColor: salesSecondaryColor,
                ),
                Icon(
                  Icons.trending_up_rounded,
                  color: salesPrimaryColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _profitContainer() {
    Color profitPrimaryColor = const Color.fromARGB(255, 38, 255, 0);
    Color profitSecondaryColor = const Color.fromARGB(30, 19, 224, 0);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfitTab(),
        ),
      ),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: profitSecondaryColor,
              blurStyle: BlurStyle.outer,
              blurRadius: 5,
              spreadRadius: 1.1,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 12, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Profit',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'Today\'s Profit',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\$ 120',
                  style: TextStyle(
                    color: profitPrimaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 140,
              child: SplineAreaChart(
                chartName: 'Profit',
                primaryColor: profitPrimaryColor,
                secondaryColor: profitSecondaryColor,
                chartData: profitData,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                CircualrProgressBar(
                  value: 37,
                  primaryColor: profitPrimaryColor,
                  secondaryColor: profitSecondaryColor,
                ),
                Icon(
                  Icons.trending_up_rounded,
                  color: profitPrimaryColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  expenseContainer() {
    Color expensePrimaryColor = const Color.fromARGB(255, 255, 20, 110);
    Color expenseSecondaryColor = const Color.fromARGB(30, 194, 0, 91);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ExpensesTab(),
        ),
      ),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: expenseSecondaryColor,
              blurStyle: BlurStyle.outer,
              blurRadius: 5,
              spreadRadius: 1.1,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 12, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Expenses',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'Today\'s Expenses',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\ETB 236',
                  style: TextStyle(
                    color: expensePrimaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 140,
              child: SplineAreaChart(
                chartName: 'Customers',
                primaryColor: expensePrimaryColor,
                secondaryColor: expenseSecondaryColor,
                chartData: expenseData,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                CircualrProgressBar(
                  value: 18,
                  primaryColor: expensePrimaryColor,
                  secondaryColor: expenseSecondaryColor,
                ),
                Icon(
                  Icons.trending_down_rounded,
                  color: expensePrimaryColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  clientsContainer() {
    Color clientsPrimaryColor = const Color.fromARGB(255, 234, 164, 45);
    Color clientsSecondaryColor = const Color.fromARGB(30, 203, 145, 0);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CustomerTab(),
        ),
      ),
      child: Container(
        height: 320,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: clientsSecondaryColor,
              blurStyle: BlurStyle.outer,
              blurRadius: 5,
              spreadRadius: 1.1,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 12, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Clients',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'Customers Today',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '18',
                      style: TextStyle(
                        color: clientsPrimaryColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 140,
                  height: 80,
                  child: SplineAreaChart(
                    chartName: 'Customers',
                    primaryColor: clientsPrimaryColor,
                    secondaryColor: clientsSecondaryColor,
                    chartData: customerData,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircualrProgressBar(
                      value: 81,
                      primaryColor: clientsPrimaryColor,
                      secondaryColor: clientsSecondaryColor,
                    ),
                    Icon(
                      Icons.trending_up_rounded,
                      color: clientsPrimaryColor,
                    )
                  ],
                ),
              ],
            ),
            topclients()
          ],
        ),
      ),
    );
  }

  topclients() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Top Clients',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Client name',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const Text(
                'Amount',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 1.5,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          SizedBox(
            height: 140,
            child: ListView.builder(
              itemCount: topClients.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  // padding: EdgeInsets.only(top: 3),
                  height: 60,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1.5,
                        color: Color.fromARGB(80, 203, 145, 0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            topClients[index].customerName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            topClients[index].companyName,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            topClients[index].change == 1
                                ? const Icon(Icons.arrow_drop_up_sharp,
                                    color: Colors.green, size: 32)
                                : const Icon(Icons.arrow_drop_down_sharp,
                                    color: Colors.red, size: 32),
                            Text(
                              '\$ ${topClients[index].amount}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 234, 164, 45),
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
          child: Column(
            children: <Widget>[
              Row(
                // ignore: prefer_const_constructors
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi Eyasu',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                          wordSpacing: 1.8,
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const Icon(
                    size: 45,
                    Icons.account_circle_outlined,
                    color: Color.fromARGB(255, 80, 220, 63),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              _salesContainer(),
              const SizedBox(
                height: 25,
              ),
              _profitContainer(),
              const SizedBox(
                height: 25,
              ),
              expenseContainer(),
              const SizedBox(
                height: 25,
              ),
              clientsContainer(),
            ],
          ),
        ),
      ]),
    );
  }
}
