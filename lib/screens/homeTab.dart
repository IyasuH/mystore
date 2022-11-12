import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../Widgets/circularProgressBars.dart';
import '../Widgets/splineAreaCart.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // _HomeTabState();
  late Timer _timer;
  double salesProgressValue = 0;
  // this value later gate from calcualting monthly sales change
  double maxSalesValue = 37;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer timer) {
        setState(() {
          if (salesProgressValue < maxSalesValue) {
            salesProgressValue++;
          }
        });
      });
    }
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
                    children: const [
                      Text(
                        'Hi Ghulam',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
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
              Container(
                height: 120,
                decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                padding: const EdgeInsets.fromLTRB(20, 20, 12, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Sales',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Total Sales Today',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '\$ 500',
                          style: TextStyle(
                            color: Colors.cyan,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                        width: 140, height: 150, child: SalesSplineAreaChart()),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SalesCircualrProgressBar(),
                        Icon(
                          Icons.trending_up_rounded,
                          color: Colors.cyan,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
