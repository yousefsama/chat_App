import 'package:flutter/material.dart';

class Elevatedbottun extends StatelessWidget {
  Elevatedbottun({
    super.key,
    required this.textBottun,
    this.ontap,
  });

  @override
  String textBottun;
  VoidCallback? ontap;
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      child: Text(
        textBottun,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            height: 2,
            color: Colors.black,
            shadows: [Shadow(blurRadius: 10)]),
      ),
    );
  }
}
