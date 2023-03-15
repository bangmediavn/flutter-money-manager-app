import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/db/models/category/category_model.dart';
import 'package:money_manager/db/models/transaction/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<List<TransactionModel>> getTransaction();
  Future<void> insertTransaction(TransactionModel transaction);
  Future<void> onDeleteTransaction(TransactionModel transaction);
}


class TransactionDb extends TransactionDbFunctions{
  //singleton
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();
  factory TransactionDb(){
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> transactionSubListNotifier = ValueNotifier([]);

  @override
  Future<List<TransactionModel>> getTransaction() async{
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }

  @override
  Future<void> insertTransaction(TransactionModel transaction) async{
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.put(transaction.id, transaction);
    if (transaction.categoryType == CategoryType.income) {
      addIncome(transaction);
    }else {
      addExpanse(transaction);
    }
    refreshUi();
  }

  @override
  Future<void> onDeleteTransaction(TransactionModel transaction) async{
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    if (transaction.categoryType == CategoryType.income) {
      subtractIncome(transaction);
    }else {
      subtractExpense(transaction);
    }
    await db.delete(transaction.id);
    refreshUi();

  }

  Future<void> refreshUi() async {
    final list = await getTransaction();
    List<TransactionModel> list1  = list.reversed.toList();

    transactionSubListNotifier.value.clear();
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    list1.length >=10 ? transactionSubListNotifier.value.addAll(list1.sublist(0, 10)) :
      transactionSubListNotifier.value.addAll(list1.sublist(0, list.length));

    transactionSubListNotifier.notifyListeners();
    transactionListNotifier.notifyListeners();

  }
  Future<void> addIncome(TransactionModel model) async{
    final sharedPref = await SharedPreferences.getInstance();

    final  amount = sharedPref.getDouble('income_amount');

    if (  amount == null) {
      await sharedPref.setDouble('income_amount', model.amount.toDouble());
    }else  {
     await sharedPref.setDouble('income_amount', amount +  model.amount.toDouble());
    }
  }Future<void> addExpanse(TransactionModel model) async{
    final sharedPref = await SharedPreferences.getInstance();

    final  amount = sharedPref.getDouble('expense_amount');
    if (  amount == null) {
      await sharedPref.setDouble('expense_amount', model.amount.toDouble());
    }else  {
      await sharedPref.setDouble('expense_amount', amount +  model.amount.toDouble());
    }
  }

  Future<void> subtractIncome(TransactionModel model) async{
    final sharedPref = await SharedPreferences.getInstance();

    final  amount = sharedPref.getDouble('income_amount');

    if (  amount != null) {
      await sharedPref.setDouble('income_amount', amount -  model.amount.toDouble());
    }
  }Future<void> subtractExpense(TransactionModel model) async{
    final sharedPref = await SharedPreferences.getInstance();

    final  amount = sharedPref.getDouble('expense_amount');
    if (  amount != null) {
      await sharedPref.setDouble('expense_amount', amount -  model.amount.toDouble());
    }

  }
}