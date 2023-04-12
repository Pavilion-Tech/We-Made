import 'package:wee_made/models/user/home_model.dart';

class FavModel {
  String? message;
  bool? status;
  FavData? data;

  FavModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? FavData.fromJson(json['data']) : null;
  }

}

class FavData {
  int? currentPage;
  int? pages;
  int? count;
  List<Products>? data;

  FavData.fromJson(Map<String, dynamic> json) {
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

