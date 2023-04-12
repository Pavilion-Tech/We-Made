import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wee_made/modules/user/widgets/shimmer/product_shimmer.dart';
import 'package:wee_made/modules/user/widgets/shimmer/stories_shimmer.dart';

import '../product/product_grid.dart';
import 'category_shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            StoriesShimmer(),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(43),
                      color: Colors.grey.shade300
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CategoryShimmer(),
            ),
            ProductShimmer()
          ],
        ),
      ),
    );
  }
}
