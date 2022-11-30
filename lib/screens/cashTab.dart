import 'package:flutter/material.dart';

class CashTab extends StatefulWidget {
  const CashTab({super.key});

  @override
  State<CashTab> createState() => _CashTabState();
}

class _CashTabState extends State<CashTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 24, 13, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  height: 40,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: const Text(
                    'Deposit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  width: 120,
                  height: 40,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: const Text(
                    'Deposit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Container(
              height: 270,
              margin: const EdgeInsets.symmetric(vertical: 13),
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  height: 40,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: const Text(
                    'Deposit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  width: 120,
                  height: 40,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: const Text(
                    'Deposit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Container(
              height: 270,
              margin: const EdgeInsets.symmetric(vertical: 13),
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
