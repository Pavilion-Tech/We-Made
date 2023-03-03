import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_states.dart';
import '../../../modules/provider/add_edit_product/add_edit_product_screen.dart';
import '../../../modules/provider/home/phome_screen.dart';
import '../../../modules/provider/notification/pnotification.dart';
import '../../../modules/provider/order/porder_history_screen.dart';
import '../../../modules/user/cart/cart_screen.dart';
import '../../../modules/user/home/home_screen.dart';

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



  Future<XFile?> pick(ImageSource source)async{
    try{
      return await picker.pickImage(source: source,imageQuality: 20);
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

}