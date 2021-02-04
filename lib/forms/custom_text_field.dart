import 'package:flutter/material.dart';

import 'field_decorator.dart';

class CustomTextField extends StatelessWidget with FieldDecorator {
  final String fieldHeading;
  final String hintText;
  final bool enabled;
  final TextEditingController controller;
  final void Function(String) onFiledSubmitted;
  final String Function(String) validator;

  const CustomTextField({
    Key key,
    @required this.fieldHeading,
    @required this.hintText,
    @required this.enabled,
    @required this.controller,
    @required this.onFiledSubmitted,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldHeading,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 4.0,
          ),
          TextFormField(
            controller: controller,
            enabled: enabled,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: onFiledSubmitted,
            keyboardType: TextInputType.number,
            decoration: decoration(hintText: hintText),
          ),
        ],
      ),
    );
  }
}
