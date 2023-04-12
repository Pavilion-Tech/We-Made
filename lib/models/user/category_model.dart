import 'package:wee_made/models/user/home_model.dart';

class CategoryModel {
  String? message;
  bool? status;
  List<Products>? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Products>[];
      json['data'].forEach((v) {
        data!.add( Products.fromJson(v));
      });
    }
  }

}
