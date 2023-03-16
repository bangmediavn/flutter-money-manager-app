import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String errorMsg;
  String hint;
  CustomTextField({
    Key? key,
    required this.controller,
    required this.errorMsg,
    required this.hint
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      controller: controller,
      validator: (value) {
        return (value == null || value.isEmpty
            ? errorMsg
            : null);
      },
      style: const TextStyle(color: Colors.white),
      decoration:  InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide( color: Colors.white)
          ),
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide( color: Colors.white)
          ),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.redAccent
              )
          ),
          hintText: hint,
      ),
    );
  }
}
