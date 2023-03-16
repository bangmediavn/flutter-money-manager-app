import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/functions/category/category_db.dart';
import 'package:money_manager/db/functions/transaction/transaction_db.dart';
import 'dart:math' as math;
import 'package:money_manager/db/models/category/category_model.dart';

class WidgetList extends StatelessWidget {
  ValueNotifier notifier;
  bool isTransaction;

   WidgetList({
     Key? key,
     required this.notifier,
     required this.isTransaction,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: notifier,
        builder: (BuildContext ctx, list, Widget? _) {
          final list1 = list.reversed.toList();
          return ListView.separated(
              itemBuilder: (BuildContext ctx, int index) {
                final value = list1[index];
                String date = '';
                isTransaction ?  date = getTransactionDate(value.dateTime) : null;
                return Padding(
                    padding: const EdgeInsets.fromLTRB(4,5, 4,0),
                  child: Slidable(
                    key: Key(value.id!),
                    startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            key: Key(value.id!),
                            borderRadius: const  BorderRadius.all(Radius.circular(5)),
                            onPressed: (ctx){
                              isTransaction
                                  ? TransactionDb.instance.onDeleteTransaction(value)
                                  : CategoryDb.instance.onDeleteCategory(value.id);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ]),
                    child: Card(
                      color: const Color.fromRGBO(60,60,60,1),
                      margin: const EdgeInsets.symmetric(horizontal:4, vertical: 0),
                      elevation: 1,
                      child: ListTile(
                        leading: Transform.rotate(

                          angle: value.categoryType == CategoryType.income ? -math.pi /4 : math.pi/4,
                          child:  CircleAvatar(
                              backgroundColor: value.categoryType == CategoryType.income
                                  ? Colors.green
                                  : Colors.red,
                              radius: 30,
                              child:  Icon( value.categoryType == CategoryType.income ?
                                Icons.arrow_downward : Icons.arrow_upward,
                                color: Colors.white,
                                size: 30,
                              )
                          ),
                        ),

                        title: Text(
                          value.name,
                          style: const TextStyle(
                            letterSpacing: 1.1,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white
                            ,
                          ),
                        ),
                        subtitle:  Text(
                          date.isNotEmpty ? date : value.categoryType == CategoryType.income
                              ? 'Income'
                              : 'Expense',

                          style:  const TextStyle(
                            letterSpacing: 1.1,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white
                            ,
                          ),
                        ),

                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext ctx, int index) {
                return const SizedBox();
              },
              itemCount: list1.length);
        }
    );
  }
  String getTransactionDate(value) {
    return DateFormat('dd-MM-yyyy').format(value);
  }
}
