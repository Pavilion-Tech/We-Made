import 'package:flutter/material.dart';
import 'package:wee_made/shared/components/constants.dart';

import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';


class CheckoutListProducts extends StatelessWidget {
  CheckoutListProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 460,
      child: ListView.separated(
          itemBuilder: (c,i)=>CheckoutItem(listImages[i]),
          padding:const EdgeInsets.all(20),
          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
          itemCount: listImages.length
      ),
    );
  }
}


class CheckoutItem extends StatelessWidget {
  CheckoutItem(this.image);
  String image;
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
          child: Image.asset(image),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 15,top: 15,end: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name Name',
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w700),
                ),
                Text(
                  '15 AED',
                  style: TextStyle(color: defaultColor,fontSize: 25,fontWeight: FontWeight.w700),
                ),
                Text(
                  'X2',
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      '4.5',
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

