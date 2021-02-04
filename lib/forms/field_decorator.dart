import 'package:flutter/material.dart';

mixin FieldDecorator {
  InputDecoration decoration({String hintText}) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}
