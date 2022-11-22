class Expenses {
  final int id;
  bool fixed;
  String name;
  double amount;
  dynamic date;
  Expenses({
    required this.id,
    required this.fixed,
    required this.name,
    required this.amount,
    required this.date,
  });
}

List<Expenses> expenses = [
  Expenses(
    id: 1,
    fixed: true,
    name: 'rent',
    amount: 7000,
    date: '08/10/2022',
  ),
  Expenses(
    id: 2,
    fixed: true,
    name: 'Wage',
    amount: 10000,
    date: '08/10/2022',
  ),
  Expenses(
    id: 3,
    fixed: true,
    name: 'Utilit Bill',
    amount: 2000,
    date: '08/10/2022',
  ),
  Expenses(
    id: 4,
    fixed: true,
    name: 'rent',
    amount: 7000,
    date: '13/09/2022',
  ),
  Expenses(
    id: 5,
    fixed: true,
    name: 'wage',
    amount: 10000,
    date: '15/09/2022',
  ),
  Expenses(
    id: 6,
    fixed: false,
    name: 'transport',
    amount: 1000,
    date: '08/10/2022',
  ),
  Expenses(
    id: 7,
    fixed: false,
    name: 'transport',
    amount: 1200,
    date: '13/09/2022',
  ),
];
