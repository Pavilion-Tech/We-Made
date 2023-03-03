import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../../provider/menu/manage_product/edit_product_screen.dart';
import '../../../provider/menu/manage_product/pproduct_screen.dart';
import '../../product/product_screen.dart';
import '../cart/cart_dialog.dart';

class ProductGrid extends StatelessWidget {
  ProductGrid({this.padding = 20,this.isScroll = true,this.isProvider = false});
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
        itemBuilder: (c,i)=>ProductItem(listImages[i],isProvider: isProvider),
        itemCount: listImages.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 30,mainAxisSpacing: 30,
          childAspectRatio: currentSize,
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  ProductItem(this.image,{this.height = 177,required this.isProvider });
  String image;
  double height;
  bool isProvider;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(!isProvider)navigateTo(context, ProductScreen(image));
        else navigateTo(context, PProductScreen(image));
      },
      child: Container(
        height: height,
        width: 205,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          color: defaultColor.withOpacity(.3)
        ),
        padding:const EdgeInsets.symmetric(horizontal: 15),
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image,width: 124,height: 124,),
            Text(
              'Product Name',
              maxLines: 1,
              style:const TextStyle(fontSize: 15),
            ),
            Row(
              children: [
                Text(
                  '15 AED',
                  style:const TextStyle(color:Colors.black,fontSize: 18,fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                if(!isProvider)
                InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context)=>CartDialog());
                  },
                    child: Image.asset(Images.add,width: 20,height: 20,)
                ),
                if(isProvider)
                  InkWell(
                      onTap: (){
                        navigateTo(context, EditProductScreen());
                      },
                      child: Image.asset(Images.edit2,width: 20,height: 20,)
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

