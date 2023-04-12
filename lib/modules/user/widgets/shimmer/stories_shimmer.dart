import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoriesShimmer extends StatelessWidget {
  const StoriesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (c,i)=> Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey.shade300,
            child: Container(
              height: 72,
              width: 72,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
          ),
          separatorBuilder: (c,i)=>const SizedBox(width: 10,),
          itemCount: 3
      ),
    );
  }
}
