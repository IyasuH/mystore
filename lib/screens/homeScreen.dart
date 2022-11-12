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
  int _currentTab = 0;
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
        margin: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(30),
          //   topRight: Radius.circular(30),
          // ),
          borderRadius: BorderRadius.all(Radius.circular(43)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(153, 89, 225, 54),
              spreadRadius: 1.5,
              blurRadius: 10,
              blurStyle: BlurStyle.outer,
            )
          ],
        ),
        child: ClipRRect(
          // borderRadius: const BorderRadius.only(
          //     topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          borderRadius: const BorderRadius.all(
            Radius.circular(43),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black45,
            currentIndex: _currentTab,
            selectedItemColor: const Color.fromARGB(255, 80, 220, 63),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            iconSize: 28,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: (index) {
              setState(() {
                _currentTab = index;
              });
            },
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              BottomNavigationBarItem(
                  activeIcon: Container(
                    height: 47,
                    width: 47,
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(colors: [
                        Color.fromARGB(204, 89, 205, 54),
                        Color.fromARGB(153, 89, 205, 54),
                        Color.fromARGB(102, 89, 205, 54),
                        Color.fromARGB(51, 89, 205, 54),
                        Color.fromARGB(0, 89, 205, 54)
                      ]),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.home_outlined),
                  ),
                  label: 'Home',
                  icon: const Icon(Icons.home_outlined)),
              BottomNavigationBarItem(
                  activeIcon: Container(
                    height: 47,
                    width: 47,
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(colors: [
                        Color.fromARGB(204, 89, 205, 54),
                        Color.fromARGB(153, 89, 205, 54),
                        Color.fromARGB(102, 89, 205, 54),
                        Color.fromARGB(51, 89, 205, 54),
                        Color.fromARGB(0, 89, 205, 54)
                      ]),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.bar_chart_outlined),
                  ),
                  label: 'Stock',
                  icon: const Icon(Icons.bar_chart_outlined)),
              BottomNavigationBarItem(
                  activeIcon: Container(
                    height: 47,
                    width: 47,
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(colors: [
                        Color.fromARGB(204, 89, 205, 54),
                        Color.fromARGB(153, 89, 205, 54),
                        Color.fromARGB(102, 89, 205, 54),
                        Color.fromARGB(51, 89, 205, 54),
                        Color.fromARGB(0, 89, 205, 54)
                      ]),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.account_balance_wallet_outlined),
                  ),
                  label: 'Cash',
                  icon: const Icon(Icons.account_balance_wallet_outlined)),
              BottomNavigationBarItem(
                  activeIcon: Container(
                    height: 47,
                    width: 47,
                    // ignore: prefer_const_constructors
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(colors: [
                        Color.fromARGB(204, 89, 205, 54),
                        Color.fromARGB(153, 89, 205, 54),
                        Color.fromARGB(102, 89, 205, 54),
                        Color.fromARGB(51, 89, 205, 54),
                        Color.fromARGB(0, 89, 205, 54)
                      ]),
                      shape: BoxShape.circle,
                    ),
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
