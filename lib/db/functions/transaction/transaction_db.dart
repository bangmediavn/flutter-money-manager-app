import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/db/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<List<TransactionModel>> getTransaction();
  Future<void> insertTransaction(TransactionModel transaction);
  Future<void> onDeleteTransaction(String id);
}


class TransactionDb extends TransactionDbFunctions{
  //singleton
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();
  factory TransactionDb(){
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier = ValueNotifier([]);

  @override
  Future<List<TransactionModel>> getTransaction() async{
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }

  @override
  Future<void> insertTransaction(TransactionModel transaction) async{
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.put(transaction.id, transaction);
    refreshUi();
  }

  @override
  Future<void> onDeleteTransaction(String id) async{
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.delete(id);
    refreshUi();

  }

  Future<void> refreshUi() async {
    final list = await getTransaction();
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();

  }
}