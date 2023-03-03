import 'package:flutter/material.dart';

class PChatAppBar extends StatelessWidget {
  const PChatAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
