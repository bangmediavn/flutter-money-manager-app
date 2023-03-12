import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();

  Future<void> insertCategory(CategoryModel category);

  Future<void> onDeleteCategory(String id);
}

class CategoryDb implements CategoryDbFunctions {
  //singleton
  CategoryDb._internal();

  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel category) async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDb.put(category.id, category);
    refreshUi();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    print(categoryDb.values.toList());
    return categoryDb.values.toList();
  }

  @override
  Future<void> onDeleteCategory(String id) async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDb.delete(id);
    refreshUi();
  }

  Future<void> refreshUi() async {
    final allCategories = await getCategories();
    incomeCategoryList.value.clear();
    expenseCategoryList.value.clear();
    await Future.forEach(allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryList.value.add(category);
      } else {
        expenseCategoryList.value.add(category);
      }
    });
    incomeCategoryList.notifyListeners();
    expenseCategoryList.notifyListeners();
  }
}
