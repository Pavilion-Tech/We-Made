import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/default_form.dart';
import '../../../widgets/auth_screen.dart';
import '../../auth/login_screen.dart';

class PSignUpScreen extends StatelessWidget {
  const PSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: tr('sign_up'),
      lastText: tr('have_account'),
      lastTap: ()=>navigateAndFinish(context,LoginScreen()),
      widget: Padding(
        padding: const EdgeInsets.only(top: 15.0,bottom: 20),
        child: Column(
          children: [
            DefaultForm(
              hint: tr('name'),
              prefix: Image.asset(Images.person,width: 1,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: DefaultForm(
                hint: tr('phone'),
                type: TextInputType.phone,
                prefix: Image.asset(Images.flag,width: 1,),
              ),
            ),
            DefaultForm(
              hint: tr('email'),
              type: TextInputType.emailAddress,
              prefix: Image.asset(Images.email,width: 1,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: DefaultForm(
                hint: tr('password'),
                type: TextInputType.visiblePassword,
                prefix: Image.asset(Images.lock,width: 1,height: 1,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 33),
              child: DefaultForm(
                hint: tr('c_password'),
                type: TextInputType.visiblePassword,
                prefix: Image.asset(Images.lock,width: 1,height: 1,),
              ),
            ),
            DefaultButton(
                text: tr('sign_up'),
                onTap: (){}
            )
          ],
        ),
      ),
    );
  }
}
