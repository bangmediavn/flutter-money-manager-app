import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_manager/screens/add_transactions/add_new_transaction.dart';
import 'package:money_manager/screens/category/screen_category.dart';
import 'package:money_manager/screens/category/widgets/category_add_popup.dart';
import 'package:money_manager/screens/home/widgets/bottom_navigation_widget.dart';
import 'package:money_manager/screens/home/widgets/widget_home.dart';
import 'package:money_manager/screens/transactions/screen_transactions.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final _pages = const [WidgetHome(),ScreenTransactions(), ScreenCategory()];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(70,70,70,1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(60,60,60,1),
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
          statusBarColor:  Color.fromRGBO(60,60,60,1),
        ),
      ),
      floatingActionButton: FloatingActionButton(

        elevation: 1,
        backgroundColor: const Color.fromRGBO(60,60,60,1),
        onPressed: () {
          if (ScreenHome.selectedIndexNotifier.value == 0) {
            Navigator.of(context).pushNamed(NewTransAction.routeName);
          } else if(ScreenHome.selectedIndexNotifier.value == 1) {
            Navigator.of(context).pushNamed(NewTransAction.routeName);
          }else {
            showCategoryAddPopup(context);
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const HomeBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: ScreenHome.selectedIndexNotifier,
            builder: (BuildContext ctx, int index, Widget? child) {
              return _pages[index];
            }),
      ),
    );
  }
}
