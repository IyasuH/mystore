import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SalesSplineAreaChart extends StatefulWidget {
  const SalesSplineAreaChart({super.key});

  @override
  State<SalesSplineAreaChart> createState() => _SalesSplineAreaChartState();
}

class _SalesSplineAreaChartState extends State<SalesSplineAreaChart> {
  @override
  Widget build(BuildContext context) {
    return _buildSalesSplineAreaChart();
  }

  SfCartesianChart _buildSalesSplineAreaChart() {
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

  List<_SplineAreaData>? chartData;

  @override
  void initState() {
    chartData = <_SplineAreaData>[
      _SplineAreaData(1, 1000),
      _SplineAreaData(2, 540),
      _SplineAreaData(3, 1300),
      _SplineAreaData(4, 630),
      _SplineAreaData(5, 1200),
      _SplineAreaData(6, 970),
      _SplineAreaData(7, 880),
    ];
    super.initState();
  }

  List<ChartSeries<_SplineAreaData, double>> _getSalesSplieAreaSeries() {
    return <ChartSeries<_SplineAreaData, double>>[
      SplineAreaSeries<_SplineAreaData, double>(
          borderWidth: 2,
          name: 'Sales',
          dataSource: chartData!,
          color: const Color.fromARGB(30, 0, 169, 181),
          borderColor: Colors.cyan,
          xValueMapper: (_SplineAreaData sales, _) => sales.day,
          yValueMapper: (_SplineAreaData sales, _) => sales.daily)
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class _SplineAreaData {
  _SplineAreaData(this.day, this.daily);
  final double day;
  final double daily;
}
