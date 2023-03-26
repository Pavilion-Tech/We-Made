import 'home_model.dart';

class SearchModel {
  String? message;
  bool? status;
  List<Products>? data;


  SearchModel.fromJson(Map<String, dynamic> json) {
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


