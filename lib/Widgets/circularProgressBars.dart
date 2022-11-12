import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SalesCircualrProgressBar extends StatefulWidget {
  const SalesCircualrProgressBar({super.key});

  @override
  State<SalesCircualrProgressBar> createState() =>
      _SalesCircualrProgressBarState();
}

class _SalesCircualrProgressBarState extends State<SalesCircualrProgressBar> {
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
            axisLineStyle: const AxisLineStyle(
              thickness: 0.15,
              color: Color.fromARGB(30, 0, 169, 181),
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
                color: Colors.cyan,
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
