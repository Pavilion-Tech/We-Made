import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/models/user/home_model.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../widgets/image_net.dart';
import '../../../provider/menu/manage_product/edit_product_screen.dart';
import '../../../provider/menu/manage_product/pproduct_screen.dart';
import '../../product/product_screen.dart';
import '../cart/cart_dialog.dart';

class ProductShimmer extends StatelessWidget {
  ProductShimmer({
    this.padding = 20,
    this.isScroll = true,
    this.isProvider = false,
  });
  double padding;
  bool isScroll;
  bool isProvider;

  @override
  Widget build(BuildContext context) {
    double currentSize = size!.height> 800 ?size!.width / (size!.height / 1.73):size!.width / (size!.height / 1.45);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:padding),
      child: GridView.builder(
        physics: isScroll?const NeverScrollableScrollPhysics():null,
        shrinkWrap: true,
        padding: EdgeInsetsDirectional.only(bottom: 100),
        itemBuilder: (c,i)=>Shimmer.fromColors(
          highlightColor: Colors.white,baseColor: Colors.grey.shade300,
          child: Container(
            height: 177,
            width: 205,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                color: Colors.grey.shade300
            ),
            padding:const EdgeInsets.symmetric(horizontal: 15),
            alignment: AlignmentDirectional.center,
          ),
        ),
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 30,mainAxisSpacing: 30,
          childAspectRatio: currentSize,
        ),
      ),
    );
  }
}


