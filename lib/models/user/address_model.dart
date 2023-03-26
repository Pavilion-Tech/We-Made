class AddressModel {
  String? message;
  bool? status;
  List<AddressData>? data;

  AddressModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add(AddressData.fromJson(v));
      });
    }
  }

}

class AddressData {
  String? id;
  String? userId;
  String? latitude;
  String? longitude;
  String? address;
  String? title;
  bool? isDefault;


  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    title = json['title'];
    isDefault = json['is_default'];
  }

}
