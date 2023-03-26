import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../shared/images/images.dart';
import '../shared/styles/colors.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({
    required this.title,
    required this.widget,
    required this.lastText,
    required this.lastTap,
    this.haveArrow = false
});

  String title;
  String lastText;
  VoidCallback lastTap;
  Widget widget;
  bool haveArrow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Image.asset(Images.backGround,fit: BoxFit.cover,width: double.infinity,),
          SafeArea(
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      if(haveArrow)
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: IconButton(
                            onPressed: ()=>Navigator.pop(context),
                            icon: Icon(Icons.arrow_back_ios_outlined)
                        ),
                      ),
                      Image.asset(Images.splash,height: 150,),
                      Text(
                        title,
                        style:const TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w600),
                      ),
                      widget,
                      Text(
                        tr('or'),
                        style: TextStyle(color: defaultColor,fontSize: 20,fontWeight: FontWeight.w600),
                      ),
                      Text(
                        tr('continue_with'),
                        style: TextStyle(color: defaultColor,fontSize: 13,fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Images.gmail,width: 54,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Image.asset(Images.facebook,width: 54,),
                            ),
                            Image.asset(Images.apple,width: 54,),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: lastTap,
                        child: Text(
                        lastText,
                        style: TextStyle(color: defaultColor,fontSize: 18,fontWeight: FontWeight.w600),
                      ),
                      )
                    ],
                  ),
                ),
              ),
          )
        ],
      ),
    );
  }
}
