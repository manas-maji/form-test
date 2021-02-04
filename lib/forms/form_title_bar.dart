import 'package:flutter/material.dart';

class FormTitleBar extends StatelessWidget {
  final String title;

  const FormTitleBar({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}
