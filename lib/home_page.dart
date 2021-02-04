import 'package:flutter/material.dart';
import 'package:single_dropdown_text_field/models/enquiry_field.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OOPS Design')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            print('-----------Sub Product-------------');
            var subProduct = SubProduct(id: '1', name: 'coil');
            print(subProduct.toJSON());
            var json = subProduct.toJSON();
            print(subProduct.runtimeType);
            var subProductFromJson = SubProduct.fromJSON(json);
            print(subProductFromJson.toJSON());

            print('---------Application---------');
            var application =
                Application(id: '1', name: 'Steel for Cold forming');
            print(application.toJSON());
            var appJson = application.toJSON();
            print(application.runtimeType);
            var appFromJson = Application.fromJSON(appJson);
            print(appFromJson.toJSON());
          },
          child: Text('Check'),
        ),
      ),
    );
  }
}
