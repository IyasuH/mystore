class TopClients {
  final String customerName;
  final String companyName;
  final double amount;
  // change is amount customers level increased or decreased by
  final int change;
  TopClients({
    required this.customerName,
    required this.companyName,
    required this.amount,
    required this.change,
  });
}

List<TopClients> topClients = [
  TopClients(
    customerName: 'Eyasu',
    companyName: 'SubZero',
    amount: 36057,
    change: 1,
  ),
  TopClients(
      customerName: 'Bereket',
      companyName: 'GigaSoft',
      amount: 12078,
      change: -1),
  TopClients(
    customerName: 'Bety',
    companyName: 'Build-X',
    amount: 9907,
    change: 1,
  ),
];

class Customers {
  final String customerName;
  final String companyName;
  final String phoneNumber;
  final String tinNumber;
  final String city;
  final double totalPurchase;
  final int visits;
  final String membership;
  Customers(
      {required this.customerName,
      required this.companyName,
      required this.phoneNumber,
      required this.tinNumber,
      required this.city,
      required this.totalPurchase,
      required this.visits,
      this.membership = 'None'});
}

List<Customers> customers = [
  Customers(
    customerName: 'Eyasu',
    companyName: 'Mozazgi',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 2000,
    visits: 5,
    membership: 'Golden',
  ),
  Customers(
    customerName: 'Dagi',
    companyName: 'CoffeeGo',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 3000,
    visits: 6,
    membership: 'Silver',
  ),
  Customers(
    customerName: 'Bety',
    companyName: 'BuilX',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 1000,
    visits: 2,
    membership: 'Basic',
  ),
  Customers(
    customerName: 'Hermi',
    companyName: 'BuilX',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 1000,
    visits: 2,
    membership: 'Basic',
  ),
  Customers(
    customerName: 'Beki',
    companyName: 'BuilX',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 1000,
    visits: 2,
    membership: 'Basic',
  ),
  Customers(
    customerName: 'Eyasu',
    companyName: 'Mozazgi',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 2000,
    visits: 5,
    membership: 'Golden',
  ),
  Customers(
    customerName: 'Dagi',
    companyName: 'CoffeeGo',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 3000,
    visits: 6,
    membership: 'Silver',
  ),
  Customers(
    customerName: 'Bety',
    companyName: 'BuilX',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 1000,
    visits: 2,
    membership: 'Basic',
  ),
  Customers(
    customerName: 'Hermi',
    companyName: 'BuilX',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 1000,
    visits: 2,
    membership: 'Basic',
  ),
  Customers(
    customerName: 'Beki',
    companyName: 'BuilX',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 1000,
    visits: 2,
    membership: 'Basic',
  ),
  Customers(
    customerName: 'Eyasu',
    companyName: 'Mozazgi',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 2000,
    visits: 5,
    membership: 'Golden',
  ),
  Customers(
    customerName: 'Dagi',
    companyName: 'CoffeeGo',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 3000,
    visits: 6,
    membership: 'Silver',
  ),
  Customers(
    customerName: 'Bety',
    companyName: 'BuilX',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 1000,
    visits: 2,
    membership: 'Basic',
  ),
  Customers(
    customerName: 'Hermi',
    companyName: 'BuilX',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 1000,
    visits: 2,
    membership: 'Basic',
  ),
  Customers(
    customerName: 'Beki',
    companyName: 'BuilX',
    phoneNumber: '0941279805',
    tinNumber: '096404',
    city: 'Addis',
    totalPurchase: 1000,
    visits: 2,
    membership: 'Basic',
  )
];
