import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerShared extends StatelessWidget {
  const ShimmerShared({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (c,i)=>Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  color: Colors.grey.shade300
              ),
            ),
          ),
          padding:const EdgeInsetsDirectional.all(20),
          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
          itemCount: 5
      ),
    );
  }
}
