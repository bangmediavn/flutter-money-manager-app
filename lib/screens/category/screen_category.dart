import 'package:flutter/material.dart';
import 'package:money_manager/db/functions/category/category_db.dart';
import 'package:money_manager/screens/category/widgets/tabbar_expense_widgets.dart';
import 'package:money_manager/screens/category/widgets/tabbar_income_widget.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb.instance.refreshUi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(60,60,60,1),
      child: Column(
        children:  [
          TabBar(
            indicatorWeight: 2.8,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            controller: _tabController,
            unselectedLabelColor: Colors.white,
              tabs: const [
            Tab(text: 'INCOME',),
            Tab(text: 'EXPENSE',)
          ]),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                 TabBarIncomeWidget(),
                TabBarExpenseWidget()
              ],
            ),
          )
        ],
      ),
    );
  }
}
















