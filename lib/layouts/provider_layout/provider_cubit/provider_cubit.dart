import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_states.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/network/remote/dio.dart';
import '../../../models/provider/provider_model.dart';
import '../../../models/user/notification_model.dart';
import '../../../models/user/order_his_model.dart';
import '../../../models/user/order_model.dart';
import '../../../modules/provider/add_edit_product/add_edit_product_screen.dart';
import '../../../modules/provider/home/phome_screen.dart';
import '../../../modules/provider/notification/pnotification.dart';
import '../../../modules/provider/order/porder_history_screen.dart';
import '../../../modules/user/cart/cart_screen.dart';
import '../../../modules/user/home/home_screen.dart';
import '../../../shared/network/remote/end_point.dart';
import '../../../widgets/wrong_screens/update_screen.dart';

class ProviderCubit extends Cubit<ProviderStates>{

  ProviderCubit(): super(InitState());

  static ProviderCubit get (context)=>BlocProvider.of(context);

  List<Widget?> screens =
  [
    PHomeScreen(),
    PNotificationScreen(),
    AddEditProductScreen(),
    POrderHistoryScreen(),
    null
  ];
  int currentIndex = 0;
  XFile? highlightImage;
  ImagePicker picker = ImagePicker();
  String? categoryValue;
  ProviderModel? providerModel;
  NotificationModel? notificationModel;
  ScrollController notificationScrollController = ScrollController();
  List<File> productImages=[];
  bool productIsLoading = false;
  OrderHisModel? orderHisModel;
  ScrollController orderScrollController = ScrollController();
  SingleOrderModel? singleOrderModel;


  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(JustEmitState());
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


  Future<XFile?> pick(ImageSource source)async{
    try{
      return await picker.pickImage(source: source,imageQuality: 50);
    } catch(e){
      print(e.toString());
      emit(ImageWrong());
    }
  }

  void changeIndex(int index,BuildContext context){
    currentIndex = index;
    if(screens[currentIndex] == null)Scaffold.of(context).openDrawer();
    emit(ChangeIndexState());
  }

  void justEmit(){
    emit(JustEmitState());
  }

  void getProvider(){
    DioHelper.getData(
        url: '$getProviderUrl$userId'
    ).then((value) {
      if(value.data['data']!=null){
        providerModel = ProviderModel.fromJson(value.data);
        emit(GetProviderSuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(GetProviderWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(GetProviderErrorState());
    });
  }

  void addHighlight(){
    emit(AddHighlightLoadingState());
    DioHelper.postData2(
      url: addHighlightUrl,
      token: 'Bearer $token',
      formData: FormData.fromMap({
        'story_image':MultipartFile.fromFileSync(
            highlightImage!.path,
            filename: highlightImage!.path.split('/').last
        )
      })
    ).then((value) {
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        getProvider();
        emit(AddHighlightSuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(AddHighlightWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(AddHighlightErrorState());
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

  void addProduct ({
    required String title,
    required String desc,
    required String categoryID,
    required String price,
    required String discount,
    required String weight,
    required String quantity,
  })async{
    print(price);
    print(discount);
    FormData formData = FormData.fromMap({
      'title_en':title,
      'description_en':desc,
      'category_id':categoryID,
      'price_after_discount':discount,
      'price_before_discount':price,
      'weight':weight,
      'quantity':quantity,
    });

    for (int i = 0;  i < productImages.length;i++){
      formData.files.addAll({
        MapEntry("images", await MultipartFile.fromFileSync(productImages[i].path,
            filename: productImages[i].path.split('/').last))
      });
    }
    print(formData.fields);
    productIsLoading = true;
    emit(AddProductLoadingState());
    DioHelper.postData2(
        url: createProductUrl,
        formData: formData,
        token: 'Bearer $token'
    ).then((value) {
      print(value.data);
      if(value.data['status'] == true){
        showToast(msg: value.data['message']);
        productIsLoading = false;
        emit(AddProductSuccessState());
      }else if (value.data['message']!=null){
        showToast(msg: value.data['message']);
        productIsLoading = false;
        emit(AddProductWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      productIsLoading = false;
      emit(AddProductErrorState());
    });
  }

  void selectImages() async {
    var images = await picker.pickMultiImage(maxWidth: 350,maxHeight: 500);
    if (images.isNotEmpty) {
      for(var image in images)
      {
        productImages.add(await FlutterNativeImage.compressImage(image.path,quality:50));
      }
      emit(LoadedImageState());
    }
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
      print(value.data);
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

  void changeOrderStatus(String id,int status){
    emit(ChangeOrderLoadingState());
    DioHelper.postData(
        url: changeOrderStatusUrl,
        token: 'Bearer $token',
        data: {
          'order_id':id,
          'order_status':status,
        }
    ).then((value) {
      print(value.data);
      if(value.data['data']!=null){
        getAllOrder();
        emit(ChangeOrderSuccessState());
      }else if (value.data['status'] == false){
        showToast(msg: value.data['message'] );
        emit(ChangeOrderWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'));
      emit(ChangeOrderErrorState());
    });
  }

  Future<File> getImage({required String url}) async {

    final Response res = await Dio().get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    final Directory appDir = await getApplicationDocumentsDirectory();

    final String imageName = url.split('/').last;

    final File file = File(join(appDir.path, imageName));
    file.writeAsBytes(res.data as List<int>);
    return file;
  }


  Future addImageToList (String url,int length)async
  {
    File file = await getImage(url:url);
    if(!productImages.contains(file)) productImages.add(file);
    emit(JustEmitState());
    loadImages(length);
  }

  void loadImages(int length){
    emit(LoadImageState());
    if(length == productImages.length)emit(LoadedImageState());

  }

  void editProduct ({
    required String title,
    required String desc,
    required String categoryID,
    required String price,
    required String discount,
    required String weight,
    required String quantity,
    required String id,
  }){

    Map <String,dynamic> map={
      'title_en':title,
      'description_en':desc,
      'category_id':categoryID,
      'price_before_discount':price,
      'discount':discount,
      'weight':weight,
      'quantity':quantity,
    };

    for (var file in productImages){
      map.addAll({
        "images":MultipartFile.fromFileSync(file.path,
            filename: file.path.split('/').last),
      });
    }
    FormData formData = FormData.fromMap(map);
    productIsLoading = true;
    emit(EditProductLoadingState());
    DioHelper.putData2(
        url: '$updateProductUrl$id',
        formData: formData,
        token: 'Bearer $token'
    ).then((value) {
      print(value.data);
      if(value.data['status'] == true){
        showToast(msg: value.data['message']);
        productIsLoading = false;
        emit(EditProductSuccessState());
      }else if (value.data['message']!=null){
        productIsLoading = false;
        showToast(msg: value.data['message']);
        emit(EditProductWrongState());
      }
    }).catchError((e){
      print(e.toString());
      productIsLoading = false;
      showToast(msg: tr('wrong'));
      emit(EditProductErrorState());
    });
  }

}