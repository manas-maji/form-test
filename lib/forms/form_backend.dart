import '../models/enquiry_field.dart';

abstract class FormBackend {
  List<EnquiryItem> subProducts;
  List<EnquiryItem> applications;
  List<EnquiryItem> standards;
  List<EnquiryItem> grades;

  List<Map<String, dynamic>> subProductFromServer = [
    {'id': '1', 'name': 'Coil'},
    {'id': '2', 'name': 'Slit'},
    {'id': '3', 'name': 'Sheet'},
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
    return await Future.delayed(Duration(seconds: 1), () {
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
