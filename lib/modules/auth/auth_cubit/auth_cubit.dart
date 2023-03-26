import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/auth/auth_cubit/auth_states.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/network/local/cache_helper.dart';
import 'package:wee_made/shared/network/remote/dio.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/network/remote/end_point.dart';

class AuthCubit extends Cubit<AuthStates>{

  AuthCubit():super(InitState());

  static AuthCubit get (context)=>BlocProvider.of(context);

  bool showLoginPassword = true;
  bool showPassword = true;
  bool showCPassword = true;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  void changeShowPassword(){
    showPassword = !showPassword;
    emit(EmitState());
  }
  void changeShowLoginPassword(){
    showLoginPassword = !showLoginPassword;
    emit(EmitState());
  }
  void changeShowCPassword(){
    showCPassword = !showCPassword;
    emit(EmitState());
  }

  void createUser({
    required String phone,
    required String name,
    required String email,
    required String password,
    required String cPassword,
}){
    emit(CreateUserLoadingState());
    DioHelper.postData(
      url:createUserUrl,
      lang: myLocale,
      data: {
        'phone_number':phone,
        'name':name,
        'email':email,
        'password':password,
        'confirm_password':cPassword,
        'firebase_token':'fcmToken',
        'current_language':myLocale,
        'mobile_MAC_address':uuid,
      }
    ).then((value) {
      if(value.data['data']!=null){
        showToast(msg: value.data['message']);
        emit(CreateUserSuccessState());
      }else{
        showToast(msg: value.data['message']);
        emit(CreateUserWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(CreateUserErrorState());
    });
  }

  void createProvider({
    required String phone,
    required String storeName,
    required String email,
    required String password,
    required String cPassword,
  }){
    print(storeName);
    emit(CreateProviderLoadingState());
    DioHelper.postData(
        url:createProviderUrl,
        lang: myLocale,
        data: {
          'phone_number':phone,
          'name':storeName,
          'email':email,
          'password':password,
          'confirm_password':cPassword,
          'firebase_token':'fcmToken',
          'current_language':myLocale,
          'mobile_MAC_address':uuid,
        }
    ).then((value) {
      print(value.data);
      if(value.data['data']!=null&&value.data['status'] == true){
        showToast(msg: value.data['message']);
        emit(CreateProviderSuccessState());
      }else if(value.data['data']!=null&&value.data['status'] == false){
        showToast(msg: value.data['data'].toString());
        emit(CreateProviderWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(CreateProviderErrorState());
    });
  }

  void login(){
    emit(LoginLoadingState());
    DioHelper.postData(
        url:loginUrl,
        lang: myLocale,
        data: {
          'email':emailC.text,
          'password':passwordC.text,
        }
    ).then((value) {
      if(value.data['data']!=null){
        code = value.data['data']['code'];
        userId = value.data['data']['user_id'];
        emit(LoginSuccessState());
      }else{
        showToast(msg: value.data['message']);
        emit(LoginWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(LoginErrorState());
    });
  }

  void verify(){
    emit(VerifyLoadingState());
    DioHelper.postData(
        url:verifyUrl,
        lang: myLocale,
        data: {
          'user_id':userId,
          'code':code,
        }
    ).then((value) {
      if(value.data['data']!=null){
        token = value.data['data']['token'];
        userType =  value.data['data']['user_type'];
        CacheHelper.saveData(key: 'userType', value: userType);
        CacheHelper.saveData(key: 'token', value: token);
        CacheHelper.saveData(key: 'userId', value: userId);
        emailC.text = '';
        passwordC.text = '';
        emit(VerifySuccessState());
      }else{
        showToast(msg: value.data['message']);
        emit(VerifyWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(VerifyErrorState());
    });
  }


}