import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import 'package:wee_made/models/user/home_model.dart';
import 'package:wee_made/models/user/provider_item_model.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/network/remote/dio.dart';

import '../../../models/user/cart_model.dart';
import '../../../models/user/search_model.dart';
import '../../../modules/user/cart/cart_screen.dart';
import '../../../modules/user/home/home_screen.dart';
import '../../../modules/user/widgets/cart/cart_dialog.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/remote/end_point.dart';

class UserCubit extends Cubit<UserStates>{

  UserCubit(): super(InitState());

  static UserCubit get (context)=>BlocProvider.of(context);

  CartModel? cartModel;

  HomeModel? homeModel;

  SearchModel? searchModel;

  ProviderItemModel? providerItemModel;

  TextEditingController searchC = TextEditingController();

  Position? position;

  void emitState()=>emit(EmitState());



  List<Widget?> screens =
  [
    HomeScreen(),
    CartScreen(),
    null
  ];
  int currentIndex = 0;


  void changeIndex(int index,BuildContext context){
    currentIndex = index;
    if(screens[currentIndex] == null)Scaffold.of(context).openDrawer();
    emit(ChangeIndexState());
  }

  Future<Position> checkPermissions() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {}
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast(msg: 'Location permissions are denied', toastState: false);
        emit(GetCurrentLocationState());
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showToast(msg: 'Location permissions are permanently denied, we cannot request permissions.', toastState: false);
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

  void getHome(){
    DioHelper.getData(
        url: getHomeUrl,
        lang: myLocale
    ).then((value){
      if(value.data['data']!=null){
        homeModel = HomeModel.fromJson(value.data);
        emit(HomeSuccessState());
      }else{
        emit(HomeWrongState());
      }
    }).catchError((e){
      emit(HomeErrorState());
    });
  }


  String searchType = 'product';
  String lat = '24.454812';
  String lng = '55.247715';
  int rate = -1;
  int price = -1;

  void getSearch(){
    emit(GetSearchLoadingState());
    DioHelper.getData(
        url: searchUrl,
        query: {
          'search_type':searchType,
          'search_text':searchC.text,
          'rate':rate,
          'price':price,
          'current_latitude':position!=null?position!.latitude:lat,
          'current_longitude':position!=null?position!.longitude:lng,
        }
    ).then((value){
      if(value.data['data']!=null){
        if(searchType == 'product'){
          providerItemModel = null;
          searchModel = SearchModel.fromJson(value.data);
        }else{
          searchModel = null;
          providerItemModel = ProviderItemModel.fromJson(value.data);
        }
        emit(GetSearchSuccessState());
      }else{
        emit(GetSearchWrongState());
      }
    }).catchError((e){
      emit(GetSearchErrorState());
    });
  }

  void getCart(){
    DioHelper.getData(
        url: getCartUrl,
        token: token!=null?'Bearer $token':null,
        query: {'mobile_MAC_address':uuid}
    ).then((value){
      print(value.data);
      if(value.data['data']!=null){
        cartModel = CartModel.fromJson(value.data);
        emit(CartSuccessState());
      }else{
        emit(CartWrongState());
      }
    }).catchError((e){
      emit(CartErrorState());
    });
  }
  String currentCartID ='';
  void addToCart({
  required int quantity,
  required String productId,
  required BuildContext context,
}){
    emit(AddCartLoadingState());
    DioHelper.postData(
      url: addCartUrl,
      token: token!=null?'Bearer $token':null,
      data: {
        'quantity':quantity,
        'product_id':productId,
        'mobile_MAC_address':uuid
      }
    ).then((value) {
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        currentCartID = '';
        getCart();
        emit(AddCartSuccessState());
        showDialog(context: context, builder: (context)=>CartDialog());
      }else{
        showToast(msg: value.data['message']);
        currentCartID = '';
        emit(AddCartWrongState());
      }
    }).catchError((e){
      showToast(msg:tr('wrong'));
      currentCartID = '';
      emit(AddCartErrorState());
    });
  }

  String cartId = '';
  void updateCart({
    required int quantity,
    required String cartId,
  }){
    emit(UpdateCartLoadingState());
    DioHelper.putData(
        url: updateCartUrl,
        token: token!=null?'Bearer $token':null,
        data: {
          'quantity':quantity,
          'cart_item_id':cartId,
          'mobile_MAC_address':uuid
        }
    ).then((value) {
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        getCart();
        this.cartId = '';
        emit(UpdateCartSuccessState());
      }else{
        showToast(msg: value.data['message']);
        this.cartId = '';
        emit(UpdateCartWrongState());
      }
    }).catchError((e){
      showToast(msg:tr('wrong'));
      this.cartId = '';
      emit(UpdateCartErrorState());
    });
  }

  void deleteCart({
    required String cartId,
  }){
    emit(DeleteCartLoadingState());
    DioHelper.deleteData(
        url: '$deleteCartUrl$cartId',
        token: token!=null?'Bearer $token':null,
    ).then((value) {
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        getCart();
        this.cartId = '';
        emit(DeleteCartSuccessState());
      }else{
        showToast(msg: value.data['message']);
        this.cartId = '';
        emit(DeleteCartWrongState());
      }
    }).catchError((e){
      showToast(msg:tr('wrong'));
      this.cartId = '';
      emit(DeleteCartErrorState());
    });
  }

  FormData checkoutData({required List<Cart> carts,required double lat,required double lng}){
    Map <String,dynamic> map = {
      'user_longitude':lng,
      'user_latitude':lat,
    };
    for (int i = 0;  i < carts.length;i++){
      map.addAll({
        "products[$i][product_id]":carts[i].productId??'',
        "products[$i][product_quantity]":'${carts[i].quantity}',
      });
    }

    return FormData.fromMap(map);
  }

  void checkout({required List<Cart> carts,required double lat,required double lng}){
    FormData data =  checkoutData(carts: carts,lat: lat,lng: lng);
    emit(CheckoutLoadingState());
    DioHelper.postData2(
        url: checkoutUrl,
        token: 'Bearer $token',
        formData: data
    ).then((value) {
      print(value.data);
      if(value.data['status'] == true){
        showToast(msg: value.data['message']);
        emit(CheckoutSuccessState());
        getCart();
      }else if (value.data['message']!=null){
        showToast(msg: value.data['message']);
        emit(CheckoutWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(CheckoutErrorState());
    });
  }
}