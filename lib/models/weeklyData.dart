// ignore_for_file: file_names

class SplineAreaData {
  final double day;
  final double daily;
  // final double x = 100;
  // final double y = 100;
  SplineAreaData({required this.day, required this.daily});
}

List<SplineAreaData> salesData = [
  SplineAreaData(day: 1, daily: 1000),
  SplineAreaData(day: 2, daily: 540),
  SplineAreaData(day: 3, daily: 1300),
  SplineAreaData(day: 4, daily: 630),
  SplineAreaData(day: 5, daily: 1200),
  SplineAreaData(day: 6, daily: 970),
  SplineAreaData(day: 7, daily: 880),
];

List<SplineAreaData> profitData = [
  SplineAreaData(day: 1, daily: 1000 * .25),
  SplineAreaData(day: 2, daily: 540 * .25),
  SplineAreaData(day: 3, daily: 1300 * .25),
  SplineAreaData(day: 4, daily: 630 * .25),
  SplineAreaData(day: 5, daily: 1200 * .25),
  SplineAreaData(day: 6, daily: 970 * .25),
  SplineAreaData(day: 7, daily: 880 * .25),
];

List<SplineAreaData> customerData = [
  SplineAreaData(day: 1, daily: 13),
  SplineAreaData(day: 2, daily: 19),
  SplineAreaData(day: 3, daily: 21),
  SplineAreaData(day: 4, daily: 10),
  SplineAreaData(day: 5, daily: 17),
  SplineAreaData(day: 6, daily: 16),
  SplineAreaData(day: 7, daily: 14),
];

List<SplineAreaData> expenseData = [
  SplineAreaData(day: 1, daily: 1000 * .4),
  SplineAreaData(day: 2, daily: 540 * .35),
  SplineAreaData(day: 3, daily: 1300 * .45),
  SplineAreaData(day: 4, daily: 630 * .37),
  SplineAreaData(day: 5, daily: 1200 * .38),
  SplineAreaData(day: 6, daily: 970 * .41),
  SplineAreaData(day: 7, daily: 880 * .36),
];
