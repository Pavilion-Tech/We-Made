import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';

import '../../../../../shared/styles/colors.dart';
import '../../../../../widgets/default_form.dart';

class HaveDiscount extends StatelessWidget {
  HaveDiscount({Key? key}) : super(key: key);
  TextEditingController couponController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('have_coupon'),
              style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: DefaultForm(
                      hint: tr('enter_discount'),
                    controller: couponController,
                    validator: (val) {
                      if (val.isEmpty) return tr('discount_empty');
                    },
                  ),
                ),
                const SizedBox(width: 20,),
                state is! CouponLoadingState? TextButton(
                    onPressed: (){
                      if (formKey.currentState!.validate()) {
                        UserCubit.get(context).coupon(couponController.text.trim());
                      }
                    },
                    child: Text(
                        tr('apply'),
                      style: TextStyle(color: defaultColor,fontWeight: FontWeight.w600,fontSize: 17),
                    )
                ):const CupertinoActivityIndicator()
              ],
            )
          ],
        ),
      ),
    );
  },
);
  }

}

