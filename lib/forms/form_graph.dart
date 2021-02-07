import 'package:flutter/material.dart';

import '../models/enquiry_field.dart';

enum EnquiryForm {
  HotRolledSteel,
  ColdRolledSteel,
}

class FormGraph {
  final EnquiryForm form;
  SubProduct initialSubProduct;

  FormGraph({@required this.form, @required this.initialSubProduct});

  bool get hasApplication => true;

  bool get hasStandard => true;

  bool get hasGrade => true;

  bool get hasThickness => true;

  bool get hasWidth => true;

  bool get hasInnerDiameter {
    bool hasInnerDiameter = false;
    switch (form) {
      case EnquiryForm.HotRolledSteel:
        hasInnerDiameter =
            initialSubProduct.id == '1' || initialSubProduct.id == '2';
        break;
      case EnquiryForm.ColdRolledSteel:
        hasInnerDiameter = initialSubProduct.id == '1';
        break;
      default:
        break;
    }
    return hasInnerDiameter;
  }

  bool get hasOuterDiameter {
    bool hasOuterDiameter = false;
    switch (form) {
      case EnquiryForm.HotRolledSteel:
        hasOuterDiameter =
            (initialSubProduct.id == '1' || initialSubProduct.id == '2');
        break;
      case EnquiryForm.ColdRolledSteel:
        hasOuterDiameter = initialSubProduct.id == '1';
        break;
      default:
        break;
    }
    return hasOuterDiameter;
  }

  bool get hasWeight {
    bool hasWeight = false;
    switch (form) {
      case EnquiryForm.HotRolledSteel:
        hasWeight =
            (initialSubProduct.id == '1' || initialSubProduct.id == '2');
        break;
      case EnquiryForm.ColdRolledSteel:
        hasWeight = initialSubProduct.id == '1';
        break;
      default:
        break;
    }
    return hasWeight;
  }

  bool get hasSheetLength {
    bool hasSheetLength = false;
    switch (form) {
      case EnquiryForm.HotRolledSteel:
      case EnquiryForm.ColdRolledSteel:
        hasSheetLength = initialSubProduct.id == '3';
        break;
      default:
        break;
    }
    return hasSheetLength;
  }

  bool get hasBundleWeight {
    bool hasBundleWeight = false;
    switch (form) {
      case EnquiryForm.HotRolledSteel:
        hasBundleWeight = false;
        break;
      case EnquiryForm.ColdRolledSteel:
        hasBundleWeight = initialSubProduct.id == '3';
        break;
      default:
        break;
    }
    return hasBundleWeight;
  }
}
