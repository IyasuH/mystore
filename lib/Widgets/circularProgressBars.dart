// ignore: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// ignore: must_be_immutable
class CircualrProgressBar extends StatefulWidget {
  double value;
  Color primaryColor;
  Color secondaryColor;

  CircualrProgressBar({
    super.key,
    // this value later gate from calcualting monthly sales change
    required this.value,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  State<CircualrProgressBar> createState() =>
      // ignore: no_logic_in_create_state
      _CircualrProgressBarState();
}

class _CircualrProgressBarState extends State<CircualrProgressBar> {
  late Timer _timer;
  double salesProgressValue = 0;
  _CircualrProgressBarState();
  // this value later gate from calcualting monthly sales change
  // double maxSalesValue = ;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer timer) {
        setState(() {
          if (salesProgressValue < widget().value) {
            salesProgressValue++;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 75,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            showTicks: false,
            showLabels: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 1,
            axisLineStyle: AxisLineStyle(
              thickness: 0.15,
              color: widget().secondaryColor,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: salesProgressValue,
                width: 0.15,
                pointerOffset: 0.05,
                sizeUnit: GaugeSizeUnit.factor,
                enableAnimation: true,
                animationDuration: 75,
                animationType: AnimationType.linear,
                cornerStyle: CornerStyle.bothCurve,
                color: widget().primaryColor,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  positionFactor: .1,
                  widget: Text(
                    '${salesProgressValue.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
