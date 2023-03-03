import 'package:flutter/material.dart';

import '../../../../../shared/styles/colors.dart';

PreferredSizeWidget orderAppbar(context){
  return AppBar(
    centerTitle: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      Padding(
        padding:const EdgeInsetsDirectional.only(end: 20,top: 10),
        child: Text(
          'Processing',
          style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 18),
        ),
      ),
    ],
    leading:  IconButton(
      onPressed: ()=>Navigator.pop(context),
      icon:const Icon(Icons.arrow_back,color: Colors.black,),
    ),
    title: Text(
      '265598',
      style:const TextStyle(fontWeight: FontWeight.w700,fontSize: 26,color: Colors.black),
    ),
  );
}
