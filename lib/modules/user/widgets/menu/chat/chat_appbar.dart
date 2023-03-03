import 'package:flutter/material.dart';

PreferredSizeWidget chatAppBar(context){
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    leading: IconButton(
      onPressed: ()=>Navigator.pop(context),
      icon: Icon(Icons.arrow_back,color: Colors.black,),
    ),
    title: Text('Product Name',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26,color: Colors.black),),
  );
}
