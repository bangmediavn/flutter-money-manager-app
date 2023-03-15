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
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: type,
              groupValue: newType,
              fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
              onChanged: (value){
                if(value == null){
                  return;
                }
                selectedCategoryNotifier.value = value;
                selectedCategoryNotifier.notifyListeners();

              }),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
        ],);
      },
    );
  }
}
