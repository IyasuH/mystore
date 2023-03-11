// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SqfEntityFormGenerator
// **************************************************************************

part of 'model.dart';

class PersonalAdd extends StatefulWidget {
  PersonalAdd(this._personal);
  final dynamic _personal;
  @override
  State<StatefulWidget> createState() =>
      PersonalAddState(_personal as Personal);
}

class PersonalAddState extends State {
  PersonalAddState(this.personal);
  Personal personal;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtCreatedAt = TextEditingController();
  final TextEditingController txtTimeForCreatedAt = TextEditingController();
  final TextEditingController txtUpdatedAt = TextEditingController();
  final TextEditingController txtTimeForUpdatedAt = TextEditingController();

  @override
  void initState() {
    txtName.text = personal.name == null ? '' : personal.name.toString();
    txtCreatedAt.text = personal.createdAt == null
        ? ''
        : UITools.convertDate(personal.createdAt!);
    txtTimeForCreatedAt.text = personal.createdAt == null
        ? ''
        : UITools.convertTime(personal.createdAt!);

    txtUpdatedAt.text = personal.updatedAt == null
        ? ''
        : UITools.convertDate(personal.updatedAt!);
    txtTimeForUpdatedAt.text = personal.updatedAt == null
        ? ''
        : UITools.convertTime(personal.updatedAt!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (personal.id == null)
            ? Text('Add a new personal')
            : Text('Edit personal'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowName(),
                    buildRowCreatedAt(),
                    buildRowUpdatedAt(),
                    TextButton(
                      child: saveButton(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a Snackbar.
                          save();
                          /* Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Processing Data')));
                           */
                        }
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowName() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Name';
        }
        return null;
      },
      controller: txtName,
      decoration: InputDecoration(labelText: 'Name'),
    );
  }

  Widget buildRowCreatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtCreatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtCreatedAt.text) ??
                  personal.createdAt ??
                  DateTime.now();
              personal.createdAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtCreatedAt.text) ??
                  personal.createdAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter CreatedAt';
            }
            return null;
          },
          controller: txtCreatedAt,
          decoration: InputDecoration(labelText: 'CreatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtCreatedAt.text) ??
                    personal.createdAt ??
                    DateTime.now();
                personal.createdAt = DateTime(d.year, d.month, d.day).add(
                    Duration(
                        hours: sqfSelectedDate.hour,
                        minutes: sqfSelectedDate.minute,
                        seconds: sqfSelectedDate.second));
                txtCreatedAt.text = UITools.convertDate(personal.createdAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForCreatedAt.text}') ??
                    personal.createdAt ??
                    DateTime.now()),
            controller: txtTimeForCreatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Widget buildRowUpdatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtUpdatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtUpdatedAt.text) ??
                  personal.updatedAt ??
                  DateTime.now();
              personal.updatedAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtUpdatedAt.text) ??
                  personal.updatedAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter UpdatedAt';
            }
            return null;
          },
          controller: txtUpdatedAt,
          decoration: InputDecoration(labelText: 'UpdatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtUpdatedAt.text) ??
                    personal.updatedAt ??
                    DateTime.now();
                personal.updatedAt = DateTime(d.year, d.month, d.day).add(
                    Duration(
                        hours: sqfSelectedDate.hour,
                        minutes: sqfSelectedDate.minute,
                        seconds: sqfSelectedDate.second));
                txtUpdatedAt.text = UITools.convertDate(personal.updatedAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForUpdatedAt.text}') ??
                    personal.updatedAt ??
                    DateTime.now()),
            controller: txtTimeForUpdatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Container saveButton() {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(95, 66, 119, 1.0),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  void save() async {
    var _createdAt = DateTime.tryParse(txtCreatedAt.text);
    final _createdAtTime = DateTime.tryParse(txtTimeForCreatedAt.text);
    if (_createdAt != null && _createdAtTime != null) {
      _createdAt = _createdAt.add(Duration(
          hours: _createdAtTime.hour,
          minutes: _createdAtTime.minute,
          seconds: _createdAtTime.second));
    }
    var _updatedAt = DateTime.tryParse(txtUpdatedAt.text);
    final _updatedAtTime = DateTime.tryParse(txtTimeForUpdatedAt.text);
    if (_updatedAt != null && _updatedAtTime != null) {
      _updatedAt = _updatedAt.add(Duration(
          hours: _updatedAtTime.hour,
          minutes: _updatedAtTime.minute,
          seconds: _updatedAtTime.second));
    }

    personal
      ..name = txtName.text
      ..createdAt = _createdAt
      ..updatedAt = _updatedAt;
    await personal.save();
    if (personal.saveResult!.success) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(personal.saveResult.toString(),
          title: 'save Personal Failed!', callBack: () {});
    }
  }
}

class BankAdd extends StatefulWidget {
  BankAdd(this._bank);
  final dynamic _bank;
  @override
  State<StatefulWidget> createState() => BankAddState(_bank as Bank);
}

class BankAddState extends State {
  BankAddState(this.bank);
  Bank bank;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtAccountNumber = TextEditingController();
  final TextEditingController txtAmount = TextEditingController();
  final TextEditingController txtAccountDate = TextEditingController();
  final TextEditingController txtCreatedAt = TextEditingController();
  final TextEditingController txtTimeForCreatedAt = TextEditingController();
  final TextEditingController txtUpdatedAt = TextEditingController();
  final TextEditingController txtTimeForUpdatedAt = TextEditingController();

  @override
  void initState() {
    txtName.text = bank.name == null ? '' : bank.name.toString();
    txtAccountNumber.text =
        bank.accountNumber == null ? '' : bank.accountNumber.toString();
    txtAmount.text = bank.amount == null ? '' : bank.amount.toString();
    txtAccountDate.text =
        bank.accountDate == null ? '' : UITools.convertDate(bank.accountDate!);
    txtCreatedAt.text =
        bank.createdAt == null ? '' : UITools.convertDate(bank.createdAt!);
    txtTimeForCreatedAt.text =
        bank.createdAt == null ? '' : UITools.convertTime(bank.createdAt!);

    txtUpdatedAt.text =
        bank.updatedAt == null ? '' : UITools.convertDate(bank.updatedAt!);
    txtTimeForUpdatedAt.text =
        bank.updatedAt == null ? '' : UITools.convertTime(bank.updatedAt!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (bank.id == null) ? Text('Add a new bank') : Text('Edit bank'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowName(),
                    buildRowAccountNumber(),
                    buildRowAmount(),
                    buildRowAccountDate(),
                    buildRowCreatedAt(),
                    buildRowUpdatedAt(),
                    TextButton(
                      child: saveButton(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a Snackbar.
                          save();
                          /* Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Processing Data')));
                           */
                        }
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowName() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Name';
        }
        return null;
      },
      controller: txtName,
      decoration: InputDecoration(labelText: 'Name'),
    );
  }

  Widget buildRowAccountNumber() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter AccountNumber';
        }
        return null;
      },
      controller: txtAccountNumber,
      decoration: InputDecoration(labelText: 'AccountNumber'),
    );
  }

  Widget buildRowAmount() {
    return TextFormField(
      validator: (value) {
        if (double.tryParse(value!) == null) {
          return 'Please Enter valid number (required)';
        }

        return null;
      },
      controller: txtAmount,
      decoration: InputDecoration(labelText: 'Amount'),
    );
  }

  Widget buildRowAccountDate() {
    return TextFormField(
      onTap: () => UITools.showDateTimePicker(context,
          minTime: DateTime.parse('1900-01-01'), onConfirm: (sqfSelectedDate) {
        txtAccountDate.text = UITools.convertDate(sqfSelectedDate);
        setState(() {
          bank.accountDate = sqfSelectedDate;
        });
      },
          currentTime: DateTime.tryParse(txtAccountDate.text) ??
              bank.accountDate ??
              DateTime.now()),
      controller: txtAccountDate,
      decoration: InputDecoration(labelText: 'AccountDate'),
    );
  }

  Widget buildRowCreatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtCreatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtCreatedAt.text) ??
                  bank.createdAt ??
                  DateTime.now();
              bank.createdAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtCreatedAt.text) ??
                  bank.createdAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter CreatedAt';
            }
            return null;
          },
          controller: txtCreatedAt,
          decoration: InputDecoration(labelText: 'CreatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtCreatedAt.text) ??
                    bank.createdAt ??
                    DateTime.now();
                bank.createdAt = DateTime(d.year, d.month, d.day).add(Duration(
                    hours: sqfSelectedDate.hour,
                    minutes: sqfSelectedDate.minute,
                    seconds: sqfSelectedDate.second));
                txtCreatedAt.text = UITools.convertDate(bank.createdAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForCreatedAt.text}') ??
                    bank.createdAt ??
                    DateTime.now()),
            controller: txtTimeForCreatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Widget buildRowUpdatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtUpdatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtUpdatedAt.text) ??
                  bank.updatedAt ??
                  DateTime.now();
              bank.updatedAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtUpdatedAt.text) ??
                  bank.updatedAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter UpdatedAt';
            }
            return null;
          },
          controller: txtUpdatedAt,
          decoration: InputDecoration(labelText: 'UpdatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtUpdatedAt.text) ??
                    bank.updatedAt ??
                    DateTime.now();
                bank.updatedAt = DateTime(d.year, d.month, d.day).add(Duration(
                    hours: sqfSelectedDate.hour,
                    minutes: sqfSelectedDate.minute,
                    seconds: sqfSelectedDate.second));
                txtUpdatedAt.text = UITools.convertDate(bank.updatedAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForUpdatedAt.text}') ??
                    bank.updatedAt ??
                    DateTime.now()),
            controller: txtTimeForUpdatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Container saveButton() {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(95, 66, 119, 1.0),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  void save() async {
    final _accountDate = DateTime.tryParse(txtAccountDate.text);
    var _createdAt = DateTime.tryParse(txtCreatedAt.text);
    final _createdAtTime = DateTime.tryParse(txtTimeForCreatedAt.text);
    if (_createdAt != null && _createdAtTime != null) {
      _createdAt = _createdAt.add(Duration(
          hours: _createdAtTime.hour,
          minutes: _createdAtTime.minute,
          seconds: _createdAtTime.second));
    }
    var _updatedAt = DateTime.tryParse(txtUpdatedAt.text);
    final _updatedAtTime = DateTime.tryParse(txtTimeForUpdatedAt.text);
    if (_updatedAt != null && _updatedAtTime != null) {
      _updatedAt = _updatedAt.add(Duration(
          hours: _updatedAtTime.hour,
          minutes: _updatedAtTime.minute,
          seconds: _updatedAtTime.second));
    }

    bank
      ..name = txtName.text
      ..accountNumber = txtAccountNumber.text
      ..amount = double.tryParse(txtAmount.text)
      ..accountDate = _accountDate
      ..createdAt = _createdAt
      ..updatedAt = _updatedAt;
    await bank.save();
    if (bank.saveResult!.success) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(bank.saveResult.toString(),
          title: 'save Bank Failed!', callBack: () {});
    }
  }
}

class ItemAdd extends StatefulWidget {
  ItemAdd(this._item);
  final dynamic _item;
  @override
  State<StatefulWidget> createState() => ItemAddState(_item as Item);
}

class ItemAddState extends State {
  ItemAddState(this.item);
  Item item;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtQuantity = TextEditingController();
  final TextEditingController txtSinglePrice = TextEditingController();
  final TextEditingController txtBulkPrice = TextEditingController();
  final TextEditingController txtPurchaseFreq = TextEditingController();
  final TextEditingController txtTotPurchase = TextEditingController();
  final TextEditingController txtCreatedAt = TextEditingController();
  final TextEditingController txtTimeForCreatedAt = TextEditingController();
  final TextEditingController txtUpdatedAt = TextEditingController();
  final TextEditingController txtTimeForUpdatedAt = TextEditingController();

  @override
  void initState() {
    txtName.text = item.name == null ? '' : item.name.toString();
    txtQuantity.text = item.quantity == null ? '' : item.quantity.toString();
    txtSinglePrice.text =
        item.singlePrice == null ? '' : item.singlePrice.toString();
    txtBulkPrice.text = item.bulkPrice == null ? '' : item.bulkPrice.toString();
    txtPurchaseFreq.text =
        item.purchaseFreq == null ? '' : item.purchaseFreq.toString();
    txtTotPurchase.text =
        item.totPurchase == null ? '' : item.totPurchase.toString();
    txtCreatedAt.text =
        item.createdAt == null ? '' : UITools.convertDate(item.createdAt!);
    txtTimeForCreatedAt.text =
        item.createdAt == null ? '' : UITools.convertTime(item.createdAt!);

    txtUpdatedAt.text =
        item.updatedAt == null ? '' : UITools.convertDate(item.updatedAt!);
    txtTimeForUpdatedAt.text =
        item.updatedAt == null ? '' : UITools.convertTime(item.updatedAt!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (item.id == null) ? Text('Add a new item') : Text('Edit item'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowName(),
                    buildRowQuantity(),
                    buildRowSinglePrice(),
                    buildRowBulkPrice(),
                    buildRowPurchaseFreq(),
                    buildRowTotPurchase(),
                    buildRowCreatedAt(),
                    buildRowUpdatedAt(),
                    TextButton(
                      child: saveButton(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a Snackbar.
                          save();
                          /* Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Processing Data')));
                           */
                        }
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowName() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Name';
        }
        return null;
      },
      controller: txtName,
      decoration: InputDecoration(labelText: 'Name'),
    );
  }

  Widget buildRowQuantity() {
    return TextFormField(
      validator: (value) {
        if (int.tryParse(value!) == null) {
          return 'Please Enter valid number (required)';
        }

        return null;
      },
      controller: txtQuantity,
      decoration: InputDecoration(labelText: 'Quantity'),
    );
  }

  Widget buildRowSinglePrice() {
    return TextFormField(
      validator: (value) {
        if (double.tryParse(value!) == null) {
          return 'Please Enter valid number (required)';
        }

        return null;
      },
      controller: txtSinglePrice,
      decoration: InputDecoration(labelText: 'SinglePrice'),
    );
  }

  Widget buildRowBulkPrice() {
    return TextFormField(
      validator: (value) {
        if (double.tryParse(value!) == null) {
          return 'Please Enter valid number (required)';
        }

        return null;
      },
      controller: txtBulkPrice,
      decoration: InputDecoration(labelText: 'BulkPrice'),
    );
  }

  Widget buildRowPurchaseFreq() {
    return TextFormField(
      validator: (value) {
        if (int.tryParse(value!) == null) {
          return 'Please Enter valid number (required)';
        }

        return null;
      },
      controller: txtPurchaseFreq,
      decoration: InputDecoration(labelText: 'PurchaseFreq'),
    );
  }

  Widget buildRowTotPurchase() {
    return TextFormField(
      validator: (value) {
        if (double.tryParse(value!) == null) {
          return 'Please Enter valid number (required)';
        }

        return null;
      },
      controller: txtTotPurchase,
      decoration: InputDecoration(labelText: 'TotPurchase'),
    );
  }

  Widget buildRowCreatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtCreatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtCreatedAt.text) ??
                  item.createdAt ??
                  DateTime.now();
              item.createdAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtCreatedAt.text) ??
                  item.createdAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter CreatedAt';
            }
            return null;
          },
          controller: txtCreatedAt,
          decoration: InputDecoration(labelText: 'CreatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtCreatedAt.text) ??
                    item.createdAt ??
                    DateTime.now();
                item.createdAt = DateTime(d.year, d.month, d.day).add(Duration(
                    hours: sqfSelectedDate.hour,
                    minutes: sqfSelectedDate.minute,
                    seconds: sqfSelectedDate.second));
                txtCreatedAt.text = UITools.convertDate(item.createdAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForCreatedAt.text}') ??
                    item.createdAt ??
                    DateTime.now()),
            controller: txtTimeForCreatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Widget buildRowUpdatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtUpdatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtUpdatedAt.text) ??
                  item.updatedAt ??
                  DateTime.now();
              item.updatedAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtUpdatedAt.text) ??
                  item.updatedAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter UpdatedAt';
            }
            return null;
          },
          controller: txtUpdatedAt,
          decoration: InputDecoration(labelText: 'UpdatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtUpdatedAt.text) ??
                    item.updatedAt ??
                    DateTime.now();
                item.updatedAt = DateTime(d.year, d.month, d.day).add(Duration(
                    hours: sqfSelectedDate.hour,
                    minutes: sqfSelectedDate.minute,
                    seconds: sqfSelectedDate.second));
                txtUpdatedAt.text = UITools.convertDate(item.updatedAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForUpdatedAt.text}') ??
                    item.updatedAt ??
                    DateTime.now()),
            controller: txtTimeForUpdatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Container saveButton() {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(95, 66, 119, 1.0),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  void save() async {
    var _createdAt = DateTime.tryParse(txtCreatedAt.text);
    final _createdAtTime = DateTime.tryParse(txtTimeForCreatedAt.text);
    if (_createdAt != null && _createdAtTime != null) {
      _createdAt = _createdAt.add(Duration(
          hours: _createdAtTime.hour,
          minutes: _createdAtTime.minute,
          seconds: _createdAtTime.second));
    }
    var _updatedAt = DateTime.tryParse(txtUpdatedAt.text);
    final _updatedAtTime = DateTime.tryParse(txtTimeForUpdatedAt.text);
    if (_updatedAt != null && _updatedAtTime != null) {
      _updatedAt = _updatedAt.add(Duration(
          hours: _updatedAtTime.hour,
          minutes: _updatedAtTime.minute,
          seconds: _updatedAtTime.second));
    }

    item
      ..name = txtName.text
      ..quantity = int.tryParse(txtQuantity.text)
      ..singlePrice = double.tryParse(txtSinglePrice.text)
      ..bulkPrice = double.tryParse(txtBulkPrice.text)
      ..purchaseFreq = int.tryParse(txtPurchaseFreq.text)
      ..totPurchase = double.tryParse(txtTotPurchase.text)
      ..createdAt = _createdAt
      ..updatedAt = _updatedAt;
    await item.save();
    if (item.saveResult!.success) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(item.saveResult.toString(),
          title: 'save Item Failed!', callBack: () {});
    }
  }
}

class ClientAdd extends StatefulWidget {
  ClientAdd(this._client);
  final dynamic _client;
  @override
  State<StatefulWidget> createState() => ClientAddState(_client as Client);
}

class ClientAddState extends State {
  ClientAddState(this.client);
  Client client;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtCompanyName = TextEditingController();
  final TextEditingController txtBankName = TextEditingController();
  final TextEditingController txtBankNumber = TextEditingController();
  final TextEditingController txtTinNumber = TextEditingController();
  final TextEditingController txtCity = TextEditingController();
  final TextEditingController txtPhoneN = TextEditingController();
  final TextEditingController txtPurchaseFreq = TextEditingController();
  final TextEditingController txtTotPurchase = TextEditingController();
  final TextEditingController txtCreatedAt = TextEditingController();
  final TextEditingController txtTimeForCreatedAt = TextEditingController();
  final TextEditingController txtUpdatedAt = TextEditingController();
  final TextEditingController txtTimeForUpdatedAt = TextEditingController();

  @override
  void initState() {
    txtName.text = client.name == null ? '' : client.name.toString();
    txtCompanyName.text =
        client.companyName == null ? '' : client.companyName.toString();
    txtBankName.text =
        client.bankName == null ? '' : client.bankName.toString();
    txtBankNumber.text =
        client.bankNumber == null ? '' : client.bankNumber.toString();
    txtTinNumber.text =
        client.tinNumber == null ? '' : client.tinNumber.toString();
    txtCity.text = client.city == null ? '' : client.city.toString();
    txtPhoneN.text = client.phoneN == null ? '' : client.phoneN.toString();
    txtPurchaseFreq.text =
        client.purchaseFreq == null ? '' : client.purchaseFreq.toString();
    txtTotPurchase.text =
        client.totPurchase == null ? '' : client.totPurchase.toString();
    txtCreatedAt.text =
        client.createdAt == null ? '' : UITools.convertDate(client.createdAt!);
    txtTimeForCreatedAt.text =
        client.createdAt == null ? '' : UITools.convertTime(client.createdAt!);

    txtUpdatedAt.text =
        client.updatedAt == null ? '' : UITools.convertDate(client.updatedAt!);
    txtTimeForUpdatedAt.text =
        client.updatedAt == null ? '' : UITools.convertTime(client.updatedAt!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (client.id == null)
            ? Text('Add a new client')
            : Text('Edit client'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowName(),
                    buildRowCompanyName(),
                    buildRowBankName(),
                    buildRowBankNumber(),
                    buildRowTinNumber(),
                    buildRowCity(),
                    buildRowPhoneN(),
                    buildRowPurchaseFreq(),
                    buildRowTotPurchase(),
                    buildRowCreatedAt(),
                    buildRowUpdatedAt(),
                    TextButton(
                      child: saveButton(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a Snackbar.
                          save();
                          /* Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Processing Data')));
                           */
                        }
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowName() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Name';
        }
        return null;
      },
      controller: txtName,
      decoration: InputDecoration(labelText: 'Name'),
    );
  }

  Widget buildRowCompanyName() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter CompanyName';
        }
        return null;
      },
      controller: txtCompanyName,
      decoration: InputDecoration(labelText: 'CompanyName'),
    );
  }

  Widget buildRowBankName() {
    return TextFormField(
      controller: txtBankName,
      decoration: InputDecoration(labelText: 'BankName'),
    );
  }

  Widget buildRowBankNumber() {
    return TextFormField(
      controller: txtBankNumber,
      decoration: InputDecoration(labelText: 'BankNumber'),
    );
  }

  Widget buildRowTinNumber() {
    return TextFormField(
      controller: txtTinNumber,
      decoration: InputDecoration(labelText: 'TinNumber'),
    );
  }

  Widget buildRowCity() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter City';
        }
        return null;
      },
      controller: txtCity,
      decoration: InputDecoration(labelText: 'City'),
    );
  }

  Widget buildRowPhoneN() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter PhoneN';
        }
        return null;
      },
      controller: txtPhoneN,
      decoration: InputDecoration(labelText: 'PhoneN'),
    );
  }

  Widget buildRowPurchaseFreq() {
    return TextFormField(
      validator: (value) {
        if (int.tryParse(value!) == null) {
          return 'Please Enter valid number (required)';
        }

        return null;
      },
      controller: txtPurchaseFreq,
      decoration: InputDecoration(labelText: 'PurchaseFreq'),
    );
  }

  Widget buildRowTotPurchase() {
    return TextFormField(
      validator: (value) {
        if (double.tryParse(value!) == null) {
          return 'Please Enter valid number (required)';
        }

        return null;
      },
      controller: txtTotPurchase,
      decoration: InputDecoration(labelText: 'TotPurchase'),
    );
  }

  Widget buildRowCreatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtCreatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtCreatedAt.text) ??
                  client.createdAt ??
                  DateTime.now();
              client.createdAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtCreatedAt.text) ??
                  client.createdAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter CreatedAt';
            }
            return null;
          },
          controller: txtCreatedAt,
          decoration: InputDecoration(labelText: 'CreatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtCreatedAt.text) ??
                    client.createdAt ??
                    DateTime.now();
                client.createdAt = DateTime(d.year, d.month, d.day).add(
                    Duration(
                        hours: sqfSelectedDate.hour,
                        minutes: sqfSelectedDate.minute,
                        seconds: sqfSelectedDate.second));
                txtCreatedAt.text = UITools.convertDate(client.createdAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForCreatedAt.text}') ??
                    client.createdAt ??
                    DateTime.now()),
            controller: txtTimeForCreatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Widget buildRowUpdatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtUpdatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtUpdatedAt.text) ??
                  client.updatedAt ??
                  DateTime.now();
              client.updatedAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtUpdatedAt.text) ??
                  client.updatedAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter UpdatedAt';
            }
            return null;
          },
          controller: txtUpdatedAt,
          decoration: InputDecoration(labelText: 'UpdatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtUpdatedAt.text) ??
                    client.updatedAt ??
                    DateTime.now();
                client.updatedAt = DateTime(d.year, d.month, d.day).add(
                    Duration(
                        hours: sqfSelectedDate.hour,
                        minutes: sqfSelectedDate.minute,
                        seconds: sqfSelectedDate.second));
                txtUpdatedAt.text = UITools.convertDate(client.updatedAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForUpdatedAt.text}') ??
                    client.updatedAt ??
                    DateTime.now()),
            controller: txtTimeForUpdatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Container saveButton() {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(95, 66, 119, 1.0),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  void save() async {
    var _createdAt = DateTime.tryParse(txtCreatedAt.text);
    final _createdAtTime = DateTime.tryParse(txtTimeForCreatedAt.text);
    if (_createdAt != null && _createdAtTime != null) {
      _createdAt = _createdAt.add(Duration(
          hours: _createdAtTime.hour,
          minutes: _createdAtTime.minute,
          seconds: _createdAtTime.second));
    }
    var _updatedAt = DateTime.tryParse(txtUpdatedAt.text);
    final _updatedAtTime = DateTime.tryParse(txtTimeForUpdatedAt.text);
    if (_updatedAt != null && _updatedAtTime != null) {
      _updatedAt = _updatedAt.add(Duration(
          hours: _updatedAtTime.hour,
          minutes: _updatedAtTime.minute,
          seconds: _updatedAtTime.second));
    }

    client
      ..name = txtName.text
      ..companyName = txtCompanyName.text
      ..bankName = txtBankName.text
      ..bankNumber = txtBankNumber.text
      ..tinNumber = txtTinNumber.text
      ..city = txtCity.text
      ..phoneN = txtPhoneN.text
      ..purchaseFreq = int.tryParse(txtPurchaseFreq.text)
      ..totPurchase = double.tryParse(txtTotPurchase.text)
      ..createdAt = _createdAt
      ..updatedAt = _updatedAt;
    await client.save();
    if (client.saveResult!.success) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(client.saveResult.toString(),
          title: 'save Client Failed!', callBack: () {});
    }
  }
}

class ExpenseAdd extends StatefulWidget {
  ExpenseAdd(this._expense);
  final dynamic _expense;
  @override
  State<StatefulWidget> createState() => ExpenseAddState(_expense as Expense);
}

class ExpenseAddState extends State {
  ExpenseAddState(this.expense);
  Expense expense;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtAmount = TextEditingController();
  final TextEditingController txtType = TextEditingController();
  final TextEditingController txtDate = TextEditingController();
  final TextEditingController txtCreatedAt = TextEditingController();
  final TextEditingController txtTimeForCreatedAt = TextEditingController();
  final TextEditingController txtUpdatedAt = TextEditingController();
  final TextEditingController txtTimeForUpdatedAt = TextEditingController();

  @override
  void initState() {
    txtName.text = expense.name == null ? '' : expense.name.toString();
    txtAmount.text = expense.amount == null ? '' : expense.amount.toString();
    txtType.text = expense.type == null ? '' : expense.type.toString();
    txtDate.text =
        expense.date == null ? '' : UITools.convertDate(expense.date!);
    txtCreatedAt.text = expense.createdAt == null
        ? ''
        : UITools.convertDate(expense.createdAt!);
    txtTimeForCreatedAt.text = expense.createdAt == null
        ? ''
        : UITools.convertTime(expense.createdAt!);

    txtUpdatedAt.text = expense.updatedAt == null
        ? ''
        : UITools.convertDate(expense.updatedAt!);
    txtTimeForUpdatedAt.text = expense.updatedAt == null
        ? ''
        : UITools.convertTime(expense.updatedAt!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (expense.id == null)
            ? Text('Add a new expense')
            : Text('Edit expense'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowName(),
                    buildRowAmount(),
                    buildRowType(),
                    buildRowDate(),
                    buildRowCreatedAt(),
                    buildRowUpdatedAt(),
                    TextButton(
                      child: saveButton(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a Snackbar.
                          save();
                          /* Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Processing Data')));
                           */
                        }
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowName() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Name';
        }
        return null;
      },
      controller: txtName,
      decoration: InputDecoration(labelText: 'Name'),
    );
  }

  Widget buildRowAmount() {
    return TextFormField(
      validator: (value) {
        if (double.tryParse(value!) == null) {
          return 'Please Enter valid number (required)';
        }

        return null;
      },
      controller: txtAmount,
      decoration: InputDecoration(labelText: 'Amount'),
    );
  }

  Widget buildRowType() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Type';
        }
        return null;
      },
      controller: txtType,
      decoration: InputDecoration(labelText: 'Type'),
    );
  }

  Widget buildRowDate() {
    return TextFormField(
      onTap: () => UITools.showDateTimePicker(context,
          minTime: DateTime.parse('1900-01-01'),
          maxTime: DateTime.now(), onConfirm: (sqfSelectedDate) {
        txtDate.text = UITools.convertDate(sqfSelectedDate);
        setState(() {
          expense.date = sqfSelectedDate;
        });
      },
          currentTime: DateTime.tryParse(txtDate.text) ??
              expense.date ??
              DateTime.now()),
      controller: txtDate,
      decoration: InputDecoration(labelText: 'Date'),
    );
  }

  Widget buildRowCreatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtCreatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtCreatedAt.text) ??
                  expense.createdAt ??
                  DateTime.now();
              expense.createdAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtCreatedAt.text) ??
                  expense.createdAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter CreatedAt';
            }
            return null;
          },
          controller: txtCreatedAt,
          decoration: InputDecoration(labelText: 'CreatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtCreatedAt.text) ??
                    expense.createdAt ??
                    DateTime.now();
                expense.createdAt = DateTime(d.year, d.month, d.day).add(
                    Duration(
                        hours: sqfSelectedDate.hour,
                        minutes: sqfSelectedDate.minute,
                        seconds: sqfSelectedDate.second));
                txtCreatedAt.text = UITools.convertDate(expense.createdAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForCreatedAt.text}') ??
                    expense.createdAt ??
                    DateTime.now()),
            controller: txtTimeForCreatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Widget buildRowUpdatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtUpdatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtUpdatedAt.text) ??
                  expense.updatedAt ??
                  DateTime.now();
              expense.updatedAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtUpdatedAt.text) ??
                  expense.updatedAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter UpdatedAt';
            }
            return null;
          },
          controller: txtUpdatedAt,
          decoration: InputDecoration(labelText: 'UpdatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtUpdatedAt.text) ??
                    expense.updatedAt ??
                    DateTime.now();
                expense.updatedAt = DateTime(d.year, d.month, d.day).add(
                    Duration(
                        hours: sqfSelectedDate.hour,
                        minutes: sqfSelectedDate.minute,
                        seconds: sqfSelectedDate.second));
                txtUpdatedAt.text = UITools.convertDate(expense.updatedAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForUpdatedAt.text}') ??
                    expense.updatedAt ??
                    DateTime.now()),
            controller: txtTimeForUpdatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Container saveButton() {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(95, 66, 119, 1.0),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  void save() async {
    final _date = DateTime.tryParse(txtDate.text);
    var _createdAt = DateTime.tryParse(txtCreatedAt.text);
    final _createdAtTime = DateTime.tryParse(txtTimeForCreatedAt.text);
    if (_createdAt != null && _createdAtTime != null) {
      _createdAt = _createdAt.add(Duration(
          hours: _createdAtTime.hour,
          minutes: _createdAtTime.minute,
          seconds: _createdAtTime.second));
    }
    var _updatedAt = DateTime.tryParse(txtUpdatedAt.text);
    final _updatedAtTime = DateTime.tryParse(txtTimeForUpdatedAt.text);
    if (_updatedAt != null && _updatedAtTime != null) {
      _updatedAt = _updatedAt.add(Duration(
          hours: _updatedAtTime.hour,
          minutes: _updatedAtTime.minute,
          seconds: _updatedAtTime.second));
    }

    expense
      ..name = txtName.text
      ..amount = double.tryParse(txtAmount.text)
      ..type = txtType.text
      ..date = _date
      ..createdAt = _createdAt
      ..updatedAt = _updatedAt;
    await expense.save();
    if (expense.saveResult!.success) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(expense.saveResult.toString(),
          title: 'save Expense Failed!', callBack: () {});
    }
  }
}

class SaleAdd extends StatefulWidget {
  SaleAdd(this._sales);
  final dynamic _sales;
  @override
  State<StatefulWidget> createState() => SaleAddState(_sales as Sale);
}

class SaleAddState extends State {
  SaleAddState(this.sales);
  Sale sales;
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<int>> _dropdownMenuItemsForItemId =
      <DropdownMenuItem<int>>[];
  int? _selectedItemId;

  List<DropdownMenuItem<int>> _dropdownMenuItemsForClientId =
      <DropdownMenuItem<int>>[];
  int? _selectedClientId;

  List<DropdownMenuItem<int>> _dropdownMenuItemsForBankId =
      <DropdownMenuItem<int>>[];
  int? _selectedBankId;

  final TextEditingController txtQuantity = TextEditingController();
  final TextEditingController txtDate = TextEditingController();
  final TextEditingController txtRevenue = TextEditingController();
  final TextEditingController txtInfo = TextEditingController();
  final TextEditingController txtCreatedAt = TextEditingController();
  final TextEditingController txtTimeForCreatedAt = TextEditingController();
  final TextEditingController txtUpdatedAt = TextEditingController();
  final TextEditingController txtTimeForUpdatedAt = TextEditingController();

  @override
  void initState() {
    txtQuantity.text = sales.quantity == null ? '' : sales.quantity.toString();
    txtDate.text = sales.date == null ? '' : UITools.convertDate(sales.date!);
    txtRevenue.text = sales.revenue == null ? '' : sales.revenue.toString();
    txtInfo.text = sales.info == null ? '' : sales.info.toString();
    txtCreatedAt.text =
        sales.createdAt == null ? '' : UITools.convertDate(sales.createdAt!);
    txtTimeForCreatedAt.text =
        sales.createdAt == null ? '' : UITools.convertTime(sales.createdAt!);

    txtUpdatedAt.text =
        sales.updatedAt == null ? '' : UITools.convertDate(sales.updatedAt!);
    txtTimeForUpdatedAt.text =
        sales.updatedAt == null ? '' : UITools.convertTime(sales.updatedAt!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void buildDropDownMenuForItemId() async {
      final dropdownMenuItems = await Item().select().toDropDownMenuInt('name');
      setState(() {
        _dropdownMenuItemsForItemId = dropdownMenuItems;
        _selectedItemId = sales.ItemId;
      });
    }

    if (_dropdownMenuItemsForItemId.isEmpty) {
      buildDropDownMenuForItemId();
    }
    void onChangeDropdownItemForItemId(int? selectedItemId) {
      setState(() {
        _selectedItemId = selectedItemId;
      });
    }

    void buildDropDownMenuForClientId() async {
      final dropdownMenuItems =
          await Client().select().toDropDownMenuInt('name');
      setState(() {
        _dropdownMenuItemsForClientId = dropdownMenuItems;
        _selectedClientId = sales.ClientId;
      });
    }

    if (_dropdownMenuItemsForClientId.isEmpty) {
      buildDropDownMenuForClientId();
    }
    void onChangeDropdownItemForClientId(int? selectedClientId) {
      setState(() {
        _selectedClientId = selectedClientId;
      });
    }

    void buildDropDownMenuForBankId() async {
      final dropdownMenuItems = await Bank().select().toDropDownMenuInt('name');
      setState(() {
        _dropdownMenuItemsForBankId = dropdownMenuItems;
        _selectedBankId = sales.BankId;
      });
    }

    if (_dropdownMenuItemsForBankId.isEmpty) {
      buildDropDownMenuForBankId();
    }
    void onChangeDropdownItemForBankId(int? selectedBankId) {
      setState(() {
        _selectedBankId = selectedBankId;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title:
            (sales.id == null) ? Text('Add a new sales') : Text('Edit sales'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowItemId(onChangeDropdownItemForItemId),
                    buildRowClientId(onChangeDropdownItemForClientId),
                    buildRowBankId(onChangeDropdownItemForBankId),
                    buildRowQuantity(),
                    buildRowDate(),
                    buildRowRevenue(),
                    buildRowInfo(),
                    buildRowCreatedAt(),
                    buildRowUpdatedAt(),
                    TextButton(
                      child: saveButton(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a Snackbar.
                          save();
                          /* Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Processing Data')));
                           */
                        }
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowItemId(
      void Function(int? selectedItemId) onChangeDropdownItemForItemId) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text('Item'),
        ),
        Expanded(
            flex: 2,
            child: Container(
              child: DropdownButtonFormField(
                value: _selectedItemId,
                items: _dropdownMenuItemsForItemId,
                onChanged: onChangeDropdownItemForItemId,
                validator: (value) {
                  return null;
                },
              ),
            )),
      ],
    );
  }

  Widget buildRowClientId(
      void Function(int? selectedClientId) onChangeDropdownItemForClientId) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text('Client'),
        ),
        Expanded(
            flex: 2,
            child: Container(
              child: DropdownButtonFormField(
                value: _selectedClientId,
                items: _dropdownMenuItemsForClientId,
                onChanged: onChangeDropdownItemForClientId,
                validator: (value) {
                  return null;
                },
              ),
            )),
      ],
    );
  }

  Widget buildRowBankId(
      void Function(int? selectedBankId) onChangeDropdownItemForBankId) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text('Bank'),
        ),
        Expanded(
            flex: 2,
            child: Container(
              child: DropdownButtonFormField(
                value: _selectedBankId,
                items: _dropdownMenuItemsForBankId,
                onChanged: onChangeDropdownItemForBankId,
                validator: (value) {
                  return null;
                },
              ),
            )),
      ],
    );
  }

  Widget buildRowQuantity() {
    return TextFormField(
      validator: (value) {
        if (int.tryParse(value!) == null) {
          return 'Please Enter valid number (required)';
        }

        return null;
      },
      controller: txtQuantity,
      decoration: InputDecoration(labelText: 'Quantity'),
    );
  }

  Widget buildRowDate() {
    return TextFormField(
      onTap: () => UITools.showDateTimePicker(context,
          minTime: DateTime.parse('1900-01-01'), onConfirm: (sqfSelectedDate) {
        txtDate.text = UITools.convertDate(sqfSelectedDate);
        setState(() {
          sales.date = sqfSelectedDate;
        });
      },
          currentTime:
              DateTime.tryParse(txtDate.text) ?? sales.date ?? DateTime.now()),
      controller: txtDate,
      decoration: InputDecoration(labelText: 'Date'),
    );
  }

  Widget buildRowRevenue() {
    return TextFormField(
      validator: (value) {
        if (double.tryParse(value!) == null) {
          return 'Please Enter valid number (required)';
        }

        return null;
      },
      controller: txtRevenue,
      decoration: InputDecoration(labelText: 'Revenue'),
    );
  }

  Widget buildRowInfo() {
    return TextFormField(
      controller: txtInfo,
      decoration: InputDecoration(labelText: 'Info'),
    );
  }

  Widget buildRowCreatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtCreatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtCreatedAt.text) ??
                  sales.createdAt ??
                  DateTime.now();
              sales.createdAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtCreatedAt.text) ??
                  sales.createdAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter CreatedAt';
            }
            return null;
          },
          controller: txtCreatedAt,
          decoration: InputDecoration(labelText: 'CreatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForCreatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtCreatedAt.text) ??
                    sales.createdAt ??
                    DateTime.now();
                sales.createdAt = DateTime(d.year, d.month, d.day).add(Duration(
                    hours: sqfSelectedDate.hour,
                    minutes: sqfSelectedDate.minute,
                    seconds: sqfSelectedDate.second));
                txtCreatedAt.text = UITools.convertDate(sales.createdAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForCreatedAt.text}') ??
                    sales.createdAt ??
                    DateTime.now()),
            controller: txtTimeForCreatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Widget buildRowUpdatedAt() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          onTap: () => UITools.showDateTimePicker(context,
              minTime: DateTime.parse('1900-01-01'),
              onConfirm: (sqfSelectedDate) {
            txtUpdatedAt.text = UITools.convertDate(sqfSelectedDate);
            txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
            setState(() {
              final d = DateTime.tryParse(txtUpdatedAt.text) ??
                  sales.updatedAt ??
                  DateTime.now();
              sales.updatedAt = DateTime(sqfSelectedDate.year,
                      sqfSelectedDate.month, sqfSelectedDate.day)
                  .add(Duration(
                      hours: d.hour, minutes: d.minute, seconds: d.second));
            });
          },
              currentTime: DateTime.tryParse(txtUpdatedAt.text) ??
                  sales.updatedAt ??
                  DateTime.now()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter UpdatedAt';
            }
            return null;
          },
          controller: txtUpdatedAt,
          decoration: InputDecoration(labelText: 'UpdatedAt'),
        ),
      ),
      Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () => UITools.showDateTimePicker(context,
                onConfirm: (sqfSelectedDate) {
              txtTimeForUpdatedAt.text = UITools.convertTime(sqfSelectedDate);
              setState(() {
                final d = DateTime.tryParse(txtUpdatedAt.text) ??
                    sales.updatedAt ??
                    DateTime.now();
                sales.updatedAt = DateTime(d.year, d.month, d.day).add(Duration(
                    hours: sqfSelectedDate.hour,
                    minutes: sqfSelectedDate.minute,
                    seconds: sqfSelectedDate.second));
                txtUpdatedAt.text = UITools.convertDate(sales.updatedAt!);
              });
            },
                currentTime: DateTime.tryParse(
                        '${UITools.convertDate(DateTime.now())} ${txtTimeForUpdatedAt.text}') ??
                    sales.updatedAt ??
                    DateTime.now()),
            controller: txtTimeForUpdatedAt,
            decoration: InputDecoration(labelText: 'time'),
          ))
    ]);
  }

  Container saveButton() {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(95, 66, 119, 1.0),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  void save() async {
    final _date = DateTime.tryParse(txtDate.text);
    var _createdAt = DateTime.tryParse(txtCreatedAt.text);
    final _createdAtTime = DateTime.tryParse(txtTimeForCreatedAt.text);
    if (_createdAt != null && _createdAtTime != null) {
      _createdAt = _createdAt.add(Duration(
          hours: _createdAtTime.hour,
          minutes: _createdAtTime.minute,
          seconds: _createdAtTime.second));
    }
    var _updatedAt = DateTime.tryParse(txtUpdatedAt.text);
    final _updatedAtTime = DateTime.tryParse(txtTimeForUpdatedAt.text);
    if (_updatedAt != null && _updatedAtTime != null) {
      _updatedAt = _updatedAt.add(Duration(
          hours: _updatedAtTime.hour,
          minutes: _updatedAtTime.minute,
          seconds: _updatedAtTime.second));
    }

    sales
      ..ItemId = _selectedItemId
      ..ClientId = _selectedClientId
      ..BankId = _selectedBankId
      ..quantity = int.tryParse(txtQuantity.text)
      ..date = _date
      ..revenue = double.tryParse(txtRevenue.text)
      ..info = txtInfo.text
      ..createdAt = _createdAt
      ..updatedAt = _updatedAt;
    await sales.save();
    if (sales.saveResult!.success) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(sales.saveResult.toString(),
          title: 'save Sale Failed!', callBack: () {});
    }
  }
}
