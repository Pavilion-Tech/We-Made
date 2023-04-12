import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';

class NoCart extends StatelessWidget {
  const NoCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.noCarts,width: size!.width*.5,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20),
            child: Text(
              tr('no_product_cart'),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 21),
            ),
          ),
          DefaultButton(text:tr('back'), onTap: (){
            UserCubit.get(context).changeIndex(0, context);
          })
        ],
      ),
    );
  }
}
