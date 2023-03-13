import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../../../db/functions/category/category_db.dart';
import '../../../db/models/category/category_model.dart';

class TabBarExpenseWidget extends StatelessWidget {
  TabBarExpenseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(70,70,70,1),
      child: ValueListenableBuilder(
          valueListenable: CategoryDb.instance.expenseCategoryList,
          builder: (BuildContext ctx, List<CategoryModel> expenseList, Widget? _) {
            final expenseList1 = expenseList.reversed.toList();
            return ListView.separated(
                itemBuilder: (BuildContext ctx, int index) {
                  final expenseCategory = expenseList1[index];
                  return Card(
                    color: const Color.fromRGBO(60,60,60,1),
                    margin: const EdgeInsets.fromLTRB(4, 5, 4, 0),
                    elevation: 1,
                    child: ListTile(
                      leading: Transform.rotate(

                        angle: math.pi /4,
                        child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 30,
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 30,
                            )
                        ),
                      ),
                      title: Text(
                          expenseCategory.name,
                        style: const TextStyle(
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: const Text(
                        'Expense',
                        style:  TextStyle(
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white
                          ,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 30,
                        child: IconButton(
                            onPressed: () {
                              CategoryDb.instance.onDeleteCategory(expenseCategory.id);
                            }, icon: const Icon(
                            Icons.close,
                            color: Colors.blueGrey
                        )),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext ctx, int index) {
                  return const SizedBox();
                },
                itemCount: expenseList.length);
          }),
    );
  }
}
