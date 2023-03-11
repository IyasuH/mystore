import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

import '../tools/helper.dart';
import 'view.list.dart';

part 'model.g.dart';
part 'model.g.view.dart';

// initialy I created this table just to Store the name of the app owner
// so i can say Good Morning `name`
// but thinking expanding this I can store other things
const tablePersonal = SqfEntityTable(
  tableName: 'personal',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  // useSoftDeleting: true,
  modelName: null,
  fields: [
    SqfEntityField(
      'name',
      DbType.text,
      isNotNull: true,
    ),
  ],
);

const tableBank = SqfEntityTable(
  tableName: 'Bank',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  // useSoftDeleting: true,
  modelName: null,
  fields: [
    SqfEntityField(
      'name',
      DbType.text,
      isNotNull: true,
    ),
    // since accountNumber Could be long number just use text type
    SqfEntityField(
      'accountNumber',
      DbType.text,
      isNotNull: true,
    ),
    SqfEntityField(
      'amount',
      DbType.real,
      isNotNull: true,
    ),
    // This is actual day account created
    // default value for it is today also maxValue is today
    SqfEntityField(
      'accountDate',
      DbType.date,
      isNotNull: true,
      defaultValue: 'DateTime.now()',
    ),
  ],
);

const tableItem = SqfEntityTable(
  tableName: 'Item',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  // useSoftDeleting: true,
  modelName: null,
  fields: [
    SqfEntityField(
      'name',
      DbType.text,
      isNotNull: true,
    ),
    SqfEntityField(
      'quantity',
      DbType.integer,
      isNotNull: true,
    ),
    SqfEntityField(
      'singlePrice',
      DbType.real,
      isNotNull: true,
    ),
    SqfEntityField(
      'bulkPrice',
      DbType.real,
      isNotNull: true,
    ),
    // This The last two are additional columns
    SqfEntityField(
      'purchaseFreq',
      DbType.integer,
      isNotNull: true,
      defaultValue: 0,
    ),
    SqfEntityField(
      'totPurchase',
      DbType.real,
      isNotNull: true,
      defaultValue: 0.0,
    ),
  ],
);

const tableClient = SqfEntityTable(
  tableName: 'Client',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  // useSoftDeleting: true,
  modelName: null,
  fields: [
    SqfEntityField(
      'name',
      DbType.text,
      isNotNull: true,
    ),
    // companyName nullable
    SqfEntityField(
      'companyName',
      DbType.text,
      isNotNull: true,
    ), // if any
    // bankName name and bankNumber Nullable nachwe
    // clients yemitekemwe bankName
    SqfEntityField(
      'bankName',
      DbType.text,
    ),
    // bankNumber is clients bankAccountNumber the long Number that goes like 1000...
    SqfEntityField(
      'bankNumber',
      DbType.text,
    ),
    // since no computation on tinNumber and since it may be quite long i used just text type
    // nullable
    SqfEntityField(
      'tinNumber',
      DbType.text,
    ),
    SqfEntityField(
      'city',
      DbType.text,
      isNotNull: true,
    ),
    SqfEntityField(
      'phoneN',
      DbType.text,
      isNotNull: true,
    ),
    // default value for purchaseFreq and totPurchase is 0 when client register for first time
    SqfEntityField(
      'purchaseFreq',
      DbType.integer,
      isNotNull: true,
      defaultValue: 0,
    ),
    SqfEntityField(
      'totPurchase',
      DbType.real,
      isNotNull: true,
      defaultValue: 0.0,
    ),
  ],
);

const tableExpenses = SqfEntityTable(
  tableName: 'Expense',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  // useSoftDeleting: true,
  modelName: null,
  fields: [
    SqfEntityField(
      'name',
      DbType.text,
      isNotNull: true,
    ),
    SqfEntityField(
      'amount',
      DbType.real,
      isNotNull: true,
    ),
    // expense type for now only variable and fixed and defualt value is fixed
    // since there is enum type i just use text type
    SqfEntityField(
      'type',
      DbType.text,
      isNotNull: true,
      defaultValue: 'Fixed',
    ),
    // expense happend day maxValue is Today
    SqfEntityField(
      'date',
      DbType.date,
      maxValue: 'DateTime.now()',
      isNotNull: true,
      defaultValue: 'DateTime.now()',
    ),
  ],
);

const tableSales = SqfEntityTable(
  tableName: 'Sales',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  // useSoftDeleting: true,
  modelName: null,
  // here since i make item, client and bank delete on cascade
  // will delete sales when delete one row from one of the tables
  // but it doesn't edit back this tables when deleting by cacscade
  // only when deleting formally will reUpdate other tables
  fields: [
    // Relationship column for ItemId of sales to tell which item is sold
    SqfEntityFieldRelationship(
        parentTable: tableItem,
        deleteRule: DeleteRule.CASCADE,
        // here formDropDownTextField is the value that going to be displayed from item table
        // table['name']
        formDropDownTextField: 'name'),
    // Relationship column for ClientId of sales to tell which client bought the item
    SqfEntityFieldRelationship(
        parentTable: tableClient,
        deleteRule: DeleteRule.CASCADE,
        // here formDropDownTextField is the value that going to be displayed from client table
        // table['name']
        formDropDownTextField: 'name'),
    // Relationship column for BankId of sales
    // just to tell at which bank the sales revenue stored
    SqfEntityFieldRelationship(
      parentTable: tableBank,
      deleteRule: DeleteRule.CASCADE,
      // here formDropDownTextField is the value that going to be displayed from bank table
      // table['name']
      formDropDownTextField: 'name',
    ),
    SqfEntityField(
      'quantity',
      DbType.integer,
      defaultValue: 1,
      isNotNull: true,
    ),
    // `date` is actually Sales Date
    SqfEntityField(
      'date',
      DbType.date,
      isNotNull: true,
      defaultValue: 'DateTime.now()',
    ),
    // sales revenue genrated
    SqfEntityField(
      'revenue',
      DbType.real,
      isNotNull: true,
    ),
    // add info if needed
    SqfEntityField(
      'info',
      DbType.text,
      defaultValue: '',
    ),
  ],
);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'MyStoreDbModel',
  databaseName: 'myStore_v1.db',
  password: null,
  databaseTables: [
    tablePersonal,
    tableBank,
    tableItem,
    tableClient,
    tableExpenses,
    tableSales,
  ],
  formTables: [
    tablePersonal,
    tableBank,
    tableItem,
    tableClient,
    tableExpenses,
    tableSales,
  ],
  sequences: [seqIdentity],
  dbVersion: 1,
  bundledDatabasePath: null,
  databasePath: null,
  defaultColumns: [
    // createAt and updatedAt tell when the data recorder and updated
    // so unless otherwise usually set by default value
    SqfEntityField(
      'createdAt',
      DbType.datetime,
      defaultValue: 'DateTime.now()',
      isNotNull: true,
    ),
    SqfEntityField(
      'updatedAt',
      DbType.datetime,
      defaultValue: 'DateTime.now()',
      isNotNull: true,
    ),
  ],
);
