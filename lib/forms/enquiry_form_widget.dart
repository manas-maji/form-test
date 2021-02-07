import 'package:flutter/material.dart';

import '../models/enquiry_field.dart';
import 'custom_dropdown_field.dart';
import 'custom_text_field.dart';
import 'form_backend.dart';
import 'form_graph.dart';
import 'form_title_bar.dart';
import 'local_validator.dart';

// To initialize & dispose TextController
// Not require for dropdown as they don't require controller
enum EnquiryTextField {
  thickness,
  width,
  innerDiameter,
  outerDiameter,
  weight,
  sheetLength,
  bundleWeight,
}

class EnquiryFormWidget extends StatefulWidget with LocalValidator {
  final String formTitle;
  final FormGraph graph;
  final FormBackend backend;
  const EnquiryFormWidget({
    Key key,
    @required this.formTitle,
    @required this.backend,
    @required this.graph,
  }) : super(key: key);

  @override
  _EnquiryFormWidgetState createState() => _EnquiryFormWidgetState();
}

class _EnquiryFormWidgetState extends State<EnquiryFormWidget> {
  final _formKey = GlobalKey<FormState>();

  // test field controllers mapped with respective enum
  Map<EnquiryTextField, TextEditingController> _fieldControllers = {};

  SubProduct _subProduct;
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
  String get _sheetLengthText =>
      _fieldControllers[EnquiryTextField.sheetLength].text;

  @override
  void initState() {
    super.initState();
    EnquiryTextField.values.forEach((field) {
      _fieldControllers.addAll({
        field: TextEditingController(),
      });
    });

    // initial sub product val to draw UI depending on sub product from widget
    _subProduct = widget.graph.initialSubProduct;
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
    return Column(
      children: [
        FormTitleBar(title: widget.formTitle),
        Expanded(child: _buildForm()),
      ],
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
            futureEnquiryItems: widget.backend.getSubProducts(),
            onChanged: (newId) {
              setState(() {
                _subProduct =
                    EnquiryItem.findItemById(widget.backend.subProducts, newId);
                // update sub product in form graph
                widget.graph.initialSubProduct = _subProduct;
                resetDependenciesOnSubProduct();
              });
            },
          ),
          // applications
          if (widget.graph.hasApplication)
            CustomDropdownField(
              fieldHeading: 'Application',
              enabled: _subProduct != null,
              enquiryItem: _application,
              futureEnquiryItems: widget.backend.getApplications(),
              onChanged: (newId) {
                setState(() {
                  _application = EnquiryItem.findItemById(
                      widget.backend.applications, newId);
                  resetDependenciesOnApplication();
                });
              },
            ),
          // standards
          if (widget.graph.hasStandard)
            CustomDropdownField(
              fieldHeading: 'Standard',
              enabled: _application != null,
              enquiryItem: _standard,
              futureEnquiryItems: widget.backend.getStandards(),
              onChanged: (newId) {
                setState(() {
                  _standard =
                      EnquiryItem.findItemById(widget.backend.standards, newId);
                  resetDependenciesOnStandard();
                });
              },
            ),
          // grades
          if (widget.graph.hasGrade)
            CustomDropdownField(
              fieldHeading: 'Grade',
              enabled: _standard != null,
              enquiryItem: _grade,
              futureEnquiryItems: widget.backend.getGrades(),
              onChanged: (newId) {
                setState(() {
                  _grade =
                      EnquiryItem.findItemById(widget.backend.grades, newId);
                });
              },
            ),
          // thickness
          if (widget.graph.hasThickness)
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
          if (widget.graph.hasWidth)
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
          if (widget.graph.hasInnerDiameter)
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
          if (widget.graph.hasOuterDiameter)
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
          if (widget.graph.hasWeight)
            CustomTextField(
              fieldHeading: 'Weight',
              hintText: 'Enter weight',
              enabled: _outerDiameterText != '',
              controller: _fieldControllers[EnquiryTextField.weight],
              validator: (val) => widget.validateWeight(val),
              onFiledSubmitted: (_) {},
            ),
          // sheet length
          if (widget.graph.hasSheetLength)
            CustomTextField(
              fieldHeading: 'Sheet Length',
              hintText: 'Enter sheet length',
              enabled: _widthText != '',
              controller: _fieldControllers[EnquiryTextField.sheetLength],
              validator: (val) => widget.validateSheetLength(val),
              onFiledSubmitted: (_) {
                setState(() {
                  resetDependenciesOnSheetLength();
                });
              },
            ),
          if (widget.graph.hasBundleWeight)
            CustomTextField(
              fieldHeading: 'Bundle Weight',
              hintText: 'Enter bundle wight',
              enabled: _sheetLengthText != '',
              controller: _fieldControllers[EnquiryTextField.bundleWeight],
              validator: (val) => widget.validateBundleWeight(val),
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
    print('Sheet Length: $_sheetLengthText}');
    print(
        'Bundle Weight: ${_fieldControllers[EnquiryTextField.bundleWeight].text}');
  }

  // reset dependencies
  void resetDependenciesOnSubProduct() {
    resetApplication();
  }

  void resetApplication() {
    _application = null;
    widget.backend.applications = null;
    resetDependenciesOnApplication();
  }

  void resetDependenciesOnApplication() {
    resetStandard();
  }

  void resetStandard() {
    _standard = null;
    widget.backend.standards = null;
    resetDependenciesOnStandard();
  }

  void resetDependenciesOnStandard() {
    resetGrade();
  }

  void resetGrade() {
    _grade = null;
    widget.backend.grades = null;
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
    resetDependenciesOnSheetLength();
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

  void resetDependenciesOnSheetLength() {
    resetBundleWeight();
  }

  void resetBundleWeight() {
    _fieldControllers[EnquiryTextField.bundleWeight].text = '';
  }
}
