import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../db/db_transaction/income_and_expense.dart';
import '../../db/db_transaction/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../category/screen_category.dart';
import '../pie_chart/overAll/graph_over_view.dart';
import '../pie_chart/screen_pie_chart.dart';
import '../settings_screen/settings_screen.dart';
import '../transacation/add/screen_add_transaction.dart';
import '../transacation/search & view all transaction/screen_view_all_and_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      incomeAndExpense();
      overViewGraphNotifier.value =
          TransactionDB.instance.transactionListNotifier.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshTransAndCat();
    return Scaffold(
      backgroundColor: const Color.fromARGB(230, 72, 151, 148),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: const Icon(Icons.menu),
                          onTap: () {
                            return showMenuModalBottomSheet(context);
                          },
                        ),
                        const SizedBox(
                          width: 210,
                        ),
                        SizedBox(
                          width: 103,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'MONEY FI',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                  ),

                  //continer
                  Container(
                    width: 340,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 245, 229, 229),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          // color: Colors.lightBlue,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: totalBalance,
                                builder: (BuildContext ctx, dynamic value,
                                    Widget? child) {
                                  return Column(
                                    children: [
                                      totalBalance.value >= 0
                                          ? const Text(
                                              'Balance',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            )
                                          : const Text(
                                              'Empty',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                      totalBalance.value >= 0
                                          ? Text(
                                              '${totalBalance.value.abs().toString()} ₹',
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w800,
                                                color: Color.fromARGB(
                                                    210, 0, 7, 72),
                                              ),
                                            )
                                          : Text(
                                              '-${totalBalance.value.abs().toString()} ₹',
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w800,
                                                color: Color.fromARGB(
                                                    255, 57, 7, 3),
                                              ),
                                            )
                                    ],
                                  );
                                },
                                //
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ValueListenableBuilder(
                              valueListenable: incomeTotal,
                              builder: (BuildContext context, dynamic value,
                                  Widget? child) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 80,
                                        width: 130,
                                        child: Card(
                                          color: const Color.fromARGB(
                                              230, 72, 151, 148),
                                          elevation: 10,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                    'income',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 243, 216, 216),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '${incomeTotal.value} ₹',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 243, 216, 216),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ValueListenableBuilder(
                              valueListenable: expenseTotal,
                              builder: (BuildContext context, dynamic value,
                                  Widget? child) {
                                return Container(
                                  height: 80,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Card(
                                    color:
                                        const Color.fromARGB(230, 72, 151, 148),
                                    elevation: 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              'Expense',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 243, 216, 216),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${expenseTotal.value} ₹',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 243, 216, 216),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 70,
                            width: 120,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(230, 72, 151, 148),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) => const PieChartAll()),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.pie_chart,
                                    color: Color.fromARGB(255, 243, 216, 216),
                                  ),
                                  Text(
                                    'Statistics',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 243, 216, 216),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // color: Colors.amber,
                          ),

                          SizedBox(
                            height: 70,
                            width: 120,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(230, 72, 151, 148),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                showSearch(
                                    context: context, delegate: SearchWidget());
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.view_carousel_outlined,
                                    color: Color.fromARGB(255, 243, 216, 216),
                                  ),
                                  Text(
                                    'Veiw All',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 243, 216, 216),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // color: Colors.amber,
                          ),

                          // color: Colors.pink,
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 40,
                            child: Text(
                              'Recent Transactions',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 243, 216, 216),
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            // color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                // color: Colors.amber,
                height: 370,
                child: ValueListenableBuilder(
                  valueListenable:
                      TransactionDB.instance.transactionListNotifier,
                  builder: (ctx, newList, Widget? _) {
                    return newList.isNotEmpty
                        ? ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (ctx, index) {
                              final value = newList[index];
                              return Slidable(
                                key: Key(value.id!),
                                child: Card(
                                  color: value.type == CategoryType.income
                                      ? const Color.fromARGB(230, 72, 151, 148)
                                      : const Color.fromARGB(255, 244, 106, 97),
                                  elevation: 5,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            255, 243, 216, 216),
                                        radius: 30,
                                        child: Text(
                                          parseDate(value.date),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      title: Text(
                                        value.category.name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        value.purpose,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      trailing: Text(
                                        '₹${value.amount}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: newList.length,
                          )
                        : SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 130),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'No Data Transactions Found!!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 245, 229, 229),
          label: const Text(
            'Add Transaction',
            style: TextStyle(
                color: Color.fromARGB(230, 72, 151, 148),
                fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => const ScreenAddTransaction()),
              ),
            );
          },
          icon: const Icon(
            Icons.add,
            color: Color.fromARGB(230, 72, 151, 148),
          ),
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
    // return '${date.day}\n${date.month}';
  }

  void showMenuModalBottomSheet(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          width: double.infinity,
          height: 160,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Color.fromARGB(230, 72, 151, 148),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: ((context) => const CategoryScreen()),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.category,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Category",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: ((context) => const ScreenSettings()),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Settings",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
