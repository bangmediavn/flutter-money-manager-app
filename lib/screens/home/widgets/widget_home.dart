import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/screens/home/widgets/widget_card.dart';
import 'package:money_manager/screens/home/widgets/widget_list_home.dart';

class WidgetHome extends StatelessWidget {
  const WidgetHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children:  const [
        WidgetCard(),
        Expanded(child: WidgetListHome()),
      ],
    );
  }
}
