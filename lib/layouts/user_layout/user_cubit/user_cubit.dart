import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';

import '../../../modules/user/cart/cart_screen.dart';
import '../../../modules/user/home/home_screen.dart';

class UserCubit extends Cubit<UserStates>{

  UserCubit(): super(InitState());

  static UserCubit get (context)=>BlocProvider.of(context);

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

}