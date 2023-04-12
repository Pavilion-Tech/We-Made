import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_states.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../widgets/cart/checkout/checkout_list_products.dart';
import '../../widgets/cart/checkout/invoice.dart';
import '../../widgets/menu/order/order_appbar.dart';
import '../../widgets/menu/order/order_product.dart';
import '../../widgets/menu/order/track_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool showTrack = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:orderAppbar(
          context,
          status: cubit.singleOrderModel?.data?.status??0,
          itemNumber: cubit.singleOrderModel?.data?.itemNumber??0),
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          SafeArea(
            child: ConditionalBuilder(
              condition: cubit.singleOrderModel!=null,
              fallback: (context)=>Center(child: CupertinoActivityIndicator()),
              builder: (context)=> SingleChildScrollView(
                child: Column(
                  children: [
                    if(showTrack)
                    TrackWidget(cubit.singleOrderModel!.data!.status!),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text(
                            '${cubit.singleOrderModel!.data!.providerName} (${cubit.singleOrderModel!.data!.products!.length} items)',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),
                          ),
                          const Spacer(),
                          if(!showTrack)
                          InkWell(
                            onTap: (){
                              setState(() {
                                showTrack = true;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  tr('track'),
                                  style: TextStyle(color:defaultColor,fontWeight: FontWeight.w600,fontSize: 17),
                                ),
                                const SizedBox(width: 3,),
                                Icon(Icons.arrow_forward,color: defaultColor,size: 10,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    if(cubit.singleOrderModel!.data!.orderType == 2)
                      Text(tr('special_request')),
                    if(cubit.singleOrderModel!.data!.products!.isNotEmpty)
                    OrderListProducts(cubit.singleOrderModel!.data!.products!),
                    Invoice(
                      subTotal: cubit.singleOrderModel!.data!.subTotalPrice.toString(),
                      tax: cubit.singleOrderModel!.data!.shippingCharges.toString(),
                      totalPrice: cubit.singleOrderModel!.data!.totalPrice.toString(),
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  },
);
  }
}
