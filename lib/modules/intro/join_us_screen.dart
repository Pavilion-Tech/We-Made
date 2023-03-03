import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_layout.dart';
import 'package:wee_made/modules/auth/login_screen.dart';
import 'package:wee_made/modules/user/auth/sign_up_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/images/images.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../../widgets/default_button.dart';
import '../provider/auth/psign_up_screen.dart';

class JoinUsScreen extends StatefulWidget {
  const JoinUsScreen({Key? key}) : super(key: key);

  @override
  State<JoinUsScreen> createState() => _JoinUsScreenState();
}

class _JoinUsScreenState extends State<JoinUsScreen> {

  @override
  void initState() {
    joinUs = 'provider';
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround),
          SafeArea(
            child: Padding(
              padding:const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: TextButton(
                        onPressed: (){
                          navigateAndFinish(context, UserLayout());
                        },
                        child:Text(
                          tr('skip'),
                          style: TextStyle(color: defaultColor,fontSize: 17,fontWeight: FontWeight.w500),
                        )
                    ),
                  ),
                  const SizedBox(height: 100,),
                   Text(
                    tr('select_account'),
                    style:const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0,bottom: 30),
                    child: itemBuilder(
                      index: 0,
                      image: Images.joinAs1,
                      title: tr('family_title'),
                      desc: tr('family_desc')
                    ),
                  ),
                  itemBuilder(
                      index: 1,
                      image: Images.joinAs2,
                      title: tr('user_title'),
                      desc: tr('user_desc')
                  ),
                  const SizedBox(height: 20,),
                  DefaultButton(
                      text:tr('continue'),
                      onTap: (){
                        if(joinUs == 'provider'){
                          navigateAndFinish(context, PSignUpScreen());
                        }else{
                          navigateAndFinish(context, SignUpScreen());
                        }
                      }
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: (){
                        navigateTo(context, LoginScreen());
                      },
                      child:Text(
                      tr('dont_have_account'),
                        style: TextStyle(color: defaultColor,fontSize: 17,fontWeight: FontWeight.w500),
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuilder({
  required int index,
  required String image,
  required String title,
  required String desc,
}){
    return AnimatedSwitcher(
      duration:const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        key: ValueKey(currentIndex == index),
        onTap: (){
          setState(() {
            currentIndex = index;
            joinUs = index==0?'provider':'user';
          });
        },
        child: Container(
          height: 100,
          width: double.infinity,
          padding:const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(15),
            border: Border.all(color: currentIndex == index?defaultColor:Colors.grey.shade400)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(image,height: 74,width: 102,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    height: 74,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,fontWeight: FontWeight.w600,
                              color:currentIndex == index?defaultColor:Colors.grey.shade300,height: 1),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          desc,
                          maxLines: 3,
                          style:const TextStyle(fontSize: 12,height:1),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
