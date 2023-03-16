import 'package:flutter/material.dart';

import '../../../db/models/category/category_model.dart';

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  ValueNotifier<CategoryType> categoryTypeNotifier;
  RadioButton({
    Key? key,
    required this.title,
    required this.type,
    required this.categoryTypeNotifier
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: categoryTypeNotifier,
      builder: (BuildContext ctx,CategoryType newType, Widget? _){
        return Row(children: [
          Radio<CategoryType>(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: type,
              groupValue: newType,
              activeColor: Colors.white,
              fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
              onChanged: (value){
                if(value == null){
                  return;
                }
                categoryTypeNotifier.value = value;
                categoryTypeNotifier.notifyListeners();

              }),
          Text(title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.1,
              fontSize: 14,
            ),
          ),
        ],);
      },
    );
  }
}
