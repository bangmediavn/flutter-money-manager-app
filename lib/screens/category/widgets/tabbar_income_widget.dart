import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../db/functions/category/category_db.dart';
import '../../../db/models/category/category_model.dart';

class TabBarIncomeWidget extends StatelessWidget {
  const TabBarIncomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(70,70,70,1),
      child: ValueListenableBuilder(
          valueListenable: CategoryDb.instance.incomeCategoryList,
          builder: (BuildContext ctx, List<CategoryModel> incomeList, Widget? _) {
            final incomeList1 = incomeList.reversed.toList();
            return ListView.separated(
                itemBuilder: (BuildContext ctx, int index) {
                  final incomeCategory = incomeList1[index];
                  final id = int.parse(incomeCategory.id);
                  final timeStamp = DateTime.fromMillisecondsSinceEpoch(id);
                  final date = getTransactionDate(timeStamp);
                  return Card(
                    color: const Color.fromRGBO(60,60,60,1),
                    margin: const EdgeInsets.fromLTRB(4, 5, 4, 0),
                    elevation: 1,
                    child: ListTile(
                      leading: Transform.rotate(

                        angle: -math.pi /4,
                        child: const CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 30,
                          child: Icon(
                              Icons.arrow_downward,
                            color: Colors.white,
                            size: 30,
                          )
                        ),
                      ),

                      title: Text(
                          incomeCategory.name,
                        style: const TextStyle(
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white
                          ,
                        ),
                      ),
                      subtitle: const Text(
                        'Income',
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
                              CategoryDb.instance
                                  .onDeleteCategory(incomeCategory.id);
                            },
                            icon: const Icon(
                                Icons.close,
                              color: Colors.blueGrey,
                            )),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext ctx, int index) {
                  return const SizedBox();
                },
                itemCount: incomeList.length);
          }),
    );
  }

  String getTransactionDate(value) {
    return DateFormat(' dd\nMMM').format(value);
  }
}
