import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';

import '../../../../models/user/home_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../widgets/image_net.dart';
import '../../store/store_screen.dart';

class ADSWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      child: ListView.separated(
          itemBuilder: (c,i)=>ADSItem(UserCubit.get(context).homeModel!.data!.advertisements![i]),
          separatorBuilder: (c,i)=>const SizedBox(width: 20,),
          padding:const EdgeInsetsDirectional.only(start: 20),
          scrollDirection: Axis.horizontal,
          itemCount: UserCubit.get(context).homeModel!.data!.advertisements!.length
      ),
    );
  }
}

class ADSItem extends StatelessWidget {
  ADSItem(this.ad);
  Advertisements ad;

  void type(BuildContext context){
    switch(ad.type??0){
      case 2:
        openUrl(ad.link??'');
        break;
      case 3:
        //WafrCubit.get(context).getStore(ad.id??'');
        navigateTo(context, StoreScreen());
        break;
      case 4:
        //WafrCubit.get(context).getProduct(context,ad.id);
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        type(context);
      },
      child: Container(
        height: 154,width: size!.width*.85,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: defaultColor),
            borderRadius: BorderRadiusDirectional.circular(20),
        ),
        padding:const EdgeInsetsDirectional.fromSTEB(36, 0, 0, 0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ad.title??'',
                    maxLines: 1,
                    style: TextStyle(color: Colors.black,fontSize: 32,fontWeight: FontWeight.w500),
                  ),
                  Text(
                    ad.description??'',
                    maxLines: 2,
                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,height: 1),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 28,width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(23),
                      border: Border.all(color: defaultColor)
                    ),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Get Now',
                      style: TextStyle(color: defaultColor,fontSize: 12,fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            if(ad.backgroundImage!.isNotEmpty)
            Expanded(child: ImageNet(image: ad.backgroundImage!,))
          ],
        ),
      ),
    );
  }
}

