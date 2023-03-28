// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class homePageMore extends StatefulWidget {
  Widget routeToPage;
  Color primaryColor;
  Color secondaryColor;
  String chartName;

  homePageMore({
    super.key,
    required this.routeToPage,
    required this.primaryColor,
    required this.secondaryColor,
    required this.chartName,
  });

  @override
  State<homePageMore> createState() => _homePageMoreState();
}

class _homePageMoreState extends State<homePageMore> {
  @override
  Widget build(BuildContext context) {
    return _gotoContainer();
  }

  GestureDetector _gotoContainer() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => widget.routeToPage,
        ),
      ),
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          // ignore: prefer_const_literals_to_create_immutables
          // border: Border.all(color: Colors.blueGrey, width: .7),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey,
              blurStyle: BlurStyle.outer,
              blurRadius: 3,
              // spreadRadius: 1.1,
            ),
          ],
        ),
        // ignore: prefer_const_literals_to_create_immutables
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'More',
                style: TextStyle(
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w800,
                  color: widget.primaryColor,
                ),
              ),
              Icon(
                size: 25.0,
                color: widget.primaryColor,
                Icons.arrow_forward_ios_sharp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
