import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:wee_made/modules/auth/auth_cubit/auth_states.dart';
import 'package:wee_made/modules/intro/join_us_screen.dart';
import 'package:wee_made/modules/user/auth/sign_up_screen.dart';
import 'package:wee_made/modules/auth/verification_sheet.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/images/images.dart';
import '../../shared/styles/colors.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_form.dart';
import '../../widgets/auth_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({this.haveArrow = false});
  var formKey = GlobalKey<FormState>();
  bool haveArrow;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);
        if(state is LoginSuccessState){
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(20),
                    topStart: Radius.circular(20),
                  )
              ),
              builder: (context) => VerificationSheet()
          );
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return AuthScreen(
          title: tr('sign_in'),
          haveArrow: haveArrow,
          lastText: tr('register_now'),
          lastTap: () => navigateTo(context, JoinUsScreen()),
          widget: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  DefaultForm(
                    hint: tr('email'),
                    type: TextInputType.emailAddress,
                    controller: cubit.emailC,
                    validator: (val) {
                      if (val.isEmpty) return tr('email_empty');
                      if (!val.contains('.')) return tr('email_invalid');
                      if (!val.contains('@')) return tr('email_invalid');
                    },
                    prefix: Image.asset(Images.email, width: 1,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 59),
                    child: DefaultForm(
                      controller: cubit.passwordC,
                      hint: tr('password'),
                      obscureText: cubit.showLoginPassword,
                      suffix: IconButton(
                        icon: Icon(
                          cubit.showLoginPassword ? Icons.visibility : Icons
                              .visibility_off,
                          color: defaultColor,
                        ),
                        onPressed: () => cubit.changeShowLoginPassword(),
                      ),
                      validator: (val) {
                        if (val.isEmpty) return tr('password_empty');
                      },
                      type: TextInputType.visiblePassword,
                      prefix: Image.asset(Images.lock, width: 1, height: 1,),
                    ),
                  ),
                  state is! LoginLoadingState?
                  DefaultButton(
                      text: tr('sign_in'),
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          cubit.login();
                        }
                      }
                  ):const Center(child: CircularProgressIndicator(),)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
