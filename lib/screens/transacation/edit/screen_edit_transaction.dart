import 'package:flutter/material.dart';
import 'package:money_fi/db/db_category/catergory_db.dart';
import 'package:money_fi/models/transaction/transaction_model.dart';

import '../../../db/db_transaction/transaction_db.dart';
import '../../../models/category/category_model.dart';
import '../../category/screen_category.dart';
import '../../home/home_screen.dart';

class ScreenEditTransaction extends StatefulWidget {
  const ScreenEditTransaction({super.key, required this.transactionObj});
  final TransactionModel transactionObj;

  @override
  State<ScreenEditTransaction> createState() => _ScreenEditTransactionState();
}

class _ScreenEditTransactionState extends State<ScreenEditTransaction> {
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CategoryModel? selectedCategoryModel;

  String? categoryID;

  TextEditingController purposeTextEditingController = TextEditingController();
  TextEditingController amountTextEditingController = TextEditingController();
  TextEditingController notesTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //
    selectedCategoryType = widget.transactionObj.type;
    purposeTextEditingController =
        TextEditingController(text: widget.transactionObj.purpose);
    amountTextEditingController =
        TextEditingController(text: widget.transactionObj.amount.toString());
    notesTextEditingController =
        TextEditingController(text: widget.transactionObj.notes);
    selectedCategoryModel = widget.transactionObj.category;
    selectedDate = widget.transactionObj.date;
    categoryID = selectedCategoryModel!.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          title: const Text(
            'Edit Transactions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Logo
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/images/ic_launcher.png'),
                ),
                const SizedBox(
                  height: 20,
                ),

                //Selected category income or expense

                SizedBox(
                  width: 400,
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
                            const Text('Income'),
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
                            const Text('Expense'),
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
                      width: 290, //350,
                      child: Card(
                        elevation: 3,
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton(
                              hint: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Select Category'),
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
                    SizedBox(
                      height: 65,
                      width: 60,
                      child: Card(
                        elevation: 3,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) =>
                                    const CategoryScreen())));
                            // showCategoryPopup(context);
                          },
                          icon: const Icon(Icons.add),
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
                  width: 400,
                  child: Card(
                    elevation: 3,
                    child: TextButton.icon(
                      onPressed: () async {
                        final selectedDateTemp = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDateTemp == null) {
                          return;
                        } else {
                          print(selectedDateTemp.toString());
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
                    onPressed: () {
                      addTransaction();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: ((context) => const HomeScreen()),
                        ),
                      );
                    },
                    child: const Text('Done'),
                  ),
                ),
              ],
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
        id: widget.transactionObj.id);

    TransactionDB.instance.addTransaction(model);
    TransactionDB.instance.refresh();
  }
}