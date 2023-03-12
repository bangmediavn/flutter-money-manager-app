import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:money_manager/db/functions/transaction/transaction_db.dart';
import 'package:money_manager/db/models/category/category_model.dart';
import 'package:money_manager/db/models/transaction/transaction_model.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifier,
      builder:
          (BuildContext ctx, List<TransactionModel> transactions, Widget? _) {
        final list = transactions.reversed.toList();
        return ListView.separated(
          itemBuilder: (BuildContext ctx, int index) {
            final transaction = list[index];
            final date = getTransactionDate(transaction.dateTime);
            return Card(
              margin: const EdgeInsets.fromLTRB(3, 3, 3, 0),
              elevation: 1,
              child: ListTile(
                leading: Transform.rotate(
                  angle: (transaction.categoryType == CategoryType.income ? -math.pi /4 : math.pi/4),
                  child: CircleAvatar(
                    backgroundColor:
                        (transaction.categoryType == CategoryType.income
                            ? Colors.green
                            : Colors.red),
                    radius: 30,
                    child: (
                        transaction.categoryType == CategoryType.income ?
                        const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                          size: 30,
                        ) :  const Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 30,
                        )
                    )
                  ),
                ),
                title: Text(
                    transaction.purpose,
                    style:  const TextStyle(
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black87
                      ,
                    ),
                  ),

                subtitle: Text(
                    date,
                    style:  const TextStyle(
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black54
                      ,
                    ),
                  ),

                trailing: SizedBox(
                  width: 130,
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        transaction.amount.toString(),
                        style:  TextStyle(
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: ( transaction.categoryType == CategoryType.income
                              ? Colors.green
                              : Colors.red)
                          ,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          iconSize: 25,
                            onPressed: (){
                            TransactionDb.instance.onDeleteTransaction(transaction.id!);
                            },
                            icon: const Icon(
                                Icons.delete,
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            );
          },
          separatorBuilder: (BuildContext ctx, int index) {
            return const SizedBox();
          },
          itemCount: transactions.length,
        );
      },
    );
  }

  String getTransactionDate(value) {
    return DateFormat('dd-MM-yyyy').format(value);
  }
}
