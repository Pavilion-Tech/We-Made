import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/models/user/cart_model.dart';

import '../../../../../shared/styles/colors.dart';
class Invoice extends StatelessWidget {
  Invoice({
    required this.totalPrice,
    required this.tax,
    required this.subTotal,
});


  String subTotal;
  String tax;
  String totalPrice;

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 10,),
          Row(
            children: [
              Text(
                tr('app_fee'),
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                '10 AED',
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Text(
                tr('deposit'),
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                '10 AED',
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
              ),
            ],
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
