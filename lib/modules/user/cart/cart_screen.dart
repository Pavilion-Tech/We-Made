import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/no_items/no_carts.dart';
import '../widgets/cart/cart_item.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            //Expanded(child: NoCart()),
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  ListView.separated(
                      itemBuilder: (c,i)=> CartItem(listImages[i]),
                      padding:const EdgeInsets.only(right: 20,left: 20,bottom: 150),
                      separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                      itemCount: listImages.length
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20,left: 20,bottom: 100),
                    child: DefaultButton(
                      text: tr('checkout'),
                      onTap: ()=>navigateTo(context, CheckoutScreen()),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
