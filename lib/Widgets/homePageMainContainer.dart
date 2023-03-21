import 'package:flutter/material.dart';
import 'package:mystore/Widgets/splineAreaCart.dart';
import 'package:mystore/models/weeklyData.dart';

import 'circularProgressBars.dart';

class homeMainContainer extends StatefulWidget {
  Color primaryColor;
  Color secondaryColor;
  String chartName;
  String secondaryHeader;
  String primaryQuantity;
  // ignore: non_constant_identifier_names
  List<SplineAreaData> SplinChartData;
  // ignore: non_constant_identifier_names
  double CicularBarVal;

  homeMainContainer({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.chartName,
    required this.secondaryHeader,
    required this.primaryQuantity,
    // ignore: non_constant_identifier_names
    required this.SplinChartData,
    // ignore: non_constant_identifier_names
    required this.CicularBarVal,
  });

  @override
  State<homeMainContainer> createState() => _homeMainContainerState();
}

// ignore: camel_case_types
class _homeMainContainerState extends State<homeMainContainer> {
  @override
  Widget build(BuildContext context) {
    return _buildHomeMainContaier();
  }

  Container _buildHomeMainContaier() {
    return Container(
      height: 135,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // Radius.circular(15),
        // ),
        border: Border.all(color: Colors.blueGrey, width: .4),
        boxShadow: const [
          BoxShadow(
            color: Colors.blueGrey,
            blurStyle: BlurStyle.outer,
            blurRadius: 2,
            // spreadRadius: 1.1,
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
              Text(
                widget.chartName,
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                widget.secondaryHeader,
                // ignore: prefer_const_constructors
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.primaryQuantity,
                style: TextStyle(
                  color: widget.primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          SizedBox(
            width: 140,
            child: SplineAreaChart(
              chartName: widget.chartName,
              primaryColor: widget.primaryColor,
              secondaryColor: widget.secondaryColor,
              chartData: widget.SplinChartData,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircualrProgressBar(
                value: widget.CicularBarVal,
                primaryColor: widget.primaryColor,
                secondaryColor: widget.secondaryColor,
              ),
              Icon(
                Icons.trending_up_rounded,
                color: widget.primaryColor,
              )
            ],
          ),
        ],
      ),
    );
  }
}
