import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_states.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';

import '../../modules/provider/menu/pmenu_drawer.dart';
import '../../modules/user/widgets/home/drawer/menu_drawer.dart';
import '../../shared/images/images.dart';
import '../../shared/styles/colors.dart';
import 'nav_screen.dart';

class ProviderLayout extends StatelessWidget {
  const ProviderLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProviderCubit.get(context);
        return Scaffold(
          drawer:PMenuDrawer(),
          body: cubit.screens[cubit.currentIndex]??cubit.screens[0],
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: ProviderNavBar(
            items: [
              {
                'icon':
                Image.asset(
                  Images.homeNo, width: 20, height: 20,color: Colors.grey,),
                'activeIcon': Image.asset(Images.homeYes, width: 30),
              },
              {
                'icon':
                Image.asset(
                  Images.notificationNo, width: 20, height: 20),
                'activeIcon':
                Image.asset(Images.notificationYes, width: 30,),
              },
              {
                'icon':Image.asset(Images.addNo, width: 20, height: 20),
                'activeIcon':
                Image.asset(Images.addYes, width: 30,),
              },
              {
                'icon':Image.asset(Images.orderNo, width: 20, height: 20),
                'activeIcon':
                Image.asset(Images.orderYes, width: 30),
              },
              {
                'icon':Image.asset(Images.menu, width: 15, height: 15,color: Colors.grey,),
                'activeIcon':
                Image.asset(Images.menu, width: 30,color: defaultColor,),
              },
            ],
          ),

        );
      },
    );
  }
}
