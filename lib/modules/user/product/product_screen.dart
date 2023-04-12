import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import 'package:wee_made/modules/auth/login_screen.dart';
import '../../../models/user/home_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/image_net.dart';
import '../store/store_screen.dart';
import '../widgets/cart/cart_dialog.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen(this.products);
  Products products;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  int currentIndex = 0;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = UserCubit.get(context);
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.asset(Images.curvesBackGround,height: double.infinity,width: double.infinity,fit: BoxFit.cover,),
          Container(
            height: size!.height*.7,
            width: double.infinity,
            decoration:const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(20),
                  topStart: Radius.circular(20),
                )
            ),
            child: Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          ),
          Column(
            children: [
              defaultAppBar(isProduct: true,title: widget.products.title??'',context:context,backColor:Colors.white),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding:const EdgeInsetsDirectional.only(end:5),
                  child: IconButton(
                      onPressed: (){
                        if(token!=null){
                          cubit.changeFav(widget.products.id??'');
                        }else{
                          navigateTo(context, LoginScreen(haveArrow: true,));
                        }
                      },
                      icon: Icon(Icons.favorite,
                        color: cubit.favorites[widget.products.id]!=null
                            ?cubit.favorites[widget.products.id]! ?Colors.red :Colors.white
                            :Colors.white,
                      )
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: ImageNet(image:widget.products.images!.isNotEmpty?widget.products.images![currentIndex]:'',height: 230,width: 250,)),
                      const SizedBox(height: 30,),
                      SizedBox(
                        height: 20,
                        child: ListView.separated(
                            itemBuilder: (c,i)=>chooseColor(i,widget.products.images![i]),
                            separatorBuilder: (c,i)=>const SizedBox(width: 15,),
                            itemCount: widget.products.images!.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Text(
                              '${widget.products.priceAfterDicount} AED',
                              style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            InkWell(
                                onTap: (){
                                  if(quantity>1)
                                  setState(() {
                                    quantity--;
                                  });
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
                                  '$quantity',
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20,height: 1.7),
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: (){
                                  if(widget.products.quantity != quantity)
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: Text(
                                  '+',
                                  style: TextStyle(color: defaultColor,fontSize: 25),
                                )
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.products.totalRate}',
                            maxLines: 1,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 25),
                          ),
                          const SizedBox(width: 5,),
                          Image.asset(Images.star,width: 21,color: defaultColor,),
                          const Spacer(),
                          UserCubit.get(context).currentCartID != widget.products.id?
                          DefaultButton(
                              text: tr('add_to_cart'),
                              width: size!.width*.4,
                              height: 43,
                              onTap: (){
                                UserCubit.get(context).currentCartID = widget.products.id??'';
                                UserCubit.get(context).addToCart(
                                    quantity: quantity,
                                    productId: widget.products.id??'',
                                    context: context
                                );
                              }
                          ):CupertinoActivityIndicator()
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 40),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 61,
                                padding: EdgeInsetsDirectional.only(start: 20),
                                alignment: AlignmentDirectional.centerStart,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadiusDirectional.circular(10)
                                ),
                                child: Text(
                                    widget.products.providerId!.storeName??'',
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(width: 30,),
                            TextButton(
                                onPressed: (){
                                  navigateTo(context, StoreScreen(widget.products.providerId!));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      tr('visit'),
                                      style: TextStyle(color: defaultColor,fontWeight: FontWeight.w600,fontSize: 17),
                                    ),
                                    const SizedBox(width: 3,),
                                    Icon(Icons.arrow_forward,color: defaultColor,size: 10,)
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                      Text(
                        tr('details'),
                        style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            widget.products.description??'',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
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

  Widget chooseColor(int index,String image){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child:CircleAvatar(
          radius: currentIndex == index?15:10,
          backgroundColor: Colors.red,
          child: ImageNet(image: image,),
        )
      ),
    );
  }
}
