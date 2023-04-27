import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:wee_made/modules/auth/auth_cubit/auth_states.dart';

import '../shared/images/images.dart';
import '../shared/styles/colors.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({
    required this.title,
    required this.widget,
    required this.lastText,
    required this.lastTap,
    this.haveArrow = false,
    this.haveSocial = false
});

  String title;
  String lastText;
  VoidCallback lastTap;
  Widget widget;
  bool haveArrow;
  bool haveSocial;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = AuthCubit.get(context);
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
                      if(haveSocial)
                        Text(
                        tr('or'),
                        style: TextStyle(color: defaultColor,fontSize: 20,fontWeight: FontWeight.w600),
                      ),
                      if(haveSocial)
                        Text(
                        tr('continue_with'),
                        style: TextStyle(color: defaultColor,fontSize: 13,fontWeight: FontWeight.w600),
                      ),
                      if(haveSocial)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: ConditionalBuilder(
                          condition: state is! SocialLoadingState,
                          fallback: (context)=>Center(child: CupertinoActivityIndicator()),
                          builder: (context)=> Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: ()async{
                                  cubit.userCredential = await cubit.signInWithGoogle();
                                  if(cubit.userCredential!=null){
                                    cubit.socialLog(context);
                                  }
                                },
                                  child: Image.asset(Images.gmail,width: 54,)
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: InkWell(
                                    onTap: ()async{
                                      cubit.userCredential = await cubit.signInWithFacebook();
                                      if(cubit.userCredential!=null){
                                        cubit.socialLog(context);
                                      }
                                    },
                                    child: Image.asset(Images.facebook,width: 54,)
                                ),
                              ),
                              if(defaultTargetPlatform == TargetPlatform.iOS)
                              InkWell(
                                onTap: ()async{
                                  cubit.userCredential = await cubit.signInWithApple();
                                  if(cubit.userCredential!=null){
                                    cubit.socialLog(context);
                                  }
                                  },
                                  child: Image.asset(Images.apple,width: 54,)),
                            ],
                          ),
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
  },
);
  }
}
