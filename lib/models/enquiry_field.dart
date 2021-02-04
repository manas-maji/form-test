import 'package:flutter/material.dart';

abstract class EnquiryItem {
  final String id;
  final String name;

  EnquiryItem({@required this.id, @required this.name});

  Map<String, dynamic> toJSON() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  static EnquiryItem findItemById(List<EnquiryItem> items, String id) {
    return items.firstWhere((element) => element.id == id);
  }
}

class SubProduct extends EnquiryItem {
  SubProduct({
    @required String id,
    @required String name,
  }) : super(id: id, name: name);

  factory SubProduct.fromJSON(Map<String, dynamic> json) {
    return SubProduct(id: json['id'], name: json['name']);
  }
}

class Application extends EnquiryItem {
  Application({
    @required String id,
    @required String name,
  }) : super(id: id, name: name);

  factory Application.fromJSON(Map<String, dynamic> json) {
    return Application(id: json['id'], name: json['name']);
  }
}

class Standard extends EnquiryItem {
  Standard({
    @required String id,
    @required String name,
  }) : super(id: id, name: name);

  factory Standard.fromJSON(Map<String, dynamic> json) {
    return Standard(id: json['id'], name: json['name']);
  }
}

class Grade extends EnquiryItem {
  Grade({
    @required String id,
    @required String name,
  }) : super(id: id, name: name);

  factory Grade.fromJSON(Map<String, dynamic> json) {
    return Grade(id: json['id'], name: json['name']);
  }
}
