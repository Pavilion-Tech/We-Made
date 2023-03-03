import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/modules/intro/join_us_screen.dart';
import 'package:wee_made/modules/user/auth/sign_up_screen.dart';
import 'package:wee_made/modules/auth/verification_sheet.dart';

import '../../shared/components/components.dart';
import '../../shared/images/images.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_form.dart';
import '../../widgets/auth_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: tr('sign_in'),
      lastText: tr('register_now'),
      lastTap: ()=>navigateTo(context, JoinUsScreen()),
      widget: Padding(
        padding: const EdgeInsets.only(top: 15.0,bottom: 20),
        child: Column(
          children: [
            DefaultForm(
              hint: tr('email'),
              type: TextInputType.emailAddress,
              prefix: Image.asset(Images.email,width: 1,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25,bottom: 59),
              child: DefaultForm(
                hint: tr('password'),
                type: TextInputType.visiblePassword,
                prefix: Image.asset(Images.lock,width: 1,height: 1,),
              ),
            ),
            DefaultButton(
                text: tr('sign_in'),
                onTap: (){
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled : true,
                      shape:const RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(20),
                          topStart: Radius.circular(20),
                        )
                      ),
                      builder: (context)=>VerificationSheet()
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
