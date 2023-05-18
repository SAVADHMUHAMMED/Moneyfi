import 'package:flutter/material.dart';
import 'package:money_fi/screens/category/Add%20category%20pop%20up/category_add_popup.dart';

import '../../db/db_category/catergory_db.dart';
import 'Income category/income_category_list.dart';
import 'expense category/expnse_category_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(230, 72, 151, 148),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 50,
            ),
            Container(
              height: 50,
              width: double.infinity,
              // color: Colors.red,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 70,
                  ),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            content: const Text(
                              'Clear all Categories !?\n(Income and Expense)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: (() {
                                      Navigator.of(context).pop();
                                    }),
                                    child: const Text(
                                      'No',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (() {
                                      CategoryDB.instance.deleteAllCategory();
                                      Navigator.of(context).pop();
                                    }),
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                      );
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 60,
              // color: Colors.amber,
            ),
            TabBar(
              controller: tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(
                  text: 'Income',
                ),
                Tab(
                  text: 'Expense',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: const [
                IncomeCategoryList(),
                ExpenseCategoryList(),
              ]),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(230, 72, 151, 148),
        child: const Icon(Icons.add),
        onPressed: () {
          print('add category');
          showAddCategoryPopup(context);
        },
      ),
    );
  }
}
