import 'package:flutter/material.dart';
import 'package:single_dropdown_text_field/models/enquiry_field.dart';

import 'enquiry_form_widget.dart';
import 'form_backend.dart';
import 'form_graph.dart';

class ColdRolledSteelForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: EnquiryFormWidget(
          formTitle: 'Hot Rolled Steel',
          backend: _CRSFormBackend(),
          graph: FormGraph(
            form: EnquiryForm.ColdRolledSteel,
            initialSubProduct: SubProduct(id: '1', name: 'Coil'),
          ),
        ),
      ),
    );
  }
}

class _CRSFormBackend extends FormBackend {
  @override
  List<Map<String, dynamic>> subProductFromServer = [
    {'id': '1', 'name': 'Coil'},
    {'id': '3', 'name': 'Sheet'},
  ];
}
