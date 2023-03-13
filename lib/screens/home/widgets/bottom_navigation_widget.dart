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
          fixedColor: Colors.white,
          backgroundColor: const Color.fromRGBO(60, 60, 60, 1),
          unselectedItemColor: Colors.grey,
          currentIndex: updatedIndex,
          onTap: (newIndex){

            ScreenHome.selectedIndexNotifier.value = newIndex;
            ScreenHome.selectedIndexNotifier.notifyListeners();
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color:  Colors.grey,),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.transform_sharp, color: Colors.grey,),
                label: 'Add Transactions'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.category, color:  Colors.grey,),
                label: 'Category'
            ),

          ],
        );
      },
    );
  }
}
