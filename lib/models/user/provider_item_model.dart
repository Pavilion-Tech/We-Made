
import 'home_model.dart';

class ProviderItemModel {
  String? message;
  bool? status;
  List<ProviderId>? data;

  ProviderItemModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ProviderId>[];
      json['data'].forEach((v) {
        data!.add(ProviderId.fromJson(v));
      });
    }
  }

}
