import 'package:flutter/material.dart';

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
    companyName: 'SubZeroSoftaware',
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
