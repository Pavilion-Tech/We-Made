import '../user/home_model.dart';

class ProviderModel {
  String? message;
  bool? status;
  Data? data;

  ProviderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? id;
  String? storeName;
  String? ownerName;
  String? email;
  String? cityId;
  String? neighborhoodId;
  List<CategoryId>? categoryId;
  String? idNumber;
  String? commercialRegisterationNumber;
  int? hasSpecialRequests;
  String? firebaseToken;
  String? password;
  String? whatsappNumber;
  String? phoneNumber;
  String? personalPhoto;
  String? currentLanguage;
  int? status;
  Stories? stories;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    ownerName = json['owner_name'];
    email = json['email'];
    cityId = json['city_id'];
    neighborhoodId = json['neighborhood_id'];
    if (json['category_id'] != null) {
      categoryId = <CategoryId>[];
      json['category_id'].forEach((v) {
        categoryId!.add(CategoryId.fromJson(v));
      });
    }
    idNumber = json['id_number'];
    commercialRegisterationNumber = json['commercial_registeration_number'];
    hasSpecialRequests = json['has_special_requests'];
    firebaseToken = json['firebase_token'];
    password = json['password'];
    whatsappNumber = json['whatsapp_number'];
    phoneNumber = json['phone_number'];
    personalPhoto = json['personal_photo'];
    currentLanguage = json['current_language'];
    status = json['status'];
    stories =
    json['stories'] != null ? Stories.fromJson(json['stories']) : null;
  }

}

class CategoryId {
  String? id;
  String? image;
  String? name;

  CategoryId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

}

