import 'package:flutter/material.dart';
import 'package:single_dropdown_text_field/forms/form_graph.dart';
import 'package:single_dropdown_text_field/models/enquiry_field.dart';

import 'enquiry_form_widget.dart';
import 'form_backend.dart';

class HotRolledSteelForm extends StatelessWidget {
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
          backend: _HRSFormBackend(),
          graph: FormGraph(
            form: EnquiryForm.HotRolledSteel,
            initialSubProduct: SubProduct(id: '1', name: 'Coil'),
          ),
        ),
      ),
    );
  }
}

class _HRSFormBackend extends FormBackend {}
