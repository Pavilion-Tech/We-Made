import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import 'package:wee_made/models/user/home_model.dart';
import 'package:wee_made/models/user/provider_item_model.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/network/remote/dio.dart';

import '../../../models/user/cart_model.dart';
import '../../../models/user/category_model.dart';
import '../../../models/user/coupon_model.dart';
import '../../../models/user/fav_model.dart';
import '../../../models/user/provider_products_model.dart';
import '../../../models/user/search_model.dart';
import '../../../modules/user/cart/cart_screen.dart';
import '../../../modules/user/home/home_screen.dart';
import '../../../modules/user/widgets/cart/cart_dialog.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/remote/end_point.dart';
import '../../../widgets/wrong_screens/update_screen.dart';

class UserCubit extends Cubit<UserStates>{

  UserCubit(): super(InitState());

  static UserCubit get (context)=>BlocProvider.of(context);

  CartModel? cartModel;

  HomeModel? homeModel;

  SearchModel? searchModel;

  ProviderItemModel? providerItemModel;

  TextEditingController searchC = TextEditingController();

  Position? position;

  CategoryModel? categoryModel;

  FavModel? favModel;

  ScrollController favScrollController = ScrollController();

  Map<String , bool> favorites = {};

  String? currentCategory;

  ProviderProductsModel? providerProductsModel;

  TextEditingController couponController = TextEditingController();

  CouponModel? couponModel;



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

  void takeFav(List<Products> products) {
    for (var product in products) {
      favorites.addAll({product.id!: product.isFavorited!});
    }
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

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(EmitState());
    });
  }
  void checkUpdate(context) async{
    final newVersion =await NewVersionPlus().getVersionStatus();
    if(newVersion !=null){
      if(newVersion.canUpdate){
        navigateAndFinish(context, UpdateScreen(
            url:newVersion.appStoreLink,
            releaseNote:newVersion.releaseNotes??tr('update_desc')
        ));
      }
    }
  }

  void getHome(){
    DioHelper.getData(
        url: getHomeUrl,
        lang: myLocale,
      token: token!=null?'Bearer $token':null
    ).then((value){
      if(value.data['data']!=null){
        homeModel = HomeModel.fromJson(value.data);
        takeFav(homeModel!.data!.products!);
        emit(HomeSuccessState());
      }else{
        emit(HomeWrongState());
      }
    }).catchError((e){
      print(e.toString());
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
      print(value.data);
      if(value.data['data']!=null){
        if(searchType == 'product'){
          providerItemModel = null;
          searchModel = SearchModel.fromJson(value.data);
          takeFav(searchModel!.data!);
        }else{
          searchModel = null;
          providerItemModel = ProviderItemModel.fromJson(value.data);
        }
        emit(GetSearchSuccessState());
      }else{
        emit(GetSearchWrongState());
      }
    }).catchError((e){
      print(e.toString());
      emit(GetSearchErrorState());
    });
  }

  void getCart(){
    DioHelper.getData(
        url: getCartUrl,
        token: token!=null?'Bearer $token':null,
        query: {'mobile_MAC_address':uuid}
    ).then((value){
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
    if(couponModel!=null){
      map.addAll({
        'coupoun_code':couponController.text
      });
    }
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
        couponController.text = '';
        couponModel = null;
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

  void getProductCategory(String id){
    categoryModel = null;
    emit(CategoryLoadingState());
    DioHelper.getData(
        url: '$categoryUrl$id',
      lang: myLocale
    ).then((value){
      print(value.data);
      if(value.data['data']!=null){
        categoryModel = CategoryModel.fromJson(value.data);
        emit(CategorySuccessState());
      }else{
        emit(CategoryWrongState());
      }
    }).catchError((e){
      print(e.toString());
      emit(CategoryErrorState());
    });
  }

  void checkoutSpecial({
    required double lat,
    required double lng,
    required String id,
    required dynamic offer,
  }){
    emit(CheckoutLoadingState());
    DioHelper.postData2(
        url: checkoutUrl,
        token: 'Bearer $token',
        data: {
          'special_request_id':id,
          'special_request_offer':offer,
          'user_longitude':lng,
          'user_latitude':lat,
        }
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

  void changeFav(String id){
    favorites[id] = !favorites[id]!;
    emit(AddFavLoadingState());
    DioHelper.postData(
        url: changeFavUrl,
        token: 'Bearer $token',
        data: {
          'favorited_product':id
        }
    ).then((value) {
      print(value.data);
      if(value.data['status'] == true){
        showToast(msg: value.data['message']);
        getFav();
      }else{
        showToast(msg: value.data['message']);
        favorites[id] = !favorites[id]!;
        emit(GetFavWrongState());
      }
    }).catchError((e){
      favorites[id] = !favorites[id]!;
      showToast(msg:tr('wrong'));
      emit(GetFavErrorState());
    });
  }


  void getFav({int page = 1}){
    emit(GetFavLoadingState());
    DioHelper.getData(
        url: '$getFavUrl$page',
        token: 'Bearer $token',
        lang: myLocale
    ).then((value) {
      if(value.data['data']!=null){
        if(page == 1) {
          favModel = FavModel.fromJson(value.data);
          takeFav(favModel!.data!.data!);
        }
        else{
          favModel!.data!.currentPage=value.data['data']['currentPage'];
          favModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            favModel!.data!.data!.add(Products.fromJson(e));
          });
          takeFav(favModel!.data!.data!);
        }
        emit(GetFavSuccessState());
      }else {
        showToast(msg: tr('wrong'));
        emit(GetFavWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(GetFavErrorState());
    });
  }

  void paginationFav(){
    favScrollController.addListener(() {
      if (favScrollController.offset == favScrollController.position.maxScrollExtent){
        if (favModel!.data!.currentPage != favModel!.data!.pages) {
          if(state is! GetFavLoadingState){
            int currentPage = favModel!.data!.currentPage! +1;
            getFav(page: currentPage);
          }
        }
      }
    });
  }

  void getProductProvider(String id,String cateId){
    emit(ProviderProductsLoadingState());
    DioHelper.postData(
        url: '$providerProductsUrl$id',
        lang: myLocale,
      data: {'category_id':cateId}
    ).then((value){
      print(value.data);
      if(value.data['data']!=null){
        providerProductsModel = ProviderProductsModel.fromJson(value.data);
        emit(ProviderProductsSuccessState());
      }else{
        emit(ProviderProductsWrongState());
      }
    }).catchError((e){
      print(e.toString());
      emit(ProviderProductsErrorState());
    });
  }

  void coupon(String code){
    emit(CouponLoadingState());
    DioHelper.postData(
        url: couponUrl,
        token: 'Bearer $token',
        data: {'code':code}
    ).then((value) {
      if(value.data['data']!=null){
        showToast(msg: value.data['message']);
        if(value.data['data']['is_applied']==true){
          couponModel = CouponModel.fromJson(value.data);
          emit(CouponSuccessState());
        }else{
          emit(CouponWrongState());
        }
      }else{
        showToast(msg: tr('wrong'));
        emit(CouponWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(CouponErrorState());
    });
  }
}