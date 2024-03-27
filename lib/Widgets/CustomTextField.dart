import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hint,
      required this.isPassowrd,
      this.onChanged});

  final String hint;
  final bool isPassowrd;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Please fill this feild';
        }
      },
      onChanged: onChanged,
      obscureText: isPassowrd,
      autofocus: true,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          gapPadding: 50,
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
