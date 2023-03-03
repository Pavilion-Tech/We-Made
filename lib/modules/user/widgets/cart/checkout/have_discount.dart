import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/styles/colors.dart';
import '../../../../../widgets/default_form.dart';

class HaveDiscount extends StatelessWidget {
  const HaveDiscount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                child: DefaultForm(hint: tr('enter_discount')),
              ),
              const SizedBox(width: 20,),
              TextButton(
                  onPressed: (){},
                  child: Text(
                      tr('apply'),
                    style: TextStyle(color: defaultColor,fontWeight: FontWeight.w600,fontSize: 17),
                  )
              )
            ],
          )
        ],
      ),
    );
  }

}

