
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/models/user/home_model.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../widgets/image_net.dart';
import '../../category/category_screen.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget(this.categoryData,{this.padding=20});
  double padding;
  List<Categories> categoryData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 127,
      child: ListView.separated(
          itemBuilder: (c,i)=>CategoryItem(categoryData[i]),
          separatorBuilder: (c,i)=>const SizedBox(width: 20,),
          padding: EdgeInsetsDirectional.only(start: padding),
          scrollDirection: Axis.horizontal,
          itemCount: categoryData.length
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  CategoryItem(this.categoryData);
  Categories categoryData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        UserCubit.get(context).getProductCategory(categoryData.id??'');
        navigateTo(context, CategoryScreen(categoryData.title??''));
        },
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
            ImageNet(image:categoryData.image??'',width: 68,height: 79,),
            Text(
              categoryData.title??'',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

