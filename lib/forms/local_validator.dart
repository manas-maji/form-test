mixin LocalValidator {
  String validateThickness(String val) {
    return _checkValidNumberOrLessThanEqualOther(val);
  }

  String validateWidth(String val) {
    return _checkValidNumberOrLessThanEqualOther(val);
  }

  String validateInnerDiameter(String val) {
    return _checkValidNumberOrLessThanEqualOther(val);
  }

  String validateOuterDiameter(String outerDiameterVal, innerDiameterVal) {
    return _checkValidNumberOrLessThanEqualOther(
        outerDiameterVal, innerDiameterVal);
  }

  String validateWeight(String val) {
    return _checkValidNumberOrLessThanEqualOther(val);
  }

  String validateSheetLength(String val) {
    return _checkValidNumberOrLessThanEqualOther(val);
  }

  String _checkValidNumberOrLessThanEqualOther(String val,
      [String other = '0']) {
    double parsedVal = double.tryParse(val ?? '0');
    double otherParsedVal = double.tryParse(other);

    if (parsedVal == null) {
      return 'Enter a valid number';
    } else if (parsedVal <= otherParsedVal) {
      return 'Should be greater than $other';
    }
    return null;
  }
}
