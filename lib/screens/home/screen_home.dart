import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_manager/screens/add_transactions/add_new_transaction.dart';
import 'package:money_manager/screens/category/screen_category.dart';
import 'package:money_manager/screens/category/widgets/category_add_popup.dart';
import 'package:money_manager/screens/home/widgets/bottom_navigation_widget.dart';
import 'package:money_manager/screens/transactions/screen_transactions.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [ScreenTransactions(), ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
            'Money Manager',
          style:  TextStyle(
            letterSpacing: 1.1,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white
            ,
          ),
        ),
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu)),
        centerTitle: false,
        elevation: 0.6,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.blue,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            Navigator.of(context).pushNamed(NewTransAction.routeName);
          } else {
            showCategoryAddPopup(context);
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const HomeBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext ctx, int index, Widget? child) {
              return _pages[index];
            }),
      ),
    );
  }
}
