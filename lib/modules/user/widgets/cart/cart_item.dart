import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import 'package:wee_made/widgets/image_net.dart';

import '../../../../models/user/cart_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../splash_screen.dart';
import '../menu/delete_dialog.dart';

class CartItem extends StatelessWidget {
  CartItem(this.cart,this.state);
  Cart cart;
  UserStates state;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 205,width: 177,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20),
            color: defaultColor.withOpacity(.3)
          ),
          alignment: AlignmentDirectional.center,
          child: ImageNet(image: cart.productImage??'',),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 15,top: 15,end: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.providerName??'',
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w700),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${cart.productPrice??''} AED',
                      style: TextStyle(color: defaultColor,fontSize: 25,fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    state is! DeleteCartLoadingState
                        &&UserCubit.get(context).cartId != cart.id?
                    InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context)=>DeleteDialog((){
                              UserCubit.get(context).cartId = cart.id??'';
                              UserCubit.get(context).deleteCart(cartId: cart.id??'');
                              Navigator.pop(context);
                            })
                        );
                      },
                        child: Image.asset(Images.delete,width: 21,)
                    ):CupertinoActivityIndicator()
                  ],
                ),
                Text(
                  'X${cart.quantity??''}',
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      '${cart.productRate??''}',
                      maxLines: 1,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                    ),
                    Icon(Icons.star,color: defaultColor,)
                  ],
                ),
                state is! UpdateCartLoadingState
                    &&UserCubit.get(context).cartId != cart.id?
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: (){
                          UserCubit.get(context).cartId = cart.id??'';
                          UserCubit.get(context).updateCart(
                              quantity: cart.quantity!-1,
                              cartId: cart.id??''
                          );
                        },
                        child: Text(
                            '-',
                          style: TextStyle(color: defaultColor,fontSize: 25),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        height: 34,width: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: defaultColor
                        ),
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          '${cart.quantity}',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20,height: 1.7),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (){
                          UserCubit.get(context).cartId = cart.id??'';
                          UserCubit.get(context).updateCart(
                              quantity: cart.quantity!+1,
                              cartId: cart.id??''
                          );
                        },
                        child: Text(
                            '+',
                          style: TextStyle(color: defaultColor,fontSize: 25),
                        )
                    )
                  ],
                ):LinearProgressIndicator(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
