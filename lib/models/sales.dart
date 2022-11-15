class Sales {
  final int salesId;
  int itemId;
  int customerId;
  int itemQuantity;
  dynamic soldDate;
  double salesRevenu;
  int bankId;
  String addInfo;

  Sales({
    required this.salesId,
    required this.itemId,
    required this.customerId,
    required this.itemQuantity,
    required this.soldDate,
    required this.salesRevenu,
    required this.bankId,
    this.addInfo = '',
  });
}

List<Sales> sales = [
  Sales(
    salesId: 1,
    itemId: 1,
    customerId: 1,
    itemQuantity: 10,
    soldDate: '15/11/2022',
    salesRevenu: 1000,
    bankId: 1,
  ),
  Sales(
    salesId: 2,
    itemId: 1,
    customerId: 1,
    itemQuantity: 10,
    soldDate: '15/11/2022',
    salesRevenu: 1000,
    bankId: 1,
  ),
  Sales(
    salesId: 3,
    itemId: 1,
    customerId: 1,
    itemQuantity: 10,
    soldDate: '15/11/2022',
    salesRevenu: 1000,
    bankId: 1,
  ),
  Sales(
    salesId: 4,
    itemId: 1,
    customerId: 1,
    itemQuantity: 10,
    soldDate: '15/11/2022',
    salesRevenu: 1000,
    bankId: 1,
  ),
  Sales(
    salesId: 5,
    itemId: 1,
    customerId: 1,
    itemQuantity: 10,
    soldDate: '15/11/2022',
    salesRevenu: 1000,
    bankId: 1,
  ),
];
