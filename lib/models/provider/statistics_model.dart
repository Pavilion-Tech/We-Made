class StatisticsModel {
  String? message;
  bool? status;
  List<Data>? data;

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

}

class Data {
  String? month;
  int? value;

  Data.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    value = json['value'];
  }

}
