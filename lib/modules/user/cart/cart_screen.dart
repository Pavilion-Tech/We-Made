import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import 'package:wee_made/modules/auth/login_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/no_items/no_carts.dart';
import '../widgets/cart/cart_item.dart';
import '../widgets/shimmer/cart_shimmer.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = UserCubit.get(context);
    return Stack(
      children: [
        Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
        Column(
          children: [
            defaultAppBar(
              title:tr('cart'),
              haveCart: false,
              haveArrow: false,
              context: context
            ),
            ConditionalBuilder(
              condition: cubit.cartModel!=null,
              fallback:(context)=>const CartShimmer(),
              builder:(context)=> ConditionalBuilder(
                condition: cubit.cartModel!.data!.cart!.isNotEmpty,
                fallback: (context)=>Expanded(child: NoCart()),
                builder: (context)=> Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      ListView.separated(
                          itemBuilder: (c,i)=> CartItem(cubit.cartModel!.data!.cart![i],state),
                          padding:const EdgeInsets.only(right: 20,left: 20,bottom: 150),
                          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                          itemCount: cubit.cartModel!.data!.cart!.length
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20,left: 20,bottom: 100),
                        child: DefaultButton(
                          text: tr('checkout'),
                          onTap: (){
                            if(token!=null){
                              navigateTo(context, CheckoutScreen());
                            }else{
                              navigateTo(context, LoginScreen(haveArrow: true,));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  },
);
  }
}
