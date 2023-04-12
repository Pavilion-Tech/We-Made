import 'package:wee_made/models/user/home_model.dart';

class ProviderProductsModel {
  String? message;
  bool? status;
  Data? data;

  ProviderProductsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  int? pages;
  int? count;
  List<Products>? data;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Products>[];
      json['data'].forEach((v) {
        data!.add(Products.fromJson(v));
      });
    }
  }
}
