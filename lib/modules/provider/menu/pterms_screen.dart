import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_cubit.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_states.dart';
import 'package:wee_made/shared/components/components.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';

class PTermsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PMenuCubit, PMenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
              Column(
                children: [
                  defaultAppBar(context: context,title: tr('terms'),isMenu: true),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:  ConditionalBuilder(
                          condition: PMenuCubit.get(context).staticPageModel!=null,
                          fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                          builder: (context)=> Html(
                              data:myLocale == 'en'
                                  ? PMenuCubit.get(context).staticPageModel!.data!.termsAndConditiondsEn
                                  : PMenuCubit.get(context).staticPageModel!.data!.termsAndConditiondsAr
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
