class CartModel {
  String? message;
  bool? status;
  CartData? data;


  CartModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;
  }
}

class CartData {
  List<Cart>? cart;
  InvoiceSummary? invoiceSummary;

  CartData.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(Cart.fromJson(v));
      });
    }
    invoiceSummary = json['invoice_summary'] != null
        ? InvoiceSummary.fromJson(json['invoice_summary'])
        : null;
  }

}

class Cart {
  String? id;
  int? quantity;
  String? productTitle;
  int? productAvailableQuantity;
  dynamic productRate;
  String? productImage;
  dynamic productPrice;
  String? providerName;
  String? productId;
  String? macAddress;
  String? userId;


  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    productTitle = json['product_title'];
    productAvailableQuantity = json['product_available_quantity'];
    productRate = json['product_rate'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    providerName = json['provider_name'];
    productId = json['product_id'];
    macAddress = json['mac_address'];
    userId = json['user_id'];
  }

}

class InvoiceSummary {
  int? subTotalPrice;
  int? shippingCharges;
  int? totalPrice;

  InvoiceSummary.fromJson(Map<String, dynamic> json) {
    subTotalPrice = json['sub_total_price'];
    shippingCharges = json['shipping_charges'];
    totalPrice = json['total_price'];
  }

}
