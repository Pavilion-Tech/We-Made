import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/styles/colors.dart';
import 'checkout_special.dart';

PreferredSizeWidget chatAppBar(context){
  var data = MenuCubit.get(context).chatModel!.data!;
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    leading: IconButton(
      onPressed: ()=>Navigator.pop(context),
      icon: Icon(Icons.arrow_back,color: Colors.black,),
    ),
    title: Text(
      MenuCubit.get(context).chatModel!=null
          ? MenuCubit.get(context).chatModel!.data!.providerName??''
          :'Product Name',
      style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26,color: Colors.black),),
    actions: [
      if(data.specialRequestOffer!=null)
        InkWell(
          onTap: (){
            navigateTo(context, CheckoutSpecial(data.id??'',data.specialRequestOffer));
          },
          child: Container(
            height: 41,
            decoration: BoxDecoration(
              color: defaultColor,
              borderRadius: BorderRadiusDirectional.circular(12),
            ),
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '${tr('pay')} | ${data.specialRequestOffer} AED',
              style:const TextStyle(
                  color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
    ],
  );
}
