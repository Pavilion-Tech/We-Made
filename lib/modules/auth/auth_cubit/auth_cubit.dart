import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wee_made/modules/auth/auth_cubit/auth_states.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/network/local/cache_helper.dart';
import 'package:wee_made/shared/network/remote/dio.dart';

import '../../../layouts/user_layout/user_cubit/user_cubit.dart';
import '../../../models/category_model.dart';
import '../../../models/cities_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/remote/end_point.dart';
import '../../user/menu_screens/menu_cubit/menu_cubit.dart';

class AuthCubit extends Cubit<AuthStates>{

  AuthCubit():super(InitState());

  static AuthCubit get (context)=>BlocProvider.of(context);

  bool showLoginPassword = true;
  bool showPassword = true;
  bool showCPassword = true;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  CategoryModel? categoryModel;
  CitiesModel? citiesModel;
  NeighborhoodModel? neighborhoodModel;
  String? cityValue;
  String? neighborhoodValue;

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

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(EmitState());
    });
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
        'firebase_token':fcmToken,
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
    required String ownerName,
    required String email,
    required String cityId,
    required String neighborhoodId,
    required String idNum,
    required String commercial,
    required int special,
    required String password,
    required List<String> categories,
  }){
    Map <String,dynamic> map={
      'phone_number':phone,
      'store_name':storeName,
      'owner_name':ownerName,
      'email':email,
      'city_id':cityId,
      'neighborhood_id':neighborhoodId,
      'id_number':idNum,
      'commercial_registeration_number':commercial,
      'has_special_requests':special,
      'firebase_token':fcmToken,
      'password':password,
      'confirm_password':password,
      'current_language':myLocale,
    };

    for (int i = 0;  i < categories.length;i++){
      map.addAll({
        "category_id[$i]":categories[i]
      });
    }
    FormData formData = FormData.fromMap(map);
    emit(CreateProviderLoadingState());
    DioHelper.postData2(
        url:createProviderUrl,
        lang: myLocale,
        formData: formData
    ).then((value) {
      print(value.data);
      if(value.data['data']!=null&&value.data['status'] == true){
        showToast(msg: value.data['message']);
        emit(CreateProviderSuccessState());
      }else if(value.data['status'] == false){
        showToast(msg: value.data['message'].toString());
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

  void verify(BuildContext context){
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
        if(userType == 'user'){
          if(UserCubit.get(context).homeModel!=null){
            UserCubit.get(context).getHome();
            UserCubit.get(context).getCart();
            MenuCubit.get(context).init();
          }
        }
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

  void getCategory(){
    DioHelper.getData(
        url: cateUrl
    ).then((value) {
      if(value.data['data']!=null){
        categoryModel = CategoryModel.fromJson(value.data);
        emit(GetCategorySuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(GetCategoryWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(GetCategoryWrongState());
    });
  }

  void getCities (){
    DioHelper.getData(
        url: citiesUrl
    ).then((value) {
      if(value.data['data']!=null){
        citiesModel = CitiesModel.fromJson(value.data);
        emit(GetCitiesSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(GetCitiesWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(GetCitiesWrongState());
    });
  }

  void getNeighborhood(String id){
    DioHelper.getData(
        url: '$neighborhoodUrl$id'
    ).then((value) {
      print(value.data);
      if(value.data['data']!=null){
        neighborhoodModel = NeighborhoodModel.fromJson(value.data);
        emit(GetNeighborhoodSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(GetNeighborhoodWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(GetNeighborhoodWrongState());
    });
  }


}