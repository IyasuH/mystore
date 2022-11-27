// ignore: file_names
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSampleData {
  ChartSampleData({this.x, this.y});
  final dynamic x;
  final dynamic y;
}

class MonthlyProfitColumn extends StatefulWidget {
  const MonthlyProfitColumn({super.key});

  @override
  State<MonthlyProfitColumn> createState() => _MonthlyProfitColumnState();
}

class _MonthlyProfitColumnState extends State<MonthlyProfitColumn> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  SfCartesianChart _monthlyProfitColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: ''),
      primaryXAxis: CategoryAxis(
          labelStyle: TextStyle(color: Colors.white),
          axisLine: AxisLine(width: 0),
          labelPosition: ChartDataLabelPosition.inside,
          majorTickLines: MajorTickLines(width: 0),
          majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(isVisible: false, minimum: 0, maximum: 9000),
      series: _getRoundedColumnSeries(),
      // tooltipBehavior: ,
    );
  }

  List<ColumnSeries<ChartSampleData, String>> _getRoundedColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        width: 0.9,
        // ignore: prefer_const_constructors
        dataLabelSettings: DataLabelSettings(
            isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'Jan', y: 1000),
          ChartSampleData(x: 'Feb', y: 1000),
          ChartSampleData(x: 'Mar', y: 1000),
          ChartSampleData(x: 'Apr', y: 1000),
          ChartSampleData(x: 'May', y: 1000),
          ChartSampleData(x: 'Jun', y: 1000),
          ChartSampleData(x: 'Jul', y: 1000),
          ChartSampleData(x: 'Aug', y: 1000),
          ChartSampleData(x: 'Sep', y: 1000),
          ChartSampleData(x: 'Oct', y: 1000),
          ChartSampleData(x: 'Nov', y: 1000),
          ChartSampleData(x: 'Dec', y: 1000),
        ],
        borderRadius: BorderRadius.circular(10),
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
      )
    ];
  }
}

class ProfitTab extends StatefulWidget {
  const ProfitTab({super.key});

  @override
  State<ProfitTab> createState() => _ProfitTabState();
}

class _ProfitTabState extends State<ProfitTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit'),
      ),
      body: SafeArea(
        child: ListView(
          children: const [MonthlyProfitColumn()],
        ),
      ),
    );
  }
}
