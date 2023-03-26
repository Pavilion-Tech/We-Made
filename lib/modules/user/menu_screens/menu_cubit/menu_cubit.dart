import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/network/remote/dio.dart';

import '../../../../models/chathis_model.dart';
import '../../../../models/settings_model.dart';
import '../../../../models/static_page_model.dart';
import '../../../../models/user/address_model.dart';
import '../../../../models/user/order_his_model.dart';
import '../../../../models/user/order_model.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/network/remote/end_point.dart';
import '../../../../splash_screen.dart';
import 'menu_states.dart';

class MenuCubit extends Cubit<MenuStates>{
  MenuCubit():super(InitState());
  static MenuCubit get (context)=> BlocProvider.of(context);

  ImagePicker picker = ImagePicker();
  XFile? chatImage;
  XFile? profileImage;
  TextEditingController controller = TextEditingController();
  Position? position;
  AddressModel? addressModel;
  OrderHisModel? orderHisModel;
  ScrollController orderScrollController = ScrollController();
  SingleOrderModel? singleOrderModel;
  ChatHisModel? chatHisModel;
  StaticPageModel? staticPageModel;
  SettingsModel? settingsModel;


  Future<XFile?> pick(ImageSource source)async{
    try{
      return await picker.pickImage(source: source,imageQuality: 1);
    } catch(e){
      print(e.toString());
      emit(ImageWrong());
    }
  }

  void justEmit(){
    emit(JustEmitState());
  }


  Future<Position> checkPermissions() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {}
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //showToast(msg: 'Location permissions are denied', toastState: false);
        emit(GetCurrentLocationState());
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
    //  showToast(msg: 'Location permissions are permanently denied, we cannot request permissions.', toastState: false);
      await Geolocator.openLocationSettings();
      emit(GetCurrentLocationState());
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    await checkPermissions();
    await Geolocator.getLastKnownPosition().then((value) {
      print(value);
      if (value != null) {
        position = value;
        emit(GetCurrentLocationState());
      }
    });
  }

  Future<void> getAddress({LatLng? latLng,required TextEditingController controller}) async {
    if (latLng != null) {
      List<Placemark> place = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: 'ar');
      Placemark placeMark = place[0];
      controller.text = placeMark.street!;
      controller.text += ', ${placeMark.country!}';
      emit(GetCurrentLocationState());
    }
  }

  void getUser(){
    if(token!=null)
    DioHelper.getData(
        url: '$getUserUrl$userId',
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['data']!=null){
        // addressesModel = AddressesModel.fromJson(value.data);
        emit(GetUserSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(GetUserWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(GetUserErrorState());
    });
  }

  void updateUser({
  required String phone,
  required String name,
  required String email,
})async{
    emit(UpdateProfileLoadingState());
    FormData formData = FormData.fromMap({
      'phone_number':phone,
      'name':name,
      'email':email,
      'firebase_token':fcmToken,
    });
    if(profileImage !=null){
      File file = await FlutterNativeImage.compressImage(profileImage!.path,quality:1,);
      formData.files.add(
          MapEntry(
          'personal_photo',
          MultipartFile.fromFileSync(
              file.path,
              filename: file.path.split('/').last)
          ));
    }
    DioHelper.putData2(
      url: updateProfileUrl,
      formData: formData,
      token: 'Bearer $token'
    ).then((value) {
      if(value.data['status']==true){
        profileImage = null;
        showToast(msg: value.data['message']);
        emit(UpdateProfileSuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(UpdateProfileWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(UpdateProfileErrorState());
    });
  }

  void getAddresses(){
    DioHelper.getData(
        url: getAddressUrl,
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['data']!=null){
        addressModel = AddressModel.fromJson(value.data);
        emit(GetAddressesSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(GetAddressesWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(GetAddressesErrorState());
    });
  }

  void updateAddresses({
    required String lat,
    required String lng,
    required String title,
    required String addressId,
  }){
    emit(UpdateAddressesLoadingState());
    DioHelper.putData(
        url: '$updateAddressUrl$addressId',
        token:'Bearer $token',
        data: {
          'latitude':lat,
          'longitude':lng,
          'title':title,
        }
    ).then((value) {
      if(value.data['status'] == true){
        showToast(msg: value.data['message']);
        getAddresses();
        emit(UpdateAddressesSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(UpdateAddressesWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'),toastState: false);
      emit(UpdateAddressesErrorState());
    });
  }

  void addAddresses({
    required String lat,
    required String lng,
    required String title,
  }){
    emit(UpdateAddressesLoadingState());
    DioHelper.postData(
        url: addAddressUrl,
        token:'Bearer $token',
        data: {
          'latitude':lat,
          'longitude':lng,
          'title':title,
        }
    ).then((value) {
      if(value.data['status'] == true){
        showToast(msg: value.data['message']);
        getAddresses();
        emit(UpdateAddressesSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(UpdateAddressesWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'),toastState: false);
      emit(UpdateAddressesErrorState());
    });
  }


  void deleteAddresses({
    required String id,
  }){
    emit(UpdateAddressesLoadingState());
    DioHelper.deleteData(
      url: '$deleteAddressUrl$id',
      token:'Bearer $token',
    ).then((value) {
      if(value.data['status'] == true){
        showToast(msg: value.data['message']);
        getAddresses();
        emit(UpdateAddressesSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(UpdateAddressesWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'),toastState: false);
      emit(UpdateAddressesErrorState());
    });
  }

  void getAllOrder({int page = 1}){
    emit(AllOrderLoadingState());
    DioHelper.getData(
      url: orderHisUrl,
      token: 'Bearer $token',
      lang: myLocale
    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          orderHisModel = OrderHisModel.fromJson(value.data);
        }
        else{
          orderHisModel!.data!.currentPage = value.data['data']['currentPage'];
          orderHisModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            orderHisModel!.data!.data!.add(OrderData.fromJson(e));
          });
        }
        emit(AllOrderSuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        showToast(msg: tr('wrong'));
        emit(AllOrderWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(AllOrderErrorState());
    });
  }


  void paginationOrder(){
    orderScrollController.addListener(() {
      if (orderScrollController.offset == orderScrollController.position.maxScrollExtent){
        if (orderHisModel!.data!.currentPage != orderHisModel!.data!.pages) {
          if(state is! AllOrderLoadingState){
            int currentPage = orderHisModel!.data!.currentPage! +1;
            getAllOrder(page: currentPage);
          }
        }
      }
    });
  }

  void getSingleOrder(String id){
    DioHelper.getData(
        url: '$singleOrderUrl$id',
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['data']!=null){
        singleOrderModel = SingleOrderModel.fromJson(value.data);
        emit(SingleOrderSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(SingleOrderWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(SingleOrderErrorState());
    });
  }


  void askForRequest({
    required String id,
    required File file,
  })async{
    emit(AskRequestLoadingState());
    FormData formData = FormData.fromMap({
      'provider_id':id,
    });
      File _file = await FlutterNativeImage.compressImage(file.path,quality:1,);
      formData.files.add(
          MapEntry(
              'special_request_audio_file',
              MultipartFile.fromFileSync(
                  _file.path,
                  filename: _file.path.split('/').last)
          ));
    DioHelper.postData2(
        url: askForRequestUrl,
        formData: formData,
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        emit(AskRequestSuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(AskRequestWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(AskRequestErrorState());
    });
  }


  void chatHistory(){
    DioHelper.getData(
        url: chatHistoryUrl,
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['data']!=null){
        chatHisModel = ChatHisModel.fromJson(value.data);
        emit(ChatHistorySuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(ChatHistoryWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(ChatHistoryErrorState());
    });
  }

  void staticPage(){
    DioHelper.getData(
        url: staticPageUrl,
    ).then((value) {
      if(value.data['data']!=null){
        staticPageModel = StaticPageModel.fromJson(value.data);
        emit(StaticPageSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(StaticPageWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(StaticPageErrorState());
    });
  }
  void settings(){
    DioHelper.getData(
        url: settingsUrl,
    ).then((value) {
      if(value.data['data']!=null){
        settingsModel = SettingsModel.fromJson(value.data);
        emit(StaticPageSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(StaticPageWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(StaticPageErrorState());
    });
  }

  void init(){
    getAddresses();
    staticPage();
    settings();
  }


  void logout(BuildContext context,{int type = 1}){
    DioHelper.postData(
        url: 'user/logout', token:'Bearer $token',
        data: {'destroy':type}
    );
    token = null;
    CacheHelper.removeData('token');
    navigateAndFinish(context, SplashScreen());
  }

}