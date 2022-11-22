class Stock {
  final int itemId;
  String itemName;
  int itemQuantity;
  dynamic purchasedDate;
  double singlePrice;
  double bulckPrice;
  Stock({
    required this.itemId,
    required this.itemName,
    required this.itemQuantity,
    required this.purchasedDate,
    required this.singlePrice,
    required this.bulckPrice,
  });
}

List<Stock> stocks = [
  Stock(
    itemId: 1,
    itemName: 'Yellow Pigment',
    itemQuantity: 10,
    purchasedDate: '18/11/2022',
    singlePrice: 100,
    bulckPrice: 90,
  ),
  Stock(
    itemId: 2,
    itemName: 'Red Pigment',
    itemQuantity: 15,
    purchasedDate: '10/11/2022',
    singlePrice: 120,
    bulckPrice: 110,
  ),
  Stock(
    itemId: 3,
    itemName: 'Lithuim Chloride',
    itemQuantity: 0,
    purchasedDate: '27/10/2022',
    singlePrice: 138,
    bulckPrice: 128,
  ),
  Stock(
    itemId: 4,
    itemName: 'Adipic Acid',
    itemQuantity: 12,
    purchasedDate: '15/10/2022',
    singlePrice: 1100,
    bulckPrice: 1090,
  ),
  Stock(
    itemId: 5,
    itemName: 'Black Pigment',
    itemQuantity: 120,
    purchasedDate: '22/10/2022',
    singlePrice: 120,
    bulckPrice: 110,
  ),
];
