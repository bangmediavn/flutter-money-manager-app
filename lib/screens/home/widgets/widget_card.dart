import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetCard extends StatefulWidget {
  const WidgetCard({Key? key}) : super(key: key);

  @override
  State<WidgetCard> createState() => _WidgetCardState();
}


class _WidgetCardState extends State<WidgetCard> {
  double _totalIncome = 0;
  double _totalExpense = 0;
  @override

  @override
  Widget build(BuildContext context) {
    getIncomeAndExpense();
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Card(
        color: const Color.fromRGBO(60,60,60,1),
        elevation: 3,
        margin: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children:  [
                    const Text(
                        'Total Income',
                        style:TextStyle(
                            letterSpacing: 1.1,
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        )
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        _totalIncome.toString(),
                        style:const TextStyle(
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
                  children:  [
                    const Text(
                        'Total Expense',
                        style:TextStyle(
                            letterSpacing: 1.1,
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        )
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        _totalExpense.toString(),
                        style: const TextStyle(
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
  Future<void> getIncomeAndExpense ()async{
    final sharedPref = await SharedPreferences.getInstance();
     double?   income = sharedPref.getDouble('income_amount');
     double? expense = sharedPref.getDouble('expense_amount');
    if (income != null ){
      setState(() {
        _totalIncome = income;
      });

    }else {
      setState(() {
        _totalIncome = 0.0;
      });
    }
    if (expense != null) {
      setState(() {
        _totalExpense = expense;
      });
    }else {
      setState(() {
        _totalExpense = 0.0;
      });
    }

  }
}
