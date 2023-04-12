import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:wee_made/modules/auth/auth_cubit/auth_states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/default_form.dart';
import '../../../widgets/auth_screen.dart';
import '../../auth/login_screen.dart';
import '../widgets/auth/category_form.dart';
import '../widgets/auth/dropdownfield.dart';
import '../widgets/auth/spcial_request.dart';

class PSignUpScreen extends StatelessWidget {
  PSignUpScreen({Key? key}) : super(key: key);

  TextEditingController ownerNameC = TextEditingController();
  TextEditingController storeNameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController cPasswordC = TextEditingController();
  TextEditingController categoryC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController commercialC = TextEditingController();
  List<String> categoryValues = [];
  SpecialRequest specialRequest = SpecialRequest();
  late CustomDropDownField neighborhoodDropDown;
  late CustomDropDownField cityDropDown;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthCubit.get(context).getCities();
    AuthCubit.get(context).getCategory();
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if(state is CreateProviderSuccessState)navigateAndFinish(context, LoginScreen());
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
                    hint: tr('owner_name'),
                    controller: ownerNameC,
                    validator: (val){
                      if(val.isEmpty)return tr('name_empty');
                    },
                  ),
                  const SizedBox(height: 20,),
                  DefaultForm(
                    hint: tr('family_name'),
                    controller: storeNameC,
                    validator: (val){
                      if(val.isEmpty)return tr('name_empty');
                    },
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
                    type: TextInputType.emailAddress,
                    controller: emailC,
                    validator: (val){
                      if(val.isEmpty)return tr('email_empty');
                      if(!val.contains('.'))return tr('email_invalid');
                      if(!val.contains('@'))return tr('email_invalid');
                    },
                  ),
                  const SizedBox(height: 20,),
                  ConditionalBuilder(
                      condition: cubit.citiesModel!=null,
                      fallback: (context)=>const SizedBox(height: 20,),
                      builder: (context){
                        cityDropDown = CustomDropDownField(
                          value: cubit.cityValue,
                          list: cubit.citiesModel!.data!,
                          hint: tr('city'),
                          isCity: true,
                        );
                        return cityDropDown;
                      }
                  ),
                  ConditionalBuilder(
                      condition: cubit.neighborhoodModel!=null,
                      fallback: (context)=>const SizedBox(height: 20,),
                      builder: (context){
                        neighborhoodDropDown = CustomDropDownField(
                          value: cubit.neighborhoodValue,
                          list: cubit.neighborhoodModel!.data!,
                          isNe: true,
                          hint: tr('neighborhood'),
                        );
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: neighborhoodDropDown,
                        );
                      }
                  ),
                  ConditionalBuilder(
                    condition: cubit.categoryModel!=null,
                    fallback: (context)=> const SizedBox(height: 20,),
                    builder: (context)=> ChooseCategory(
                      controller: categoryC,
                      values: categoryValues,
                      data:cubit.categoryModel!.data!,
                      validator: (str){
                        if(str.isEmpty)return tr('category_empty');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: DefaultForm(
                      hint: tr('commercial_registration'),
                      type: TextInputType.number,
                      controller: commercialC,
                      digitsOnly: true,
                      validator: (val){
                        if(val.isEmpty)return tr('commercial_registration_empty');
                      },
                    ),
                  ),
                  DefaultForm(
                    hint: tr('id_number'),
                    type: TextInputType.number,
                    controller: idC,
                    digitsOnly: true,
                    validator: (val){
                      if(val.isEmpty)return tr('id_number_empty');
                    },
                  ),
                  const SizedBox(height: 20,),
                  specialRequest,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: DefaultForm(
                      controller: passwordC,
                      hint: tr('password'),
                      obscureText: cubit.showPassword,
                      suffix: IconButton(
                        icon: Icon(
                          cubit.showPassword?Icons.visibility:Icons.visibility_off,
                          color: defaultColor,
                        ),
                        onPressed: ()=>cubit.changeShowPassword(),
                      ),
                      validator: (val){
                        if(val.isEmpty)return tr('password_empty');
                      },                      type: TextInputType.visiblePassword,
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
                          color: defaultColor,
                        ),
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
                  state is! CreateProviderLoadingState?
                  DefaultButton(
                      text: tr('sign_up'),
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          if(cubit.cityValue!=null){
                            if(cubit.neighborhoodValue!=null){
                              cubit.createProvider(
                                  phone: phoneC.text,
                                  storeName: storeNameC.text,
                                  ownerName: ownerNameC.text,
                                  email: emailC.text,
                                  cityId: cubit.cityValue!,
                                  neighborhoodId: cubit.neighborhoodValue!,
                                  idNum: idC.text,
                                  commercial: commercialC.text,
                                  special: specialRequest.currentIndex,
                                  password: passwordC.text,
                                  categories: categoryValues
                              );
                            }
                          }else{
                            showToast(msg: 'Information Not Completed');
                          }
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
