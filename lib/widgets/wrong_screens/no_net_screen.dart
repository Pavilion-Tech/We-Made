import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_layout.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';

class NoNetScreen extends StatelessWidget {
  NoNetScreen({this.isUser = true});
  bool isUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Images.noNet,width: size!.width*.5,),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    tr('no_net_title'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 21),
                  ),
                ),
                Text(
                  tr('no_net_desc'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                ),
                const SizedBox(height: 20,),
                DefaultButton(
                    text: tr('reload'),
                    onTap: (){
                      if(isUser){
                        if(token!=null){
                          UserCubit.get(context).getHome();
                          UserCubit.get(context).getCart();
                          MenuCubit.get(context).init();
                        }else{
                          UserCubit.get(context).getHome();
                          UserCubit.get(context).getCart();
                        }
                        navigateAndFinish(context, UserLayout());
                      }
                    }
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
