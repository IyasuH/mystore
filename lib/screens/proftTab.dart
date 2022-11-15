import 'package:flutter/material.dart';

class ProfitTab extends StatefulWidget {
  const ProfitTab({super.key});

  @override
  State<ProfitTab> createState() => _ProfitTabState();
}

class _ProfitTabState extends State<ProfitTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit'),
      ),
    );
  }
}
