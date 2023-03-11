import 'package:hive_flutter/hive_flutter.dart';

import '../../models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';
abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories ();
  Future<void> insertCategory(CategoryModel category);
  Future<void> onDeleteCategory(CategoryModel category);
}

class CategoryDb implements CategoryDbFunctions {
  @override
  Future<void> insertCategory(CategoryModel category) async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDb.add(category);
  }

  @override
  Future<List<CategoryModel>> getCategories() async{
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDb.values.toList();
  }

  @override
  Future<void> onDeleteCategory(CategoryModel category) async{

  }
}