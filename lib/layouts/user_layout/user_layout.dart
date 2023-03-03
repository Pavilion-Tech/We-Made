import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';

import '../../modules/user/widgets/home/drawer/menu_drawer.dart';
import '../../shared/images/images.dart';
import '../../shared/styles/colors.dart';
import 'nav_screen.dart';

class UserLayout extends StatelessWidget {
  const UserLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Scaffold(
          drawer:MenuDrawer(),
          body: cubit.screens[cubit.currentIndex]??cubit.screens[0],
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: NavBar(
            items: [
              {
                'icon':
                Image.asset(
                  Images.homeNo, width: 20, height: 20, color: defaultColor,),
                'activeIcon': Image.asset(Images.homeYes, width: 30),
              },
              {
                'icon':
                Image.asset(
                  Images.cartNo, width: 20, height: 20, color:defaultColor),
                'activeIcon':
                Image.asset(Images.cartNo, width: 30,),
              },
              {
                'icon':Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(Images.menu, width: 15, height: 15,color:defaultColor),
                ),
                'activeIcon':
                Image.asset(Images.menu, width: 30, color: defaultColor,),
              },
            ],
          ),

        );
      },
    );
  }
}
