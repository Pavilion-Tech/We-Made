import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:wee_made/modules/auth/auth_cubit/auth_states.dart';
import 'package:wee_made/modules/auth/login_screen.dart';
import 'package:wee_made/shared/styles/colors.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/default_form.dart';
import '../../../widgets/auth_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController cPasswordC = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if(state is CreateUserSuccessState)navigateAndFinish(
            context, LoginScreen());
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return AuthScreen(
          title: tr('sign_up'),
          lastText: tr('have_account'),
          lastTap: () => navigateAndFinish(context, LoginScreen()),
          widget: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  DefaultForm(
                    hint: tr('name'),
                    controller: nameC,
                    validator: (val){
                      if(val.isEmpty)return tr('name_empty');
                    },
                    prefix: Image.asset(Images.person, width: 1,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: DefaultForm(
                      hint: tr('phone'),
                      controller: phoneC,
                      textLength: 10,
                      digitsOnly: true,
                      validator: (val){
                        if(val.isEmpty)return tr('phone_empty');
                      },
                      type: TextInputType.phone,
                      prefix: Image.asset(Images.flag, width: 1,),
                    ),
                  ),
                  DefaultForm(
                    hint: tr('email'),
                    controller: emailC,
                    validator: (val){
                      if(val.isEmpty)return tr('email_empty');
                      if(!val.contains('.'))return tr('email_invalid');
                      if(!val.contains('@'))return tr('email_invalid');
                    },
                    type: TextInputType.emailAddress,
                    prefix: Image.asset(Images.email, width: 1,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: DefaultForm(
                      controller: passwordC,
                      hint: tr('password'),
                      obscureText: cubit.showPassword,
                      suffix: IconButton(
                        icon: Icon(
                          cubit.showPassword?Icons.visibility:Icons.visibility_off,
                          color: defaultColor,),
                        onPressed: ()=>cubit.changeShowPassword(),
                      ),
                      validator: (val){
                        if(val.isEmpty)return tr('password_empty');
                      },
                      type: TextInputType.visiblePassword,
                      prefix: Image.asset(Images.lock, width: 1, height: 1,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 33),
                    child: DefaultForm(
                      controller: cPasswordC,
                      hint: tr('c_password'),
                      obscureText: cubit.showCPassword,
                      suffix: IconButton(
                        icon: Icon(
                          cubit.showCPassword?Icons.visibility:Icons.visibility_off,
                          color: defaultColor,),
                        onPressed: ()=>cubit.changeShowCPassword(),
                      ),
                      validator: (val){
                        if(val.isEmpty)return tr('c_password_empty');
                        if(val != passwordC.text)return tr('password_Invalid');
                      },
                      type: TextInputType.visiblePassword,
                      prefix: Image.asset(Images.lock, width: 1, height: 1,),
                    ),
                  ),
                  state is! CreateUserLoadingState ?
                  DefaultButton(
                      text: tr('sign_up'),
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          AuthCubit.get(context).createUser(
                              phone: phoneC.text,
                              name: nameC.text,
                              email: emailC.text,
                              password: passwordC.text,
                              cPassword: cPasswordC.text
                          );
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
