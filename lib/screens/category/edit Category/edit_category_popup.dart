import 'package:flutter/material.dart';

import '../../../db/db_category/catergory_db.dart';
import '../../../models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showEditCategoryPopup(BuildContext context) async {
  final nameEditingController = TextEditingController();
 
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text(
            'Edit category',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: nameEditingController,
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Category name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: const [
                  RadioButton(
                    title: 'income',
                    type: CategoryType.income,
                  ),
                  RadioButton(
                    title: 'expense',
                    type: CategoryType.expense,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () async {
                  final name = nameEditingController.text;
                  if (name.isEmpty) {
                    return;
                  }
                  final _type = selectedCategoryNotifier.value;

                  final category = CategoryModel(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    name: name,
                    type: _type,
                  );

                  await CategoryDB.instance.insertCategory(category);
                  await CategoryDB.instance.refreshUI();
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (
              BuildContext ctx,
              CategoryType newCategory,
              Widget? _,
            ) {
              return Radio<CategoryType>(
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategoryNotifier.value = value;
                  selectedCategoryNotifier.notifyListeners();
                },
              );
            }),
        Text(title),
      ],
    );
  }
}