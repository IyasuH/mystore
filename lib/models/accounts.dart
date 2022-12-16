import 'dart:ffi';

class BankAccount {
  final String bankName;
  final int accountNumber;
  final double amount;
  final String accountCreatedDate;
  BankAccount({
    required this.bankName,
    required this.accountNumber,
    required this.amount,
    required this.accountCreatedDate,
  });
}

List<BankAccount> bankAccounts = [
  BankAccount(
    bankName: 'CBE',
    accountNumber: 4567112245957852,
    amount: 5000.00,
    accountCreatedDate: '10/12/2022',
  ),
  BankAccount(
    bankName: 'Abyssina',
    accountNumber: 4567112245957852,
    amount: 5000.00,
    accountCreatedDate: '10/12/2022',
  ),
  BankAccount(
    bankName: 'Dashn',
    accountNumber: 4567112245957852,
    amount: 5000.00,
    accountCreatedDate: '10/12/2022',
  ),
  BankAccount(
    bankName: 'Awash',
    accountNumber: 4567112245957852,
    amount: 5000.00,
    accountCreatedDate: '10/12/2022',
  ),
];
