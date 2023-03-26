class OrderHisModel {
  String? message;
  bool? status;
  OrderHisData? data;

  OrderHisModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? OrderHisData.fromJson(json['data']) : null;
  }
}

class OrderHisData {
  int? currentPage;
  int? pages;
  int? count;
  List<OrderData>? data;

  OrderHisData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
  }

}

class OrderData {
  String? id;
  int? status;
  int? itemNumber;
  int? orderType;
  String? userLatitude;
  String? userLongitude;
  String? userOrderAddress;
  int? subTotalPrice;
  int? shippingCharges;
  int? totalPrice;
  String? createdAt;


  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    itemNumber = json['item_number'];
    orderType = json['order_type'];
    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    userOrderAddress = json['user_order_address'];
    subTotalPrice = json['sub_total_price'];
    shippingCharges = json['shipping_charges'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
  }
}
