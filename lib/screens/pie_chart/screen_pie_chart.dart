import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '../../db/db_transaction/transaction_db.dart';
import 'expenses/expense_chart.dart';
import 'income/income_chart.dart';
import 'overAll/graph_over_view.dart';

class PieChartAll extends StatefulWidget {
  const PieChartAll({super.key});

  @override
  State<PieChartAll> createState() => _PieChartAllState();
}

class _PieChartAllState extends State<PieChartAll> {
  String dateFilterTitle = "All";
  @override
  void initState() {
    overViewGraphNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(230, 72, 151, 148),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(230, 72, 151, 148),
        centerTitle: true,
        title: const Text(
          'Statistics',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<int>(
                color: Colors.white,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: Row(
                    children: const [
                      Text(''),
                      Icon(
                        Icons.sort,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: const Text(
                      'All',
                      style: TextStyle(
                        color: Color.fromARGB(230, 72, 151, 148),
                      ),
                    ),
                    onTap: () {
                      overViewGraphNotifier.value =
                          TransactionDB.instance.transactionListNotifier.value;
                      setState(() {
                        dateFilterTitle = "All";
                      });
                    },
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: const Text(
                      'Today',
                      style: TextStyle(
                        color: Color.fromARGB(230, 72, 151, 148),
                      ),
                    ),
                    onTap: () {
                      overViewGraphNotifier.value =
                          TransactionDB.instance.transactionListNotifier.value;
                      overViewGraphNotifier.value = overViewGraphNotifier.value
                          .where((element) =>
                              element.date.day == DateTime.now().day &&
                              element.date.month == DateTime.now().month &&
                              element.date.year == DateTime.now().year)
                          .toList();
                      setState(() {
                        dateFilterTitle = "Today";
                      });
                    },
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: const Text(
                      'Yesterday',
                      style: TextStyle(
                        color: Color.fromARGB(230, 72, 151, 148),
                      ),
                    ),
                    onTap: () {
                      overViewGraphNotifier.value =
                          TransactionDB.instance.transactionListNotifier.value;
                      overViewGraphNotifier.value = overViewGraphNotifier.value
                          .where((element) =>
                              element.date.day == DateTime.now().day - 1 &&
                              element.date.month == DateTime.now().month &&
                              element.date.year == DateTime.now().year)
                          .toList();
                      setState(() {
                        dateFilterTitle = "Yesterday";
                      });
                    },
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: const Text(
                      'This Month',
                      style: TextStyle(
                        color: Color.fromARGB(230, 72, 151, 148),
                      ),
                    ),
                    onTap: () {
                      overViewGraphNotifier.value =
                          TransactionDB.instance.transactionListNotifier.value;

                      overViewGraphNotifier.value = overViewGraphNotifier.value
                          .where((element) =>
                              element.date.month == DateTime.now().month &&
                              element.date.year == DateTime.now().year)
                          .toList();
                      setState(() {
                        dateFilterTitle = "Month";
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(0),
            ),
            Expanded(
                child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: <Widget>[
                  Container(
                    color: const Color.fromARGB(230, 72, 151, 148),
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: ButtonsTabBar(
                        backgroundColor: const Color.fromARGB(230, 72, 151, 148),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 40),
                        tabs: const [
                          Tab(
                            iconMargin: EdgeInsets.all(30),
                            text: 'All',
                          ),
                          Tab(
                            iconMargin: EdgeInsets.all(30),
                            text: 'Income',
                          ),
                          Tab(
                            iconMargin: EdgeInsets.all(30),
                            text: 'Expense',
                          ),
                        ]),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        GraphOverView(),
                        IncomeChart(),
                        ExpenseChart()
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
