import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/functions/transaction/transaction_db.dart';
import 'package:money_manager/screens/category/widgets/widget_tabbar_list.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetList(
        notifier: TransactionDb.instance.transactionListNotifier,
        isTransaction: true
    );
  }
}
