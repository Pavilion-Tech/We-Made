import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/models/user/cart_model.dart';

import '../../../../../models/user/coupon_model.dart';
import '../../../../../shared/styles/colors.dart';
class Invoice extends StatelessWidget {
  Invoice({
    this.isCheckout = false,
    required this.totalPrice,
    required this.tax,
    required this.subTotal,
    this.discount,
    this.type
});


  String subTotal;
  String tax;
  String totalPrice;
  int? type;
  dynamic discount;
  bool isCheckout;

  @override
  Widget build(BuildContext context) {
    if(isCheckout){
      if(discount!=null&& type !=null){
        if(type==1){
          totalPrice = (int.parse(totalPrice) - (int.parse(totalPrice)/discount).round()).toString();
        }else{
          totalPrice = (int.parse(totalPrice) - discount).toString();
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                tr('subtotal'),
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                '$subTotal AED',
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Text(
                tr('tax'),
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                '$tax AED',
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
              ),
            ],
          ),
          if(discount!=null&& type !=null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    tr('discount'),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text(
                    '${discount} ${type==1 ? '%':'AED'}',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10),
            child: Container(
              color: Colors.grey,
              height: 1,width: double.infinity,
            ),
          ),
          Row(
            children: [
              Text(
                tr('total_order'),
                style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,color: Colors.black),
              ),
              const Spacer(),
              Text(
                '$totalPrice AED',
                style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600,color: defaultColor),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
