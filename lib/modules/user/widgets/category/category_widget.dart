import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../category/category_screen.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({this.padding=20});
  double padding;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112,
      child: ListView.separated(
          itemBuilder: (c,i)=>CategoryItem(listImages[i]),
          separatorBuilder: (c,i)=>const SizedBox(width: 20,),
          padding: EdgeInsetsDirectional.only(start: padding),
          scrollDirection: Axis.horizontal,
          itemCount: listImages.length
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  CategoryItem(this.image);
  String image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>navigateTo(context, CategoryScreen()),
      child: Container(
        width: 110,height: 127,
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.circular(15),
        ),
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image,width: 68,height: 79,),
            Text(
                'Clothes'
            ),
          ],
        ),
      ),
    );
  }
}

