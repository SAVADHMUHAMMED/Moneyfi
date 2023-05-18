import 'package:flutter/material.dart';
import '../../../db/db_category/catergory_db.dart';
import '../../../db/db_transaction/transaction_db.dart';
import '../../../models/category/category_model.dart';
import '../../../models/transaction/transaction_model.dart';
import '../../category/Add category pop up/category_add_popup.dart';
import '../../home/home_screen.dart';

class ScreenAddTransaction extends StatefulWidget {
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? selectedDate = DateTime.now();
  CategoryType? selectedCategoryType;
  CategoryModel? selectedCategoryModel;

  String? categoryID;

  final _formKey = GlobalKey<FormState>();

  final purposeTextEditingController = TextEditingController();
  final amountTextEditingController = TextEditingController();
  final notesTextEditingController = TextEditingController();

  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return Scaffold(
        backgroundColor: const Color.fromARGB(230, 72, 151, 148),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(230, 72, 151, 148),
          title: const Text(
            'Add Transactions',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //Logo
                  const SizedBox(
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Selected category income or expense

                  SizedBox(
                    width: double.maxFinite,
                    child: Card(
                      elevation: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: CategoryType.income,
                                groupValue: selectedCategoryType,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCategoryType = CategoryType.income;
                                    categoryID = null;
                                  });
                                },
                              ),
                              const Text(
                                'Income',
                                style: TextStyle(
                                    color: Color.fromARGB(230, 72, 151, 148),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: CategoryType.expense,
                                groupValue: selectedCategoryType,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCategoryType = CategoryType.expense;
                                    categoryID = null;
                                  });
                                },
                              ),
                              const Text(
                                'Expense',
                                style: TextStyle(
                                    color: Color.fromARGB(230, 72, 151, 148),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 2,
                  ),

                  //category type Dropdown

                  Row(
                    children: [
                      SizedBox(
                        height: 65,
                        width: 280, //350,
                        child: Card(
                          elevation: 3,
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                hint: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Select Category',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(230, 72, 151, 148),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                value: categoryID,
                                items:
                                    (selectedCategoryType == CategoryType.income
                                            ? CategoryDB.instance
                                                .incomeCategoryListListener
                                            : CategoryDB.instance
                                                .expenseCategoryListListener)
                                        .value
                                        .map(
                                  (e) {
                                    return DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.name),
                                      onTap: () {
                                        selectedCategoryModel = e;
                                      },
                                    );
                                  },
                                ).toList(),
                                onChanged: (selectedValue) {
                                  // print(selectedValue);
                                  setState(() {
                                    categoryID = selectedValue;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 65,
                        width: 60,
                        child: Card(
                          elevation: 3,
                          child: IconButton(
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: ((context) => const CategoryScreen())));
                              showAddCategoryPopup(context);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Color.fromARGB(230, 72, 151, 148),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  //Calender select date

                  SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 3,
                      child: TextButton.icon(
                        onPressed: () async {
                          final selectedDateTemp = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 35)),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDateTemp == null) {
                            return;
                          } else {
                            // print(selectedDateTemp.toString());
                            setState(() {
                              selectedDate = selectedDateTemp;
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: Text(
                          selectedDate == null
                              ? 'Select Date'
                              : selectedDate!.toString().substring(0, 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  //purpose
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Your Purpose';
                          } else {
                            return null;
                          }
                        },
                        controller: purposeTextEditingController,
                        decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Purpose',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //amount
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Amount';
                          } else {
                            return null;
                          }
                        },
                        controller: amountTextEditingController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Amount',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 150,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter a note';
                            } else {
                              return null;
                            }
                          },
                          maxLines: 10,
                          controller: notesTextEditingController,
                          decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Notes',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //submit
                  SizedBox(
                    width: 500,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await addTransaction();
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('Transaction Saved')));
                        }

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: ((context) => const HomeScreen()),
                          ),
                        );
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                            color: Color.fromARGB(230, 72, 151, 148),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> addTransaction() async {
    final purposeText = purposeTextEditingController.text;
    final amountText = amountTextEditingController.text;
    final noteText = notesTextEditingController.text;
    if (purposeText.isEmpty) {
      return;
    }
    if (amountText.isEmpty) {
      return;
    }
    if (noteText.isEmpty) {
      return;
    }

    // if (categoryID == null) {
    //   return;
    // }

    if (selectedDate == null) {
      return;
    }

    if (selectedCategoryModel == null) {
      return;
    }
    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }

    // selectedDate
    // selectedCategoryType
    // categoryID

    final model = TransactionModel(
        purpose: purposeText,
        amount: parsedAmount,
        notes: noteText,
        date: selectedDate!,
        type: selectedCategoryType!,
        category: selectedCategoryModel!,
        id: DateTime.now().millisecondsSinceEpoch.toString());

    TransactionDB.instance.addTransaction(model);
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
  }
}
