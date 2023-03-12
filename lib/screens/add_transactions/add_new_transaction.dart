import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/functions/category/category_db.dart';
import 'package:money_manager/db/functions/transaction/transaction_db.dart';
import 'package:money_manager/db/models/category/category_model.dart';
import 'package:money_manager/db/models/transaction/transaction_model.dart';

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
      appBar: AppBar(
        title: const Text(
            'Add Transaction',
          style: TextStyle(
            letterSpacing: 1.1,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white
            ,
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
                    child: TextFormField(
                      controller: _purposeTextController,
                      validator: (value) {
                        return (value == null || value.isEmpty ? 'Enter Value' : null);
                      },
                      style: const TextStyle(),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Purpose'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _amountTextController,
                      validator: (value) {
                        return ( value==null || value.isEmpty ? 'Enter Value' : null);
                      },
                      keyboardType: TextInputType.number,
                      style: const TextStyle(),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Amount'),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: CategoryType.income,
                                groupValue: _categoryType,
                                onChanged: (newType) {
                                  setState(() {
                                    _categoryType = newType;
                                    _categoryId = null;
                                  });
                                }),
                            const Text('Income'),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: CategoryType.expense,
                                groupValue: _categoryType,
                                onChanged: (newType) {
                                  setState(() {
                                    _categoryType = newType;
                                    _categoryId = null;
                                  });
                                }),
                            const Text('Expense'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //DATE CATEGORY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () async {
                            final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate:
                                DateTime.now().subtract(const Duration(days: 31)),
                                lastDate: DateTime.now());
                            if (date == null) {
                              return;
                            }
                            setState(() {
                              _dateTime = date;
                            });
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: Text(_dateTime == null
                              ? 'Select Date'
                              : DateFormat(' dd-MMM-yyyy').format(_dateTime!))
                      ),
                      DropdownButton<String>(
                        underline: const DropdownButtonHideUnderline(child: SizedBox()),
                          value: _categoryId,
                          hint: const Text('Select Category'),
                          items: (_categoryType == CategoryType.income
                              ? CategoryDb.instance.incomeCategoryList.value
                              : CategoryDb.instance.expenseCategoryList.value)
                              .map((e) {
                            return DropdownMenuItem(
                              onTap: () {
                                _categoryModel = e;
                              },
                              value: e.id,
                              child: Text(e.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _categoryId = value;
                            });
                          }),

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
                          label: const Text('Add')
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

    if (_categoryId == null || _dateTime == null || _categoryModel == null || parsedAmount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 5),
            margin: EdgeInsets.all(8),
            backgroundColor: Colors.red,
              content: Text('Please fill all required data',
              ))
      );
    } else {
      final transaction = TransactionModel(
          purpose: purposeText,
          amount: parsedAmount,
          dateTime: _dateTime!,
          categoryType: _categoryType!,
          category: _categoryModel!);
      await TransactionDb.instance.insertTransaction(transaction);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 5),
              margin: EdgeInsets.all(8),
              backgroundColor: Colors.green,
              content: Text('Transaction added',
              ))
      );
    }
  }
}
