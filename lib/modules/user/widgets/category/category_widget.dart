
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/models/user/home_model.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../widgets/image_net.dart';
import '../../category/category_screen.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget(this.categoryData,{this.padding=20,this.closeCategory = false});
  double padding;
  List<Categories> categoryData;
  bool closeCategory;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: closeCategory?50:127,
      duration: Duration(milliseconds: 500),
      child: ListView.separated(
          itemBuilder: (c,i)=>CategoryItem(categoryData[i],closeCategory),
          separatorBuilder: (c,i)=>const SizedBox(width: 20,),
          padding: EdgeInsetsDirectional.only(start: padding),
          scrollDirection: Axis.horizontal,
          itemCount: categoryData.length
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  CategoryItem(this.categoryData,this.closeCategory);
  Categories categoryData;
  bool closeCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        UserCubit.get(context).getProductCategory(categoryData.id??'');
        navigateTo(context, CategoryScreen(categoryData.title??''));
        },
      child: AnimatedContainer(
        width: 110,height:closeCategory?50: 127,
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.circular(15),
        ),
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity:closeCategory?0:1,
              duration: Duration(milliseconds: 500),
              child: AnimatedContainer(
                  width: closeCategory?0:68,height:closeCategory?0: 79,
                  duration: Duration(milliseconds: 500),
                  child: ImageNet(image:categoryData.image??'',width: 68,height: 79,)),
            ),
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

