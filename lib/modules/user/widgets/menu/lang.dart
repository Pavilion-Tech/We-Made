import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/provider_layout/provider_layout.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_layout.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../widgets/default_button.dart';

class ChangeLangBottomSheet extends StatelessWidget {
  ChangeLangBottomSheet({this.isProvider = false});

  bool isProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsetsDirectional.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tr('change_language'),
            style:const TextStyle(
              fontSize: 20,fontWeight: FontWeight.w500
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 30),
            child: Text(
              tr('change_language_sure'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,fontWeight: FontWeight.w500,color: defaultColorFour
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Container(
                    height: 51,
                    width:double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: defaultColor
                    ),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      tr('discard'),
                      style:const TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              Expanded(
                  child: DefaultButton(
                      text: tr('apply'),
                      onTap: (){
                        myLocale = myLocale == 'en'? 'ar':'en';
                        context.setLocale(Locale(myLocale));
                        CacheHelper.saveData(key: 'locale', value: myLocale);
                        if(isProvider)navigateAndFinish(context, ProviderLayout());
                        else {
                          UserCubit.get(context).getHome();
                          navigateAndFinish(context, UserLayout());
                        }
                      }
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
