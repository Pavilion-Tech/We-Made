import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:wee_made/shared/components/components.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';

class AboutUsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                Images.backGround, width: double.infinity, fit: BoxFit.cover,),
              Column(
                children: [
                  defaultAppBar(context: context, title: tr('about_us')),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ConditionalBuilder(
                          condition: MenuCubit.get(context).staticPageModel!=null,
                          fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                          builder: (context)=> Html(
                              data:myLocale =='en'
                                  ? MenuCubit.get(context).staticPageModel!.data!.aboutUsEn
                                  : MenuCubit.get(context).staticPageModel!.data!.aboutUsAr
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
