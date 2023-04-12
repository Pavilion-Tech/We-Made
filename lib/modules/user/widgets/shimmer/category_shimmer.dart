import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 127,
      child: ListView.separated(
          itemBuilder: (c,i)=>Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              width: 110,height: 127,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadiusDirectional.circular(15),
              ),
            ),
          ),
          separatorBuilder: (c,i)=>const SizedBox(width: 20,),
          padding: EdgeInsetsDirectional.only(start: 20),
          scrollDirection: Axis.horizontal,
          itemCount: 3
      ),
    );
  }
}
