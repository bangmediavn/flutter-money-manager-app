import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/db/models/category/category_model.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime dateTime;
  @HiveField(3)
  final CategoryType categoryType;
  @HiveField(4)
  final CategoryModel category;
  @HiveField(5)
  String? id;

  TransactionModel({
    required this.purpose,
    required this.amount,
    required this.dateTime,
    required this.categoryType,
    required this.category,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  String toString() {
    return "<TransactionModel>{"
        "id: $id, purpose: $purpose, amount: $amount, date_time: $dateTime, "
        "category_type: $categoryType, category: $category}";
  }
}
