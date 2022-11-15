import 'package:flutter/material.dart';

class CustomerTab extends StatefulWidget {
  const CustomerTab({super.key});

  @override
  State<CustomerTab> createState() => _CustomerTabState();
}

class _CustomerTabState extends State<CustomerTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
    );
  }
}
