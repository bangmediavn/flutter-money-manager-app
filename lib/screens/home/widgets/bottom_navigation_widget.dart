import 'package:flutter/material.dart';
import 'package:money_manager/screens/home/screen_home.dart';


class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? child){
        return BottomNavigationBar(
          currentIndex: updatedIndex,
          onTap: (newIndex){
            ScreenHome.selectedIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Transactions'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Category'
            )
          ],
        );
      },
    );
  }
}
