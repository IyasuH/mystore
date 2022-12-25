import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mystore/models/accounts.dart';

class BankAccountDatabase {
  static final BankAccountDatabase instance = BankAccountDatabase._init();
  static Database? _database;

  BankAccountDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('bank.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final integerType = 'INTEGER NOT NULL';
    final doubleType = 'REAL NOT NULL';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
CREATE TABLE $tableAccounts (
  ${AccountFields.id} $idType,
  ${AccountFields.bankName} $textType,
  ${AccountFields.accountNumber} $integerType,
  ${AccountFields.amount} $doubleType,
  ${AccountFields.accountCreatedDate} $textType
)
''');
  }

  Future<BankAccount> create(BankAccount account) async {
    final db = await instance.database;

    // final json = account.toJson();
    // final columns =
    //     '${AccountFields.bankName}, ${AccountFields.accountNumber}, ${AccountFields.amount}, ${AccountFields.accountCreatedDate}';
    // final values = '${json[AccountFields.bankName]}, ${json[AccountFields.accountNumber]}, ${json[AccountFields.amount]}, ${json[AccountFields.accountCreatedDate]}';
    // final id =
    //     await db.rawInsert('INSERT INTO table_name ($column) VALUES ($values)');

    final id = await db.insert(tableAccounts, account.toJson());
    return account.copy(
        id: id,
        accountCreatedDate: DateTime(20, 12, 2022),
        accountNumber: 0,
        amount: 0,
        bankName: '');
  }

  Future readAccount(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableAccounts,
      columns: AccountFields.values,
      where: '${AccountFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return BankAccount.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<BankAccount>> readAllAccounts() async {
    final db = await instance.database;
    final result = await db.query(tableAccounts,
        orderBy: '${AccountFields.accountCreatedDate} ASC');
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableAccounts ORDER BY $orderBy');

    return result.map((json) => BankAccount.fromJson(json)).toList();
  }

  Future<int> update(BankAccount account) async {
    final db = await instance.database;
    return db.update(
      tableAccounts,
      account.toJson(),
      where: '${AccountFields.id} = ?',
      whereArgs: [account.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableAccounts,
      where: '${AccountFields.id} = ?',
      whereArgs: [AccountFields.id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
