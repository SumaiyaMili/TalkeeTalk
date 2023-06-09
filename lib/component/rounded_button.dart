import 'package:flutter/material.dart';

class SolidColuredButton extends StatelessWidget {
  final String lebelText;
  final Color buttonColor;
  final Function() onPressed;

  SolidColuredButton(
      {required this.buttonColor,
      required this.lebelText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            lebelText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
