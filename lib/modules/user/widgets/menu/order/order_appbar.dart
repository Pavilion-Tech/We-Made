import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/styles/colors.dart';

PreferredSizeWidget orderAppbar(context,{int status = 1,int itemNumber = 1}){
  return AppBar(
    centerTitle: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      Padding(
        padding:const EdgeInsetsDirectional.only(end: 20,top: 10),
        child: Text(
          tr(status==1 ?'new_order' :status==2?'processing':status==3?'shipping':'done2'),
          style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 18),
        ),
      ),
    ],
    leading:  IconButton(
      onPressed: ()=>Navigator.pop(context),
      icon:const Icon(Icons.arrow_back,color: Colors.black,),
    ),
    title: Text(
      '$itemNumber',
      style:const TextStyle(fontWeight: FontWeight.w700,fontSize: 26,color: Colors.black),
    ),
  );
}
