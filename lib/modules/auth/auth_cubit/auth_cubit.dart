import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
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
        }else{
          if(ProviderCubit.get(context).providerModel!=null){
            ProviderCubit.get(context).getProvider();
            ProviderCubit.get(context).getStatistics();
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
    emit(GetNeighborhoodLoadingState());
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

  UserCredential? userCredential;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }


  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  void socialLog(BuildContext context){
    emit(SocialLoadingState());
    DioHelper.postData(
        url:socialLogUrl,
        lang: myLocale,
        data: {
          'email':userCredential!.user!.email??'',
          'name':userCredential!.user!.displayName??'',
          'social_id':userCredential!.user!.uid,
        }
    ).then((value) {
      print(value.data);
      if(value.data['data']!=null){
        token = value.data['data']['token'];
        if(UserCubit.get(context).homeModel!=null){
          UserCubit.get(context).getHome();
          UserCubit.get(context).getCart();
          MenuCubit.get(context).init();
        }
        userType = 'user';
        CacheHelper.saveData(key: 'userType', value: userType);
        CacheHelper.saveData(key: 'token', value: token);
        emit(SocialSuccessState());
      }else{
        showToast(msg: value.data['message']);
        emit(SocialWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(SocialErrorState());
    });
  }


}