class SingleOrderModel {
  String? message;
  bool? status;
  SingleOrderData? data;


  SingleOrderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?  SingleOrderData.fromJson(json['data']) : null;
  }


}

class SingleOrderData {
  String? id;
  int? itemNumber;
  int? status;
  int? orderType;
  String? userLatitude;
  String? userLongitude;
  String? userOrderAddress;
  String? userName;
  String? userPhone;
  String? providerName;
  String? providerPhone;
  List<Products>? products;
  int? subTotalPrice;
  int? shippingCharges;
  int? totalPrice;
  String? createdAt;


  SingleOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemNumber = json['item_number'];
    status = json['status'];
    orderType = json['order_type'];
    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    userOrderAddress = json['user_order_address'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    providerName = json['provider_name'];
    providerPhone = json['provider_phone'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    subTotalPrice = json['sub_total_price'];
    shippingCharges = json['shipping_charges'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
  }
}

class Products {
  String? id;
  String? title;
  String? image;
  int? totalRate;
  int? priceAfterDicount;
  int? orderedQuantity;


  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    totalRate = json['total_rate'];
    priceAfterDicount = json['price_after_dicount'];
    orderedQuantity = json['ordered_quantity'];
  }
}
