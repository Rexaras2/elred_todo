import 'package:flutter/material.dart';

snackBar(String text, context, {int duration = 2}) {
  final snackBar = SnackBar(
    margin: const EdgeInsets.only(bottom: 20, left: 50, right: 50),
    behavior: SnackBarBehavior.floating,
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
    duration: Duration(seconds: duration),
    backgroundColor: Colors.white,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
