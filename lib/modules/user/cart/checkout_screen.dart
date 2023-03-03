import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../widgets/default_button.dart';
import '../widgets/cart/checkout/checkout_list_products.dart';
import '../widgets/cart/checkout/choose_address.dart';
import '../widgets/cart/checkout/have_discount.dart';
import '../widgets/cart/checkout/invoice.dart';
import '../widgets/cart/checkout/payment_method.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              defaultAppBar(context:context,title: tr('checkout')),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckoutListProducts(),
                      PaymentMethod(),
                      ChooseAddress(),
                      HaveDiscount(),
                      Invoice(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20,left: 20,bottom: 100),
                        child: DefaultButton(
                            text: tr('pay_now'),
                            onTap: (){}
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
