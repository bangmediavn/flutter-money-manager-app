import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetCard extends StatelessWidget {
  const WidgetCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Card(
        color: const Color.fromRGBO(60,60,60,1),
        elevation: 2,
        margin: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [
                    Text(
                        'Total Income',
                        style:TextStyle(
                            letterSpacing: 1.1,
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        '100000.0',
                        style:TextStyle(
                            letterSpacing: 1.1,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        )
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              width: 2,
              color: Colors.white,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [
                    Text(
                        'Total Expense',
                        style:TextStyle(
                            letterSpacing: 1.1,
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        '100000.0',
                        style:TextStyle(
                            letterSpacing: 1.1,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
