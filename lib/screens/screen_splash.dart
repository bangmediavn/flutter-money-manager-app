import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_manager/screens/home/screen_home.dart';
import '../db/functions/category/category_db.dart';
import '../db/functions/transaction/transaction_db.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    callDatabase(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(60, 60, 60, 1),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor:  Color.fromRGBO(60,60,60,1),
        ),
      ),
      backgroundColor: const Color.fromRGBO(60, 60, 60, 1),
      extendBody: true,
      body: const SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Text(
                  'Quản lý thu chi cá nhân',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.1
                ),

              ),
            ),
          )
      ),
    );
  }

  Future<void> callDatabase(ctx) async {
    await CategoryDb.instance.refreshUi();
    await TransactionDb.instance.refreshUi();
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (BuildContext ctx) =>  ScreenHome()));
  }
}
