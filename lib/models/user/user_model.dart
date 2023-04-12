class UserModel {
  String? message;
  bool? status;
  UserData? data;


  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

}

class UserData {
  String? id;
  int? itemNumber;
  String? name;
  String? phoneNumber;
  String? whatsappNumber;
  String? currentLatitude;
  String? currentLongitude;
  String? firebaseToken;
  String? currentLanguage;
  String? personalPhoto;
  String? email;
  int? status;
  String? defaultUserAddressTitle;
  String? apiToken;


  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemNumber = json['item_number'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    whatsappNumber = json['whatsapp_number'];
    currentLatitude = json['current_latitude'];
    currentLongitude = json['current_longitude'];
    firebaseToken = json['firebase_token'];
    currentLanguage = json['current_language'];
    personalPhoto = json['personal_photo'];
    email = json['email'];
    status = json['status'];
    defaultUserAddressTitle = json['default_user_address_title'];
    apiToken = json['api_token'];
  }

}
