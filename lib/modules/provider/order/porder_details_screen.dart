import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_states.dart';
import 'package:wee_made/widgets/default_button.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../user/widgets/cart/checkout/checkout_list_products.dart';
import '../../user/widgets/cart/checkout/invoice.dart';
import '../../user/widgets/menu/order/order_appbar.dart';
import '../../user/widgets/menu/order/track_widget.dart';
import '../widgets/order/order_items.dart';

class POrderDetailsScreen extends StatefulWidget {
  const POrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<POrderDetailsScreen> createState() => _POrderDetailsScreenState();
}

class _POrderDetailsScreenState extends State<POrderDetailsScreen> {
  bool showTrack = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderStates>(
  listener: (context, state) {
    if(state is ChangeOrderSuccessState)Navigator.pop(context);

  },
  builder: (context, state) {
    var cubit = ProviderCubit.get(context);
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          itemBuilder(
                              Images.person2,
                              cubit.singleOrderModel!.data!.userName??''
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: itemBuilder(
                                Images.phone,
                                cubit.singleOrderModel!.data!.userPhone??''
                            ),
                          ),
                          itemBuilder(
                              Images.address,
                              cubit.singleOrderModel!.data!.userOrderAddress??''
                          ),
                        ],
                      ),
                    ),
                    if(showTrack)
                    TrackWidget(cubit.singleOrderModel!.data!.status!),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text(
                            '(${cubit.singleOrderModel!.data!.products!.length} ${tr('items')})',
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
                    OrderProducts(products: cubit.singleOrderModel!.data!.products!),
                    Invoice(
                      type: cubit.singleOrderModel?.data?.discountType,
                      discount: cubit.singleOrderModel?.data?.discountValue,
                      subTotal: cubit.singleOrderModel!.data!.subTotalPrice.toString(),
                      tax: cubit.singleOrderModel!.data!.shippingCharges.toString(),
                      totalPrice: cubit.singleOrderModel!.data!.totalPrice.toString(),
                    ),
                    const SizedBox(height: 100,),
                  ],
                ),
              ),
            ),
          ),
          if(cubit.singleOrderModel!=null)
            if(cubit.singleOrderModel!.data!.status != 4)
            state is! ChangeOrderLoadingState?
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 60,right: 20,left: 20),
                    child: DefaultButton(
                        text: cubit.singleOrderModel!.data!.status==1? tr('in_processing'):cubit.singleOrderModel!.data!.status==2?tr('in_out_delivery'):tr('in_delivered'),
                        onTap: () {
                          cubit.changeOrderStatus(
                            cubit.singleOrderModel!.data!.id!,
                            cubit.singleOrderModel!.data!.status!+1,
                          );
                        }
                    )
                ),
              ) :const Center(child: CircularProgressIndicator(),),
        ],
      ),
    );
  },
);
  }

  Widget itemBuilder(String image,String title){
    return Row(
      children: [
        Image.asset(image,width: 20,color: defaultColor,),
        const SizedBox(width: 15,),
        Expanded(
          child: Text(
            title,
            maxLines: 2,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
