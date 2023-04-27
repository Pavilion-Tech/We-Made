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
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/network/remote/dio.dart';

import '../../../../models/chat_model.dart';
import '../../../../models/chathis_model.dart';
import '../../../../models/settings_model.dart';
import '../../../../models/static_page_model.dart';
import '../../../../models/user/address_model.dart';
import '../../../../models/user/fav_model.dart';
import '../../../../models/user/notification_model.dart';
import '../../../../models/user/order_his_model.dart';
import '../../../../models/user/order_model.dart';
import '../../../../models/user/user_model.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/network/remote/end_point.dart';
import '../../../../splash_screen.dart';
import '../chat/chat_screen.dart';
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
  UserModel? userModel;
  NotificationModel? notificationModel;
  ScrollController notificationScrollController = ScrollController();
  ChatModel? chatModel;



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

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(JustEmitState());
    });
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
      File file
      = await FlutterNativeImage.compressImage(profileImage!.path,quality:1);
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
        userData();
        showToast(msg: value.data['message']);
        emit(UpdateProfileSuccessState());
      }else{
        if(value.data['message']!=null){
          showToast(msg: value.data['message']);
        }else{
          showToast(msg: tr('wrong'));
          emit(UpdateProfileWrongState());
        }
        emit(UpdateProfileWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(UpdateProfileErrorState());
    });
  }

  void getAddresses(){
    if(token!=null)
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
      url: '$orderHisUrl$page',
      token: 'Bearer $token',
      lang: myLocale
    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          orderHisModel = OrderHisModel.fromJson(value.data);
        }
        else{
          orderHisModel!.data!.currentPage=value.data['data']['currentPage'];
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
    required BuildContext context,
  })async{
    emit(AskRequestLoadingState());
    FormData formData = FormData.fromMap({
      'provider_id':id,
    });
      File _file =await FlutterNativeImage.compressImage(file.path,quality:1);
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
      if(value.data['data']!=null){
        showToast(msg: value.data['message']);
        MenuCubit.get(context).singleChat(value.data['data']['_id']);
        Navigator.pop(context);
        navigateTo(context, ChatScreen(value.data['data']['_id']));
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
    userData();
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
    UserCubit.get(context).getCart();
    navigateAndFinish(context, SplashScreen());
  }

  void userData(){
    if(token!=null)
    DioHelper.getData(
      url: userUrl,
      token: 'Bearer $token'
    ).then((value) {
      if(value.data['data']!=null){
        userModel = UserModel.fromJson(value.data);
        emit(UserSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(UserWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(UserErrorState());
    });
  }

  void contactUs({
  required String subject,
  required String message,
}){
    emit(ContactUsLoadingState());
    DioHelper.postData(
      url: contactUsUrl,
      token: 'Bearer $token',
      lang: myLocale,
      data: {
        'subject':subject,
        'message':message,
      }
    ).then((value) {
      if(value.data['data']!=null){
        showToast(msg: value.data['message']);
        emit(ContactUsSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(ContactUsWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(ContactUsErrorState());
    });
  }

  void getAllNotification({int page = 1}){
    emit(AllNotificationLoadingState());
    DioHelper.getData(
        url: '$notificationUrl$page',
        token: 'Bearer $token',
        lang: myLocale
    ).then((value) {
      print(value.data);
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          notificationModel = NotificationModel.fromJson(value.data);
        }
        else{
          notificationModel!.data!.currentPage=value.data['data']['currentPage'];
          notificationModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            notificationModel!.data!.data!.add(NotificationData.fromJson(e));
          });
        }
        emit(AllNotificationSuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        showToast(msg: tr('wrong'));
        emit(AllNotificationWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(AllNotificationErrorState());
    });
  }


  void paginationNotification(){
    notificationScrollController.addListener(() {
      if (notificationScrollController.offset == notificationScrollController.position.maxScrollExtent){
        if (notificationModel!.data!.currentPage != notificationModel!.data!.pages) {
          if(state is! AllNotificationLoadingState){
            int currentPage = notificationModel!.data!.currentPage! +1;
            getAllNotification(page: currentPage);
          }
        }
      }
    });
  }

  void singleChat(String id){
    DioHelper.getData(
        url: '$chatUrl$id',
        token: 'Bearer $token'
    ).then((value) {
      print(value.data);
      if(value.data['data']!=null){
        chatModel = ChatModel.fromJson(value.data);
        emit(ChatSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(ChatWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(ChatErrorState());
    });
  }

  void sendMessageWithFile({
    required String id,
    required int type,
    required File file,
  })async{
    File _file= await FlutterNativeImage.compressImage(file.path,quality:1);
    FormData formData = FormData.fromMap({
      'special_request_id':id,
      'message_type':type,
      'uploaded_message_file':MultipartFile.fromFileSync(_file.path,
          filename: _file.path.split('/').last),
    });
    emit(SendMessageWithFileLoadingState());
    DioHelper.postData2(
        url: sentMessageUrl,
        token: 'Bearer $token',
        formData:formData
    ).then((value) {
      if(value.data['status']==true){
        singleChat(id);
        chatImage = null;
        emit(SendMessageSuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(SendMessageWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(SendMessageErrorState());
    });
  }

  void sendMessageWithOutFile(){
    emit(SendMessageLoadingState());
    DioHelper.postData(
        url: sentMessageUrl,
        token: 'Bearer $token',
        data: {
          'special_request_id':chatModel!.data!.id??'',
          'message_type':1,
          'message':controller.text
        }
    ).then((value) {
      print(value);
      if(value.data['status']==true){
        controller.text = '';
        singleChat(chatModel!.data!.id??'');
        emit(SendMessageSuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(SendMessageWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(SendMessageErrorState());
    });
  }

}