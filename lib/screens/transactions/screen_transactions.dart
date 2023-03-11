import 'package:flutter/material.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (BuildContext ctx, int index){
          return const Card(
            elevation: 1,
            child: ListTile(
              leading: CircleAvatar(child: Text('12 \ndes'), radius: 40,),
              title: Text('Rs 10000'),
              subtitle: Text('Travel'),
            ),
          );
        },
        separatorBuilder: (BuildContext ctx, int index){
          return const SizedBox(height: 4,);
        },
        itemCount: 10
    );
  }
}
