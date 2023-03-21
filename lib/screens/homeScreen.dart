import 'package:flutter/material.dart';
import 'package:mystore/screens/stockTab.dart';

import 'accountTab.dart';
import 'cashTab.dart';
import 'homeTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bottom navigation bar buttons size
  double bottNavButtH = 47;
  double bottNavButtW = 47;
  int _currentTab = 0;
  // ignore: prefer_const_constructors
  // This decor is for the bottom navbar buttons
  // trid to creat diffusing effect by varying color by some constant value throw gardient
  Decoration bottNavButtDecor = const BoxDecoration(
    gradient: RadialGradient(colors: [
      Color.fromARGB(204, 89, 205, 54),
      Color.fromARGB(153, 89, 205, 54),
      Color.fromARGB(102, 89, 205, 54),
      Color.fromARGB(51, 89, 205, 54),
      Color.fromARGB(0, 89, 205, 54)
    ]),
    shape: BoxShape.circle,
  );
  // List of tabs
  final tabs = [
    const HomeTab(),
    const StockTab(),
    const CashTab(),
    const AcoountTab()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: tabs[_currentTab],
      bottomNavigationBar: Container(
        // margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          // boxShadow: [
          //   BoxShadow(
          //     // color: Color.fromARGB(80, 19, 224, 0),
          //     color: Color.fromARGB(255, 1, 203, 105),
          //     spreadRadius: 1.5,
          //     blurRadius: 6,
          //     blurStyle: BlurStyle.outer,
          //   )
          // ],
        ),
        // I used ClipRRect to creat round edge for the bottom nav bar container
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black45,
            currentIndex: _currentTab,
            selectedItemColor: const Color.fromARGB(255, 38, 255, 0),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            iconSize: 28,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: (index) {
              if (mounted) {
                setState(() {
                  _currentTab = index;
                });
              }
            },
            // List of bottom navigation bar buttons
            items: [
              // icons defined twice one when it get active and one when it is not
              BottomNavigationBarItem(
                  activeIcon: Container(
                    height: bottNavButtH,
                    width: bottNavButtW,
                    decoration: bottNavButtDecor,
                    child: const Icon(Icons.home_outlined),
                  ),
                  label: 'Home',
                  icon: const Icon(Icons.home_outlined)),
              BottomNavigationBarItem(
                  activeIcon: Container(
                    height: bottNavButtH,
                    width: bottNavButtW,
                    decoration: bottNavButtDecor,
                    child: const Icon(Icons.bar_chart_outlined),
                  ),
                  label: 'Stock',
                  icon: const Icon(Icons.bar_chart_outlined)),
              BottomNavigationBarItem(
                  activeIcon: Container(
                    height: bottNavButtH,
                    width: bottNavButtW,
                    decoration: bottNavButtDecor,
                    child: const Icon(Icons.account_balance_wallet_outlined),
                  ),
                  label: 'Cash',
                  icon: const Icon(Icons.account_balance_wallet_outlined)),
              BottomNavigationBarItem(
                  activeIcon: Container(
                    height: bottNavButtH,
                    width: bottNavButtW,
                    decoration: bottNavButtDecor,
                    child: const Icon(Icons.person_outline_outlined),
                  ),
                  label: 'Account',
                  icon: const Icon(Icons.person_outline_outlined)),
            ],
          ),
        ),
      ),
    );
  }
}
