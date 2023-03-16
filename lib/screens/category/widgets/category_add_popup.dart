import 'package:flutter/material.dart';
import 'package:money_manager/db/models/category/category_model.dart';
import 'package:money_manager/screens/category/widgets/radio_button_widget.dart';

import '../../../db/functions/category/category_db.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier = ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {

  final formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();

  showDialog(context: context, builder: (ctx){
    return SimpleDialog(
      backgroundColor: const Color.fromRGBO(68,68,68,1),
      title: const Text('Add Category', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: TextFormField(
              validator: (String? value){
                return (value == null || value.isEmpty ? 'Enter category name' : null);
              },
              controller: categoryNameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'Category name',
                border: OutlineInputBorder(
                    borderSide: BorderSide( color: Colors.white)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  )
                ),
                focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white
                    )
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red
                    )
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(child: RadioButton(title: 'Income',type: CategoryType.income, categoryTypeNotifier: selectedCategoryNotifier, )),
            Expanded(child: RadioButton(title: 'Expense',type: CategoryType.expense, categoryTypeNotifier: selectedCategoryNotifier)),
          ],),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: (){
                formKey.currentState?.validate();
                if (categoryNameController.text.isEmpty){
                  return;
                }
                final _name = categoryNameController.text;
                final _type = selectedCategoryNotifier.value;
                final category = CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _name,
                    categoryType: _type);

                CategoryDb.instance.insertCategory(category);
                Navigator.of(ctx).pop();
              },
              child: const Text('Add')),
        ),
      ],
    );
  });
}

