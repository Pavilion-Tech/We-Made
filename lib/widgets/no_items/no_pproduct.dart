import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/layouts/provider_layout/provider_layout.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';

class NoPProduct extends StatelessWidget {
  const NoPProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.noProducts,width: size!.width*.5,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20),
            child: Text(
              tr('no_product'),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 21),
            ),
          ),
          DefaultButton(
              text: tr('add_product'),
              onTap: (){
                ProviderCubit.get(context).changeIndex(2, context);
                navigateAndFinish(context, ProviderLayout());
              }
          )
        ],
      ),
    );
  }
}
