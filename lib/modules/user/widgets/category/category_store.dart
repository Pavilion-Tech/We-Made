
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/models/user/home_model.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../widgets/image_net.dart';
import '../../category/category_screen.dart';

class CategorStoreyWidget extends StatefulWidget {
  CategorStoreyWidget(this.categoryData,this.providerId);
  List<Categories> categoryData;
  String providerId;

  @override
  State<CategorStoreyWidget> createState() => _CategorStoreyWidgetState();
}

class _CategorStoreyWidgetState extends State<CategorStoreyWidget> {

  @override
  void initState() {
    UserCubit.get(context).currentCategory = widget.categoryData[0].title??'';
    UserCubit.get(context).getProductProvider(
      widget.providerId,
        widget.categoryData[0].id??''
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 127,
      child: ListView.separated(
          itemBuilder: (c,i)=>CategoryItem(widget.categoryData[i],widget.providerId),
          separatorBuilder: (c,i)=>const SizedBox(width: 20,),
          padding: EdgeInsetsDirectional.only(start: 0),
          scrollDirection: Axis.horizontal,
          itemCount: widget.categoryData.length
      ),
    );
  }
}


class CategoryItem extends StatefulWidget {
  CategoryItem(this.categoryData,this.providerId);
  Categories categoryData;
  String providerId;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          UserCubit.get(context).currentCategory = widget.categoryData.title??'';
          UserCubit.get(context).getProductProvider(widget.categoryData.id??'',widget.providerId);
        });
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
            ImageNet(image:widget.categoryData.image??'',width: 68,height: 79,),
            Text(
              widget.categoryData.title??'',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

