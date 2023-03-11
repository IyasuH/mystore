import 'package:flutter/material.dart';
import 'package:mystore/Widgets/homePageMore.dart';
import 'package:mystore/screens/expenseTab.dart';
import 'package:mystore/screens/salesTab.dart';
import 'package:mystore/screens/settingTab.dart';

import '../Widgets/homePageMainContainer.dart';
import '../models/clients.dart';
import '../models/model.dart';
import '../models/weeklyData.dart';
import 'customerTab.dart';
import 'proftTab.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Client> topClientEver = [];
  List<Personal> personalData = [];
  loadTopClientData() async {
    personalData = await Personal().select().orderBy("id").toList();
    topClientEver =
        await Client().select().orderByDesc("totPurchase").top(3).toList();
    setState(() {});
  }

  @override
  void initState() {
    loadTopClientData();
    super.initState();
  }

  // _HomeTabState();
  Color salesPrimaryColor = const Color.fromRGBO(0, 188, 212, 1);
  Color salesSecondaryColor = const Color.fromARGB(30, 0, 169, 181);

  Color profitPrimaryColor = const Color.fromARGB(255, 38, 255, 0);
  Color profitSecondaryColor = const Color.fromARGB(30, 19, 224, 0);

  Color expensePrimaryColor = const Color.fromARGB(255, 255, 20, 110);
  Color expenseSecondaryColor = const Color.fromARGB(30, 194, 0, 91);

  Color clientsPrimaryColor = const Color.fromARGB(255, 234, 164, 45);
  Color clientsSecondaryColor = const Color.fromARGB(30, 203, 145, 0);

  _salesContainer() {
    return homeMainContainer(
      primaryColor: salesPrimaryColor,
      secondaryColor: salesSecondaryColor,
      chartName: 'Sales',
      secondaryHeader: 'Toda\'s Sales',
      primaryQuantity: '\$500',
      SplinChartData: salesData,
      CicularBarVal: 37,
    );
  }

  _salesRouteTo() {
    return homePageMore(
      routeToPage: SalesTab(),
      primaryColor: salesPrimaryColor,
      secondaryColor: salesSecondaryColor,
      chartName: 'Sales',
    );
  }

  _profitContainer() {
    return homeMainContainer(
      primaryColor: profitPrimaryColor,
      secondaryColor: profitSecondaryColor,
      chartName: 'Profit',
      secondaryHeader: 'Toda\'s Profit',
      primaryQuantity: '\$120',
      SplinChartData: profitData,
      CicularBarVal: 37,
    );
  }

  _profitRouteTo() {
    return homePageMore(
      routeToPage: ProfitTab(),
      primaryColor: profitPrimaryColor,
      secondaryColor: profitSecondaryColor,
      chartName: 'Profit',
    );
  }

  _expenseContainer() {
    return homeMainContainer(
      primaryColor: expensePrimaryColor,
      secondaryColor: expenseSecondaryColor,
      chartName: 'Expenses',
      secondaryHeader: 'Today\'s Expense',
      primaryQuantity: '\$36',
      SplinChartData: expenseData,
      CicularBarVal: 18,
    );
  }

  _expenseRouteTo() {
    return homePageMore(
      routeToPage: ExpensesTab(),
      primaryColor: expensePrimaryColor,
      secondaryColor: expenseSecondaryColor,
      chartName: 'Expenses',
    );
  }

  _clientsContainer() {
    // special condition for this is that it has topclients card too
    return homeMainContainer(
      primaryColor: clientsPrimaryColor,
      secondaryColor: clientsSecondaryColor,
      chartName: 'Clients',
      secondaryHeader: 'Today\'s Clients',
      primaryQuantity: '18',
      SplinChartData: customerData,
      CicularBarVal: 81,
    );
  }

  _clientsRouteTo() {
    return homePageMore(
      routeToPage: CustomerTab(),
      primaryColor: clientsPrimaryColor,
      secondaryColor: clientsSecondaryColor,
      chartName: 'Clients',
    );
  }

  // container that returns top clients
  topclients() {
    return Container(
      color: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Top Clients',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Client name',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Amount',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 1.5,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            SizedBox(
              height: 140,
              child: ListView.builder(
                itemCount: topClientEver.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    // padding: EdgeInsets.only(top: 3),
                    height: 60,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1.5,
                          color: Color.fromARGB(80, 203, 145, 0),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              topClientEver[index].name!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              topClientEver[index].companyName!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              topClients[index].change == 1
                                  ? const Icon(Icons.arrow_drop_up_sharp,
                                      color: Colors.green, size: 32)
                                  : const Icon(Icons.arrow_drop_down_sharp,
                                      color: Colors.red, size: 32),
                              Text(
                                '\$ ${topClientEver[index].totPurchase}',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 234, 164, 45),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 25, 13, 15),
            child: Row(
              // ignore: prefer_const_constructors
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // since I think loading name by specifci num making error (range not found)
                      // till I figure it out
                      // '${personalData[0].name}',
                      'Hi Eyasu',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                        wordSpacing: 1.8,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    // ignore: prefer_const_constructors
                    Text(
                      'Welcome Back!',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green,
                          blurRadius: 7,
                          blurStyle: BlurStyle.outer,
                        )
                      ]),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingTab()),
                        );
                      },
                      icon: const Icon(
                        size: 30,
                        Icons.person,
                        // color: Color.fromARGB(255, 80, 220, 63),
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            height: 615,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: ListView(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 21,
                      ),
                      _salesContainer(),
                      _salesRouteTo(),
                      const SizedBox(
                        height: 21,
                      ),
                      _profitContainer(),
                      _profitRouteTo(),
                      const SizedBox(
                        height: 21,
                      ),
                      _expenseContainer(),
                      _expenseRouteTo(),
                      const SizedBox(
                        height: 21,
                      ),
                      _clientsContainer(),
                      topclients(),
                      _clientsRouteTo(),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
