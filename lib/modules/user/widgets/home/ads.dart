import 'package:easy_localization/easy_localization.dart';
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
  ADSWidget(this.closeTop);

  bool closeTop;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity:closeTop?0:1,
      duration: Duration(milliseconds: 500),
      child: AnimatedContainer(
        height: closeTop?0:156,
        duration: Duration(milliseconds: 500),
        child: ListView.separated(
            itemBuilder: (c,i)=>ADSItem(UserCubit.get(context).homeModel!.data!.advertisements![i],closeTop),
            separatorBuilder: (c,i)=>const SizedBox(width: 20,),
            padding:const EdgeInsetsDirectional.only(start: 20),
            scrollDirection: Axis.horizontal,
            itemCount: UserCubit.get(context).homeModel!.data!.advertisements!.length
        ),
      ),
    );
  }
}

class ADSItem extends StatelessWidget {
  ADSItem(this.ad,this.closeTop);
  Advertisements ad;
  bool closeTop;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:ad.type==2?(){
        openUrl(ad.link??'');
      }:null,
      child: AnimatedContainer(
        height: closeTop?0:154,width: size!.width*.85,
        duration: Duration(milliseconds: 500),
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
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ad.title??'',
                      maxLines: 2,
                      style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500,height: 1.2),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      ad.description??'',
                      maxLines: 2,
                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,height: 1.2),
                    ),
                    const SizedBox(height: 10,),
                    if(ad.type==2)
                    Container(
                      height: 28,width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(23),
                        border: Border.all(color: defaultColor)
                      ),
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        tr('get_now'),
                        style: TextStyle(color: defaultColor,fontSize: 12,fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
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

