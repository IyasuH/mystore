import 'dart:ffi';

final String tableAccounts = 'accounts';

class AccountFields {
  static final List<String> values = [
    id,
    bankName,
    accountNumber,
    amount,
    accountCreatedDate
  ];

  static final String id = '_id';
  static final String bankName = 'bankName';
  static final String accountNumber = 'accountNumber';
  static final String amount = 'amount';
  static final String accountCreatedDate = 'accountCreatedDate';
}

class BankAccount {
  final int? id;
  final String bankName;
  final int accountNumber;
  final double amount;
  final DateTime accountCreatedDate;
  const BankAccount({
    this.id,
    required this.bankName,
    required this.accountNumber,
    required this.amount,
    required this.accountCreatedDate,
  });

  BankAccount copy({
    int? id,
    required String bankName,
    required int accountNumber,
    required double amount,
    required DateTime accountCreatedDate,
  }) =>
      BankAccount(
        id: id ?? this.id,
        bankName: bankName,
        accountNumber: accountNumber,
        amount: amount,
        accountCreatedDate: accountCreatedDate,
      );

  Map<String, Object?> toJson() => {
        AccountFields.id: id,
        AccountFields.bankName: bankName,
        AccountFields.accountNumber: accountNumber,
        AccountFields.amount: amount,
        AccountFields.accountCreatedDate: accountCreatedDate.toIso8601String(),
      };

  static BankAccount fromJson(Map<String, Object?> json) => BankAccount(
        id: json[AccountFields.id] as int?,
        bankName: json[AccountFields.bankName] as String,
        accountNumber: json[AccountFields.accountNumber] as int,
        amount: json[AccountFields.amount] as double,
        accountCreatedDate:
            DateTime.parse(json[AccountFields.accountCreatedDate] as String),
      );
  // List<BankAccount> bankAccounts = [
  //   BankAccount(
  //     bankName: 'CBE',
  //     accountNumber: 4567112245957852,
  //     amount: 5000.00,
  //     accountCreatedDate: DateTime(2022, 12, 10),
  //   ),
  //   BankAccount(
  //     bankName: 'Abyssina',
  //     accountNumber: 4567112245957852,
  //     amount: 5000.00,
  //     accountCreatedDate: DateTime(2022, 12, 10),
  //   ),
  //   BankAccount(
  //     bankName: 'Dashn',
  //     accountNumber: 4567112245957852,
  //     amount: 5000.00,
  //     accountCreatedDate: DateTime(2022, 12, 10),
  //   ),
  //   BankAccount(
  //     bankName: 'Awash',
  //     accountNumber: 4567112245957852,
  //     amount: 5000.00,
  //     accountCreatedDate: DateTime(2022, 12, 10),
  //   ),
  // ];
}
