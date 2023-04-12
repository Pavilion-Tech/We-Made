import 'package:flutter/material.dart';
import 'package:wee_made/models/user/order_model.dart';
import 'package:wee_made/shared/components/constants.dart';

import '../../../../../models/user/cart_model.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../widgets/image_net.dart';


class OrderListProducts extends StatelessWidget {
  OrderListProducts(this.products);
  List<Products> products;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: products.length == 1?210:460,
      child: ListView.separated(
          itemBuilder: (c,i)=>OrderItem(products[i]),
          padding:const EdgeInsets.all(20),
          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
          itemCount: products.length
      ),
    );
  }
}


class OrderItem extends StatelessWidget {
  OrderItem(this.product);
  Products product;
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
          child: ImageNet(image: product.image??''),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 15,top: 15,end: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title??'',
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w700),
                ),
                Text(
                  '${product.totalRate} AED',
                  style: TextStyle(color: defaultColor,fontSize: 25,fontWeight: FontWeight.w700),
                ),
                Text(
                  'X${product.orderedQuantity}',
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      '${product.totalRate}',
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

