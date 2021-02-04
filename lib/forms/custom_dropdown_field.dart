import 'package:flutter/material.dart';

import '../models/enquiry_field.dart';
import 'field_decorator.dart';

class CustomDropdownField extends StatelessWidget with FieldDecorator {
  final String fieldHeading;
  final bool enabled;
  final EnquiryItem enquiryItem;
  final Future<List<EnquiryItem>> futureEnquiryItems;
  final void Function(String) onChanged;

  const CustomDropdownField({
    Key key,
    @required this.fieldHeading,
    @required this.enabled,
    @required this.enquiryItem,
    @required this.futureEnquiryItems,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          enabled
              ? FutureBuilder(
                  future: futureEnquiryItems,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<EnquiryItem>> snapshot) {
                    if (snapshot.hasData) {
                      return _buildDropdown(snapshot.data);
                    } else if (snapshot.hasError) {
                      return _errorWidget(snapshot.error.toString());
                    }
                    return _loadingIndicator();
                  })
              : _placeHolder(),
        ],
      ),
    );
  }

  Widget _buildDropdown(List<EnquiryItem> items) {
    return DropdownButtonFormField(
      items: items
          .map((enquiryItem) => DropdownMenuItem(
                child: Text(enquiryItem.name),
                value: enquiryItem.id,
              ))
          .toList(),
      value: enquiryItem == null ? null : enquiryItem.id,
      onChanged: onChanged,
      hint: Text('Select from list'),
      decoration: decoration(),
    );
  }

  Container _errorWidget(String errorText) {
    return _commonContainer(
      Text(errorText, style: TextStyle(fontSize: 16, color: Colors.red)),
      Alignment.centerLeft,
      Colors.red,
    );
  }

  Container _loadingIndicator() {
    return _commonContainer(
      const CircularProgressIndicator(),
      Alignment.center,
      Colors.black,
    );
  }

  Container _placeHolder() {
    return _commonContainer(
      const Text('Select from list',
          style: TextStyle(fontSize: 16, color: Colors.grey)),
      Alignment.centerLeft,
      Colors.grey,
    );
  }

  Container _commonContainer(
      Widget child, Alignment childAlignment, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: borderColor),
      ),
      alignment: childAlignment,
      child: child,
    );
  }
}
