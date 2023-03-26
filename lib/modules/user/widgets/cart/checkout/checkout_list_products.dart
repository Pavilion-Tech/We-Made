import 'package:flutter/material.dart';
import 'package:wee_made/shared/components/constants.dart';

import '../../../../../models/user/cart_model.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../widgets/image_net.dart';


class CheckoutListProducts extends StatelessWidget {
  CheckoutListProducts({this.carts});
  List<Cart>? carts;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 460,
      child: ListView.separated(
          itemBuilder: (c,i)=>CheckoutItem(carts![i]),
          padding:const EdgeInsets.all(20),
          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
          itemCount: carts!.length
      ),
    );
  }
}


class CheckoutItem extends StatelessWidget {
  CheckoutItem(this.cart);
  Cart cart;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 205,width: 177,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              color: defaultColor.withOpacity(.3)
          ),
          alignment: AlignmentDirectional.center,
          child: ImageNet(image: cart.productImage??''),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 15,top: 15,end: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.providerName??'',
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w700),
                ),
                Text(
                  '${cart.productPrice} AED',
                  style: TextStyle(color: defaultColor,fontSize: 25,fontWeight: FontWeight.w700),
                ),
                Text(
                  'X${cart.quantity}',
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      '${cart.productRate}',
                      maxLines: 1,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                    ),
                    Icon(Icons.star,color: defaultColor,)
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

