// ignore: file_names
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/weeklyData.dart';

// ignore: must_be_immutable
class SplineAreaChart extends StatefulWidget {
  String chartName;
  Color primaryColor;
  Color secondaryColor;
  List<SplineAreaData> chartData;
  SplineAreaChart({
    super.key,
    required this.chartName,
    required this.primaryColor,
    required this.secondaryColor,
    required this.chartData,
  });

  @override
  State<SplineAreaChart> createState() => _SplineAreaChartState();
}

class _SplineAreaChartState extends State<SplineAreaChart> {
  @override
  Widget build(BuildContext context) {
    return _buildSplineAreaChart();
  }

  SfCartesianChart _buildSplineAreaChart() {
    return SfCartesianChart(
      // title: ChartTitle(text: 'Weekly Sales'),
      plotAreaBorderWidth: 0,
      series: _getSalesSplieAreaSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: NumericAxis(
        isVisible: false,
      ),
      primaryYAxis: NumericAxis(
        isVisible: false,
      ),
    );
  }

  // List<SplineAreaData>? chartData;

  // @override
  // void initState() {
  //   chartData = salesData;
  //   super.initState();
  // }

  List<ChartSeries<SplineAreaData, double>> _getSalesSplieAreaSeries() {
    return <ChartSeries<SplineAreaData, double>>[
      SplineAreaSeries<SplineAreaData, double>(
          borderWidth: 2,
          name: widget.chartName,
          dataSource: widget.chartData,
          color: widget.secondaryColor,
          borderColor: widget.primaryColor,
          xValueMapper: (SplineAreaData sales, _) => sales.day,
          yValueMapper: (SplineAreaData sales, _) => sales.daily)
    ];
  }

  // @override
  // void dispose() {
  //   chartData!.clear();
  //   super.dispose();
  // }
}

// class _SplineAreaData {
//   _SplineAreaData(this.day, this.daily);
//   final double day;
//   final double daily;
// }
