import 'package:flutter/material.dart';

import '../../../db/models/category/category_model.dart';
import 'category_add_popup.dart';

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  RadioButton({Key? key, required this.title, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedCategoryNotifier,
      builder: (BuildContext ctx,CategoryType newType, Widget? _){
        return Row(children: [
          Radio<CategoryType>(
              value: type,
              groupValue: newType,
              onChanged: (value){
                if(value == null){
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();

              }),
          Text(title),
        ],);
      },
    );
  }
}
