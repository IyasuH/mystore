import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mystore/screens/expenseTab.dart';
import 'package:mystore/screens/salesTab.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../Widgets/circularProgressBars.dart';
import '../Widgets/homePageMainContainer.dart';
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
    return homeMainContainer(
      routeToPage: SalesTab(),
      primaryColor: salesPrimaryColor,
      secondaryColor: salesSecondaryColor,
      chartName: 'Sales',
      secondaryHeader: 'Toda\'s Sales',
      primaryQuantity: '\$500',
      SplinChartData: salesData,
      CicularBarVal: 37,
    );
  }

  _profitContainer() {
    Color profitPrimaryColor = const Color.fromARGB(255, 38, 255, 0);
    Color profitSecondaryColor = const Color.fromARGB(30, 19, 224, 0);

    return homeMainContainer(
      routeToPage: ProfitTab(),
      primaryColor: profitPrimaryColor,
      secondaryColor: profitSecondaryColor,
      chartName: 'Profit',
      secondaryHeader: 'Toda\'s Profit',
      primaryQuantity: '\$120',
      SplinChartData: profitData,
      CicularBarVal: 37,
    );
  }

  expenseContainer() {
    Color expensePrimaryColor = const Color.fromARGB(255, 255, 20, 110);
    Color expenseSecondaryColor = const Color.fromARGB(30, 194, 0, 91);

    return homeMainContainer(
      routeToPage: ExpensesTab(),
      primaryColor: expensePrimaryColor,
      secondaryColor: expenseSecondaryColor,
      chartName: 'Expenses',
      secondaryHeader: 'Today\'s Expenses',
      primaryQuantity: '\$36',
      SplinChartData: expenseData,
      CicularBarVal: 18,
    );
  }

  clientsContainer() {
    Color clientsPrimaryColor = const Color.fromARGB(255, 234, 164, 45);
    Color clientsSecondaryColor = const Color.fromARGB(30, 203, 145, 0);
    // special condition for this is that it has topclients card too
    return homeMainContainer(
      routeToPage: CustomerTab(),
      primaryColor: clientsPrimaryColor,
      secondaryColor: clientsSecondaryColor,
      chartName: 'Clients',
      secondaryHeader: 'Today\'s Clients',
      primaryQuantity: '18',
      SplinChartData: customerData,
      CicularBarVal: 81,
    );
  }

  // Adding this top clients bellow clients container as drop down
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 15, 13, 5),
            child: Row(
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
                    const SizedBox(
                      height: 7,
                    ),
                    // ignore: prefer_const_constructors
                    Text(
                      'Welcome Back!',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green,
                          blurRadius: 7,
                          blurStyle: BlurStyle.outer,
                        )
                      ]),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        size: 30,
                        Icons.person,
                        // color: Color.fromARGB(255, 80, 220, 63),
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            height: 640,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: ListView(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: <Widget>[
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
            ),
          ),
        ],
      ),
    );
  }
}
