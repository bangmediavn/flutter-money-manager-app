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
              color: const Color.fromRGBO(60,60,60,1),
              margin: const EdgeInsets.fromLTRB(4, 5, 4, 0),
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
                      fontSize: 16,
                      color: Colors.white
                      ,
                    ),
                  ),

                subtitle: Text(
                    date,
                    style:  const TextStyle(
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white
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
                        style: const TextStyle(
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: ( Colors.white)
                          ,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: IconButton(
                          iconSize: 25,
                            onPressed: (){
                            TransactionDb.instance.onDeleteTransaction(transaction);
                            },
                            icon: const Icon(
                                Icons.close,
                              color: Colors.blueGrey,
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
