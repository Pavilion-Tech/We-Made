import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (c,i)=>Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              height: 205,width: 177,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  color: Colors.grey.shade300
              ),
            ),
          ),
          padding:const EdgeInsets.only(right: 20,left: 20,bottom: 150),
          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
          itemCount: 3
      ),
    );
  }
}
