import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';

import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../widgets/default_button.dart';
import '../widgets/cart/checkout/checkout_diolog.dart';
import '../widgets/cart/checkout/checkout_list_products.dart';
import '../widgets/cart/checkout/choose_address.dart';
import '../widgets/cart/checkout/have_discount.dart';
import '../widgets/cart/checkout/invoice.dart';
import '../widgets/cart/checkout/payment_method.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key}) : super(key: key);


  PaymentMethod paymentMethod = PaymentMethod();
  ChooseAddress chooseAddress = ChooseAddress();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if(state is CheckoutSuccessState){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context)=>CheckoutDialog()
          );
        }
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                Images.backGround, width: double.infinity, fit: BoxFit.cover,),
              Column(
                children: [
                  defaultAppBar(context: context, title: tr('checkout')),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckoutListProducts(carts: cubit.cartModel!.data!.cart!),
                          paymentMethod,
                          chooseAddress,
                          HaveDiscount(),
                          Invoice(
                            subTotal: cubit.cartModel!.data!.invoiceSummary!.subTotalPrice.toString(),
                            totalPrice: cubit.cartModel!.data!.invoiceSummary!.totalPrice.toString(),
                            tax: cubit.cartModel!.data!.invoiceSummary!.shippingCharges.toString(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, bottom: 100),
                            child:state is! CheckoutLoadingState ? DefaultButton(
                                text: tr('pay_now'),
                                onTap: () {
                                  if(chooseAddress.currentLatLng!=null){
                                    cubit.checkout(
                                      carts: cubit.cartModel!.data!.cart!,
                                      lat: chooseAddress.currentLatLng!.latitude,
                                      lng: chooseAddress.currentLatLng!.longitude,
                                    );
                                  }else{
                                    showToast(msg: tr('delivery_address'));
                                  }
                                }
                            ):const Center(child: CupertinoActivityIndicator(),),
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
      },
    );
  }
}
