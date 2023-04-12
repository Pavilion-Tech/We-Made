import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_layout.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/modules/user/menu_screens/order/order_history_screen.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';

import '../../../../../shared/styles/colors.dart';

class CheckoutDialog extends StatelessWidget {
  const CheckoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(20)),
      child: Padding(
        padding:const EdgeInsets.symmetric(vertical: 40,horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Images.confirmDialog,width: 82,height: 82,),
            const SizedBox(height: 25,),
            Text(
            tr('order_added'),
              style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: DefaultButton(
                  text: tr('order_history'),
                  onTap: () {
                    MenuCubit.get(context).getAllOrder();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    UserCubit.get(context).changeIndex(0, context);
                    navigateTo(context, OrderHistoryScreen());
                  }),
            ),
            InkWell(
              onTap: (){
                Navigator.pop(context);
                Navigator.pop(context);
                UserCubit.get(context).changeIndex(0, context);
              },
              child: Container(
                height: 51,
                width:double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    border: Border.all(color: defaultColor),
                    color: Colors.white
                ),
                alignment: AlignmentDirectional.center,
                child: Text(
                  tr('continue_shopping'),
                  style:TextStyle(color:defaultColor,fontSize: 17,fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
