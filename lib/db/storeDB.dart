// now as database helper file for account
// without the use model file

import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

// ignore: camel_case_types
class myStoreDatabaseHelper {
  static const _dbName = 'myStore.db';
  static const _dbVersion = 1;
  // static const _accounTableName = 'account';

  late Database db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);
    db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onOpen: _onOpen,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE 'account'(
      _id INTEGER PRIMARY KEY AUTOINCREMENT,
      bankName TEXT NOT NULL,
      accountNumber INTEGER NOT NULL,
      amount REAL NOT NULL,
      accountCreatedDate TEXT NOT NULL)
      ''');
  }

  Future _onOpen(Database db) async {
    await db.execute('''
      CREATE TABLE 'stock'(
        _itemId INTEGER PRIMARY KEY AUTOINCREMENT,
        itemName TEXT NOT NULL,
        itemQuantity INTEGER NOT NULL,
        sellingPriceSingle REAL NOT NULL,
        sellingPriceBulk REAL NOT NULL,
        updatedAt TEXT NOT NULL)
      ''');
    await db.execute('''
      CREATE TABLE 'customers'(
        _customerId INTEGER PRIMARY KEY AUTOINCREMENT,
        customerName TEXT NOT NULL,
        companyName TEXT NOT NULL,
        tinNumber INTEGER NOT NULL,
        customerCity TEXT NOT NULL,
        customerPhoneN INTEGER NOT NULL,
        accountCreatedAt TEXT NOT NULL,
        frequencyOfPurchase INTEGER NOT NULL,
        totalPurchase REAL NOT NULL,
        bankAccountNumber INTEGER NOT NULL)
      ''');
    await db.execute('''
      CREATE TABLE 'expenses'(
        _expenseId INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        name TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL)
      ''');
    await db.execute('''
      CREATE TABLE 'sales'(
        _salesId INTEGER PRIMARY KEY AUTOINCREMENT,
        itemId INTEGER NOT NULL,
        customerId INTEGER NOT NULL,
        bankId INTEGER NOT NULL,
        itemQuantity TEXT NOT NULL,
        salesDate TEXT NOT NULL,
        salesRevenue REAL NOT NULL,
        addInfo TEXT)
      ''');
    await db.execute('''
      CREATE TABLE 'person'(
      _personId INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL)
      ''');
  }

  // ##################
  // Accountl table
  // ##################
  insertAccount(bankName, bankNum, bankAmount, bankCreatedAt) {
    db.rawInsert(
        "INSERT INTO account (bankName, accountNumber, amount, accountCreatedDate) VALUES (?, ?, ?, ?);",
        [
          bankName,
          bankNum,
          bankAmount,
          bankCreatedAt,
        ]);
  }

  updateAccount(bankName, bankNum, bankAmount, bankCreatedAt, bankId) {
    db.rawUpdate(
        "UPDATE account SET bankName=?, accountNumber=?, amount=?, accountCreatedDate=? WHERE _id=?",
        [
          bankName,
          bankNum,
          bankAmount,
          bankCreatedAt,
          bankId,
        ]);
  }

  Future<List<Map>> queryAllAccount() async {
    return await db.rawQuery('SELECT * FROM account');
  }

  deleteAccount(bankId) {
    db.rawDelete("DELETE FROM account WHERE _id = ?", [
      bankId,
    ]);
  }

  // ##################
  // Stock table
  // ##################
  insertStock(
      itemName, itemQuantity, sellingPriceSingle, sellingPriceBulk, updatedAt) {
    db.rawInsert(
        "INSERT INTO stock (itemName, itemQuantity, sellingPriceSingle, sellingPriceBulk, updatedAt) VALUES (?, ?, ?, ?, ?);",
        [
          itemName,
          itemQuantity,
          sellingPriceSingle,
          sellingPriceBulk,
          updatedAt,
        ]);
  }

  updateStock(itemName, itemQuantity, sellingPriceSingle, sellingPriceBulk,
      updatedAt, itemId) {
    db.rawUpdate(
        "UPDATE stock SET itemName=?, itemQuantity=?, sellingPriceSingle=?, sellingPriceBulk=?, updatedAt=? WHERE _itemId=?",
        [
          itemName,
          itemQuantity,
          sellingPriceSingle,
          sellingPriceBulk,
          updatedAt,
          itemId,
        ]);
  }

  Future<List<Map>> queryAllStcok() async {
    return await db.rawQuery('SELECT * FROM stock');
  }

  deleteStock(itemId) {
    db.rawDelete("DELETE FROM stock WHERE _itemId=?", [
      itemId,
    ]);
  }

  // ##################
  // Customer table
  // ##################
  insertCustomer(
      customerName,
      companyName,
      tinNumber,
      customerCity,
      customerPhoneN,
      accountCreatedAt,
      frequencyOfPurchase,
      totalPurchase,
      bankAccountNumber) {
    db.rawInsert(
        "INSERT INTO customers (customerName, companyName, tinNumber, customerCity, customerPhoneN, accountCreatedAt, frequencyOfPurchase, totalPurchase, bankAccountNumber) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);",
        [
          customerName,
          companyName,
          tinNumber,
          customerCity,
          customerPhoneN,
          accountCreatedAt,
          frequencyOfPurchase,
          totalPurchase,
          bankAccountNumber,
        ]);
  }

  updateCustomer(
      customerName,
      companyName,
      tinNumber,
      customerCity,
      customerPhoneN,
      accountCreatedAt,
      frequencyOfPurchase,
      totalPurchase,
      bankAccountNumber,
      customerId) {
    db.rawUpdate(
        "UPDATE customers SET customerName=?, companyName=?, tinNumber=?, customerCity=?, customerPhoneN=?, accountCreatedAt=?, frequencyOfPurchase=?, totalPurchase=?, bankAccountNumber=? WHERE _customerId=?",
        [
          customerName,
          companyName,
          tinNumber,
          customerCity,
          customerPhoneN,
          accountCreatedAt,
          frequencyOfPurchase,
          totalPurchase,
          bankAccountNumber,
          customerId,
        ]);
  }

  Future<List<Map>> queryAllCustomer() async {
    return await db.rawQuery('SELECT * FROM customers');
  }

  deleteCustomer(customerId) {
    db.rawDelete("DELETE FROM customers WHERE _customerId=?", [
      customerId,
    ]);
  }

  // ##################
  // Expenses table
  // ##################
  insertExpenses(type, name, amount, date) {
    db.rawInsert(
        "INSERT INTO expenses (type, name, amount, date) VALUES(?, ?, ?, ?);", [
      type,
      name,
      amount,
      date,
    ]);
  }

  updateExpenses(type, name, amount, date, expenseId) {
    db.rawUpdate(
        "UPDATE expenses SET type=?, name=?, amount=?, date=? WHERE _expenseId=?",
        [
          type,
          name,
          amount,
          date,
          expenseId,
        ]);
  }

  Future<List<Map>> queryAllExpenses() async {
    return await db.rawQuery('SELECT * FROM expenses');
  }

  deleteExpenses(expenseId) {
    db.rawDelete("DELETE FROM expenses WHERE _expenseId=?", [
      expenseId,
    ]);
  }

  // ##################
  // Sales table
  // ##################
  insertSales(itemId, customerId, bankId, itemQuantity, salesDate, salesRevenue,
      addInfo) {
    db.rawInsert(
        "INSERT INTO sales (itemId, customerId, bankId, itemQuantity, salesDate, salesRevenue, addInfo) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          itemId,
          customerId,
          bankId,
          itemQuantity,
          salesDate,
          salesRevenue,
          addInfo,
        ]);
  }

  updateSales(itemId, customerId, bankId, itemQuantity, salesDate, salesRevenue,
      addInfo, salesId) {
    db.rawUpdate(
        "UPDATE sales SET itemId=?, customerId=?, bankId=?, itemQuantity=?, salesDate=?, salesRevenue=?, addInfo=? WHERE _salesId=?",
        [
          itemId,
          customerId,
          bankId,
          itemQuantity,
          salesDate,
          salesRevenue,
          addInfo,
          salesId,
        ]);
  }

  Future<List<Map>> queryAllSales() async {
    return await db.rawQuery('SELECT * FROM sales');
  }

  deleteSales(salesId) {
    db.rawDelete("DELETE FROM sales WHERE _salesId=?", [
      salesId,
    ]);
  }

  // ##################
  // Person table
  // ##################

  insertPerson(name) {
    db.rawInsert("INSERT INTO person (name) VALUES (?);", [
      name,
    ]);
  }

  updatePerson(name, personId) {
    db.rawUpdate(
        "UPDATE person SET name=? WHERE _personId=?", [name, personId]);
  }

  deletePerson(personId) {
    db.rawDelete("DELETE FROM person WHERE _personId=?", [personId]);
  }
}
