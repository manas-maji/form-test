import 'package:flutter/material.dart';
import 'package:single_dropdown_text_field/forms/local_validator.dart';

import '../models/enquiry_field.dart';
import 'custom_dropdown_field.dart';
import 'custom_text_field.dart';
import 'form_title_bar.dart';

// To initialize & dispose TextController
// Not require for dropdown as they don't require controller
enum EnquiryTextField {
  thickness,
  width,
  innerDiameter,
  outerDiameter,
  weight,
  sheetLength,
}

class HotRolledSteelForm extends StatefulWidget with LocalValidator {
  @override
  _HotRolledSteelFormState createState() => _HotRolledSteelFormState();
}

class _HotRolledSteelFormState extends State<HotRolledSteelForm> {
  final _formKey = GlobalKey<FormState>();

  _Backend _backend;

  // test field controllers mapped with respective enum
  Map<EnquiryTextField, TextEditingController> _fieldControllers = {};

  // initial sub product val to draw UI depending on sub product
  SubProduct _subProduct = SubProduct(id: '1', name: 'Coil');
  Application _application;
  Standard _standard;
  Grade _grade;

  // getters for textControllers value
  // only for those on which other field depends
  String get _thicknessText =>
      _fieldControllers[EnquiryTextField.thickness].text;
  String get _widthText => _fieldControllers[EnquiryTextField.width].text;
  String get _innerDiameterText =>
      _fieldControllers[EnquiryTextField.innerDiameter].text;
  String get _outerDiameterText =>
      _fieldControllers[EnquiryTextField.outerDiameter].text;

  @override
  void initState() {
    super.initState();
    EnquiryTextField.values.forEach((field) {
      _fieldControllers.addAll({
        field: TextEditingController(),
      });
    });

    if (_backend == null) {
      _backend = _Backend();
    }
  }

  @override
  void dispose() {
    _fieldControllers.values.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            const FormTitleBar(title: 'Hot Rolled Steel'),
            Expanded(child: _buildForm()),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          // subProducts
          CustomDropdownField(
            fieldHeading: 'Sub Product',
            enabled: true,
            enquiryItem: _subProduct,
            futureEnquiryItems: _backend.getSubProducts(),
            onChanged: (newId) {
              setState(() {
                _subProduct =
                    EnquiryItem.findItemById(_backend.subProducts, newId);
                resetDependenciesOnSubProduct();
              });
            },
          ),
          // applications
          CustomDropdownField(
            fieldHeading: 'Application',
            enabled: _subProduct != null,
            enquiryItem: _application,
            futureEnquiryItems: _backend.getApplications(),
            onChanged: (newId) {
              setState(() {
                _application =
                    EnquiryItem.findItemById(_backend.applications, newId);
                resetDependenciesOnApplication();
              });
            },
          ),
          // standards
          CustomDropdownField(
            fieldHeading: 'Standard',
            enabled: _application != null,
            enquiryItem: _standard,
            futureEnquiryItems: _backend.getStandards(),
            onChanged: (newId) {
              setState(() {
                _standard = EnquiryItem.findItemById(_backend.standards, newId);
                resetDependenciesOnStandard();
              });
            },
          ),
          // grades
          CustomDropdownField(
            fieldHeading: 'Grade',
            enabled: _standard != null,
            enquiryItem: _grade,
            futureEnquiryItems: _backend.getGrades(),
            onChanged: (newId) {
              setState(() {
                _grade = EnquiryItem.findItemById(_backend.grades, newId);
              });
            },
          ),
          // thickness
          CustomTextField(
            fieldHeading: 'Thickness',
            hintText: 'Enter thickness',
            enabled: _grade != null,
            controller: _fieldControllers[EnquiryTextField.thickness],
            validator: (val) => widget.validateThickness(val),
            onFiledSubmitted: (_) {
              setState(() {
                resetDependenciesOnThickness();
              });
            },
          ),
          // width
          CustomTextField(
            fieldHeading: 'Width',
            hintText: 'Enter width',
            enabled: _thicknessText != '',
            controller: _fieldControllers[EnquiryTextField.width],
            validator: (val) => widget.validateWidth(val),
            onFiledSubmitted: (_) {
              setState(() {
                resetDependenciesOnWidth();
              });
            },
          ),
          // inner diameter
          if (_subProduct.id == '1' || _subProduct.id == '3')
            CustomTextField(
              fieldHeading: 'Inner Diameter',
              hintText: 'Enter inner diameter',
              enabled: _widthText != '',
              controller: _fieldControllers[EnquiryTextField.innerDiameter],
              validator: (val) => widget.validateInnerDiameter(val),
              onFiledSubmitted: (_) {
                setState(() {
                  resetDependenciesOnInnerDiameter();
                });
              },
            ),
          // outer diameter
          if (_subProduct.id == '1' || _subProduct.id == '3')
            CustomTextField(
              fieldHeading: 'Outer Diameter',
              hintText: 'Enter outer diameter',
              enabled: _innerDiameterText != '',
              controller: _fieldControllers[EnquiryTextField.outerDiameter],
              validator: (val) =>
                  widget.validateOuterDiameter(val, _innerDiameterText),
              onFiledSubmitted: (_) {
                setState(() {
                  resetDependenciesOnOuterDiameter();
                });
              },
            ),
          // weight
          if (_subProduct.id == '1' || _subProduct.id == '3')
            CustomTextField(
              fieldHeading: 'Weight',
              hintText: 'Enter weight',
              enabled: _outerDiameterText != '',
              controller: _fieldControllers[EnquiryTextField.weight],
              validator: (val) => widget.validateWeight(val),
              onFiledSubmitted: (_) {},
            ),
          // sheet length
          if (_subProduct.id == '2')
            CustomTextField(
              fieldHeading: 'Sheet Length',
              hintText: 'Enter sheet length',
              enabled: _widthText != '',
              controller: _fieldControllers[EnquiryTextField.sheetLength],
              validator: (val) => widget.validateSheetLength(val),
              onFiledSubmitted: (_) {},
            ),
          // Add to list Button
          Padding(
            padding: EdgeInsets.all(12.0),
            child: OutlineButton(
              textColor: Colors.blue,
              onPressed: () {
                _checkedAllInputValue();
              },
              child: Text('Add To List'),
            ),
          ),
        ],
      ),
    );
  }

  //TODO: removed it, just for testing
  void _checkedAllInputValue() {
    print('Checking all fields value....');
    print('Sub product: ${_subProduct.toJSON()}');
    print('Application: ${_application.toJSON()}');
    print('Standard: ${_standard.toJSON()}');
    print('Grade: ${_grade.toJSON()}');
    print('Thickness: $_thicknessText}');
    print('Width: $_widthText');
    print('InnerDiameter: $_innerDiameterText');
    print('OuterDiameter: $_outerDiameterText');
    print('Weight: ${_fieldControllers[EnquiryTextField.weight].text}');
    print(
        'Sheet Length: ${_fieldControllers[EnquiryTextField.sheetLength].text}');
  }

  // reset dependencies
  void resetDependenciesOnSubProduct() {
    resetApplication();
  }

  void resetApplication() {
    _application = null;
    _backend.applications = null;
    resetDependenciesOnApplication();
  }

  void resetDependenciesOnApplication() {
    resetStandard();
  }

  void resetStandard() {
    _standard = null;
    _backend.standards = null;
    resetDependenciesOnStandard();
  }

  void resetDependenciesOnStandard() {
    resetGrade();
  }

  void resetGrade() {
    _grade = null;
    _backend.grades = null;
    resetDependenciesOnGrade();
  }

  void resetDependenciesOnGrade() {
    resetThickness();
  }

  void resetThickness() {
    _fieldControllers[EnquiryTextField.thickness].text = '';
    resetDependenciesOnThickness();
  }

  void resetDependenciesOnThickness() {
    resetWidth();
  }

  void resetWidth() {
    _fieldControllers[EnquiryTextField.width].text = '';
    resetDependenciesOnWidth();
  }

  void resetDependenciesOnWidth() {
    resetInnerDiameter();
    resetSheetLength();
  }

  void resetInnerDiameter() {
    _fieldControllers[EnquiryTextField.innerDiameter].text = '';
    resetDependenciesOnInnerDiameter();
  }

  void resetSheetLength() {
    _fieldControllers[EnquiryTextField.sheetLength].text = '';
  }

  void resetDependenciesOnInnerDiameter() {
    resetOuterDiameter();
  }

  void resetOuterDiameter() {
    _fieldControllers[EnquiryTextField.outerDiameter].text = '';
    resetDependenciesOnOuterDiameter();
  }

  void resetDependenciesOnOuterDiameter() {
    resetWeight();
  }

  void resetWeight() {
    _fieldControllers[EnquiryTextField.weight].text = '';
  }
}

class _Backend {
  List<EnquiryItem> subProducts;
  List<EnquiryItem> applications;
  List<EnquiryItem> standards;
  List<EnquiryItem> grades;

  List<Map<String, dynamic>> subProductFromServer = [
    {'id': '1', 'name': 'Coil'},
    {'id': '2', 'name': 'Sheet'},
    {'id': '3', 'name': 'Slit'},
  ];

  List<Map<String, dynamic>> applicationsFromServer = [
    {'id': '1', 'name': 'Application 1'},
    {'id': '2', 'name': 'Application 2'},
    {'id': '3', 'name': 'Application 3'},
  ];

  List<Map<String, dynamic>> standardsFromServer = [
    {'id': '1', 'name': 'Standard 1'},
    {'id': '2', 'name': 'Standard 2'},
    {'id': '3', 'name': 'Standard 3'},
  ];

  List<Map<String, dynamic>> gradesFromServer = [
    {'id': '1', 'name': 'Grade 1'},
    {'id': '2', 'name': 'Grade 2'},
    {'id': '3', 'name': 'Grade 3'},
  ];

  Future<List<EnquiryItem>> getSubProducts() async {
    return await Future.delayed(Duration(seconds: 2), () {
      subProducts = subProductFromServer
          .map((itemJson) => SubProduct.fromJSON(itemJson))
          .toList();
      return subProducts;
    });
  }

  Future<List<EnquiryItem>> getApplications() async {
    return await Future.delayed(Duration(seconds: 1), () {
      applications = applicationsFromServer
          .map((itemJson) => Application.fromJSON(itemJson))
          .toList();
      return applications;
    });
  }

  Future<List<EnquiryItem>> getStandards() async {
    return await Future.delayed(Duration(seconds: 1), () {
      standards = standardsFromServer
          .map((itemJson) => Standard.fromJSON(itemJson))
          .toList();
      return standards;
    });
  }

  Future<List<EnquiryItem>> getGrades() async {
    return await Future.delayed(Duration(seconds: 1), () {
      grades =
          gradesFromServer.map((itemJson) => Grade.fromJSON(itemJson)).toList();
      return grades;
    });
  }
}
