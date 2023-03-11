import 'package:flutter/material.dart';

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
        decoration: BoxDecoration(
          color: widget.primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(17),
              bottomRight: Radius.circular(17)),
          boxShadow: [
            BoxShadow(
              color: widget.secondaryColor,
              blurStyle: BlurStyle.outer,
              blurRadius: 5,
              spreadRadius: 1.1,
            ),
          ],
        ),
        // ignore: prefer_const_literals_to_create_immutables
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'More',
                style: TextStyle(
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              Icon(
                size: 25.0,
                color: Colors.black87,
                Icons.arrow_forward_ios_sharp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
