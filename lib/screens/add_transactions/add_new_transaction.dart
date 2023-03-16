import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/functions/category/category_db.dart';
import 'package:money_manager/db/functions/transaction/transaction_db.dart';
import 'package:money_manager/db/models/category/category_model.dart';
import 'package:money_manager/db/models/transaction/transaction_model.dart';
import 'package:money_manager/screens/add_transactions/widgets/text_field.dart';

class NewTransAction extends StatefulWidget {
  static const routeName = 'add-transaction';

  const NewTransAction({Key? key}) : super(key: key);

  @override
  State<NewTransAction> createState() => _NewTransActionState();
}

class _NewTransActionState extends State<NewTransAction> {
  DateTime? _dateTime;
  CategoryType? _categoryType;
  CategoryModel? _categoryModel;
  String? _categoryId;

  final _purposeTextController = TextEditingController();
  final _amountTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _categoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(70,70,70,1),
      appBar: AppBar(
        backgroundColor: const  Color.fromRGBO(60,60,60,1),
        elevation: 0,
        title: const Text(
          'Add Transaction',
          style: TextStyle(
            letterSpacing: 1.1,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:CustomTextField(
                        controller: _purposeTextController,
                        errorMsg: 'Enter purpose',
                        hint: 'Purpose'
                    )
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                        controller: _amountTextController,
                        errorMsg: 'Enter Amount',
                        hint: 'Amount'
                    )
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                value: CategoryType.income,
                                groupValue: _categoryType,
                                activeColor: Colors.white,
                                fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                                onChanged: (newType) {
                                  setState(() {
                                    _categoryType = newType;
                                    _categoryId = null;
                                  });
                                }),
                            const Text(
                                'Income',
                                style: TextStyle(
                                    letterSpacing: 1.1,
                                    fontSize: 14,
                                    color: Colors.white
                                )
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                value: CategoryType.expense,
                                groupValue: _categoryType,
                                activeColor: Colors.white,
                                fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                                onChanged: (newType) {
                                  setState(() {
                                    _categoryType = newType;
                                    _categoryId = null;
                                  });
                                }),
                            const Text(
                                'Expense',
                                style: TextStyle(
                                    letterSpacing: 1.1,
                                    fontSize: 14,
                                    color: Colors.white
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //DATE CATEGORY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            TextButton.icon(
                                onPressed: () async {
                                  final date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now()
                                          .subtract(const Duration(days: 31)),
                                      lastDate: DateTime.now());
                                  if (date == null) {
                                    return;
                                  }
                                  setState(() {
                                    _dateTime = date;
                                  });
                                },
                                icon: const Icon(Icons.calendar_today,color:  Colors.white,),
                                label: Text(_dateTime == null
                                    ? 'Select Date'
                                    : DateFormat(' dd-MMM-yyyy')
                                    .format(_dateTime!),
                                    style: const TextStyle(
                                        letterSpacing: 1.1,
                                        fontSize: 14,
                                        color: Colors.white
                                    )
                                )
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                                dropdownColor: const  Color.fromRGBO(70,70,70,1),
                                underline: const DropdownButtonHideUnderline(
                                    child: SizedBox()),
                                value: _categoryId,
                                iconEnabledColor: Colors.white,
                                iconDisabledColor: Colors.white,
                                hint: const Text('Select Category',style: TextStyle(color: Colors.white),),
                                items: (_categoryType == CategoryType.income
                                    ? CategoryDb
                                    .instance.incomeCategoryList.value
                                    : CategoryDb
                                    .instance.expenseCategoryList.value)
                                    .map((e) {
                                  return DropdownMenuItem(
                                    onTap: () {
                                      _categoryModel = e;
                                    },
                                    value: e.id,
                                    child: Text(e.name, style: const TextStyle(
                                        letterSpacing: 1.1,
                                        fontSize: 14,
                                        color: Colors.white
                                    )),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _categoryId = value;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //DATE CATEGORY
                  //SUBMIT BUTTON
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addTransactions();
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text(
                            'Add',
                            style: TextStyle(
                                letterSpacing: 1.1,
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            )
                        ),


                      ),
                    ),
                  )
                  //SUBMIT BUTTON
                ],
              ),
            )),
      ),
    );
  }

  Future<void> addTransactions() async {
    final purposeText = _purposeTextController.text;
    final parsedAmount = double.tryParse(_amountTextController.text);

    if (_categoryId == null ||
        _dateTime == null ||
        _categoryModel == null ||
        parsedAmount == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(8),
          backgroundColor: Colors.red,
          content: Text(
            'Please fill all required data',
          )));
    } else {
      final transaction = TransactionModel(
          name: purposeText,
          amount: parsedAmount,
          dateTime: _dateTime!,
          categoryType: _categoryType!,
          category: _categoryModel!);
      await TransactionDb.instance.insertTransaction(transaction);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(8),
          backgroundColor: Colors.green,
          content: Text(
            'Transaction added',
          )));
    }
  }
}