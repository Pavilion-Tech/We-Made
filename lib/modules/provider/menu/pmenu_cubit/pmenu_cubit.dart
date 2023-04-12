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
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/layouts/provider_layout/provider_layout.dart';

import '../../../../models/category_model.dart';
import '../../../../models/chat_model.dart';
import '../../../../models/chathis_model.dart';
import '../../../../models/cities_model.dart';
import '../../../../models/settings_model.dart';
import '../../../../models/static_page_model.dart';
import '../../../../models/user/provider_products_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/network/remote/dio.dart';
import '../../../../shared/network/remote/end_point.dart';
import '../../../../splash_screen.dart';
import '../../widgets/auth/dropdownfield.dart';
import 'pmenu_states.dart';

class PMenuCubit extends Cubit<PMenuStates>{
  PMenuCubit():super(InitState());
  static PMenuCubit get (context)=> BlocProvider.of(context);

  ImagePicker picker = ImagePicker();
  XFile? chatImage;
  XFile? profileImage;
  TextEditingController controller = TextEditingController();
  Position? position;
  ChatModel? chatModel;
  ChatHisModel? chatHisModel;
  StaticPageModel? staticPageModel;
  SettingsModel? settingsModel;
  ProviderProductsModel? providerProductsModel;

  Future<XFile?> pick(ImageSource source)async{
    try{
      return await picker.pickImage(source: source);
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

  CitiesModel? citiesModel;
  NeighborhoodModel? neighborhoodModel;
  CategoryModel? categoryModel;
  String? cityValue;
  String? neighborhoodValue;
  late CustomDropDownField neighborhoodDropDown;



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

  void updateUser ({
    required String phone,
    required String storeName,
    required String ownerName,
    required String email,
    required String cityId,
    required String neighborhoodId,
    required String idNum,
    required String commercial,
    required int special,
    required List<String> categories,
    required String id,
    required BuildContext context,
    File? file,
  }){
    emit(UpdateProviderLoadingState());
    Map <String,dynamic> map={
      'phone_number':phone,
      'store_name':storeName,
      'owner_name':ownerName,
      'email':email,
      'city_id':cityId,
      'neighborhood_id':neighborhoodId,
      'current_latitude':position?.latitude??24.454812,
      'current_longitude':position?.longitude??55.247715,
      'id_number':idNum,
      'commercial_registeration_number':commercial,
      'has_special_requests':special,
      'firebase_token':fcmToken,
      'current_language':myLocale,
      'personal_photo':file!=null?MultipartFile.fromFileSync(file.path,
          filename: file.path.split('/').last):null,
    };

    for (int i = 0;  i < categories.length;i++){
      map.addAll({
        "category_id[$i]":categories[i]
      });
    }
    FormData formData = FormData.fromMap(map);
    DioHelper.putData2(
        url: '$updateProviderUrl$id',
        formData: formData
    ).then((value) {
      print(value.data);
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        ProviderCubit.get(context).getProvider();
        emit(UpdateProviderSuccessState());
      }else if(value.data['data']!=null){
        showToast(msg: value.data['data'].toString());
        emit(UpdateProviderWrongState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(UpdateProviderWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(UpdateProviderErrorState());
    });
  }

  void getProducts({String? categoryId,String? text , int?rate,int? price,int?location}){
    emit(GetProductsLoadingState());
    DioHelper.getData(
        url: '$providerProductUrl$userId',
        query: {
          'category_id':categoryId??'',
          'search_text':text??'',
          'rate':rate??'',
          'price':price??'',
          'location':location??'',
        }
    ).then((value) {
      print(value.data);
      if(value.data['data'] != null){
        providerProductsModel = ProviderProductsModel.fromJson(value.data);
        emit(GetProductsSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(GetProductsWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(GetProductsErrorState());
    });
  }

  void singleChat(String id){
    DioHelper.getData(
        url: '$chatUrl$id',
        token: 'Bearer $token'
    ).then((value) {
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

  void deleteProduct (String id,context,{bool isProductScreen = true}){
    emit(DeleteProductLoadingState());
    DioHelper.deleteData(
      url: '$deleteProductUrl$id',
      token: 'Bearer $token',
    ).then((value) {
      if(value.data['status'] == true){
        showToast(msg: value.data['message']);
        getProducts();
        Navigator.pop(context);
        Navigator.pop(context);
        if(!isProductScreen){
          navigateAndFinish(context, ProviderLayout());
        }
        emit(DeleteProductSuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(DeleteProductWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(DeleteProductErrorState());
    });
  }


  void sendOffer({required String id, required String price}){
    emit(SendOfferLoadingState());
    DioHelper.postData(
        url: sendOfferUrl,
        token:'Bearer $token',
        data: {
          'special_request_id':id,
          'special_request_offer':price,
        }
    ).then((value) {
      print(value.data);
      if(value.data['status']  == true){
        showToast(msg: value.data['message']);
        emit(SendOfferSuccessState());
      }else if(value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(SendOfferWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(SendOfferErrorState());
    });
  }



}