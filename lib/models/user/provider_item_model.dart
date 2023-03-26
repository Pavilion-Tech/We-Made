
class ProviderItemModel {
  String? message;
  bool? status;
  List<ProviderData>? data;

  ProviderItemModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ProviderData>[];
      json['data'].forEach((v) {
        data!.add(ProviderData.fromJson(v));
      });
    }
  }

}

class ProviderData {
  String? id;
  String? storeName;
  String? personalPhoto;


  ProviderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    personalPhoto = json['personal_photo'];

  }
}
