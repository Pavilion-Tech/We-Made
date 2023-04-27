import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/modules/provider/order/porder_details_screen.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/shared/styles/colors.dart';

import '../../../layouts/provider_layout/provider_cubit/provider_states.dart';
import '../../../models/user/order_his_model.dart';
import '../../../widgets/no_items/no_product.dart';
import '../../user/widgets/shimmer/shimmer_shared.dart';

class POrderHistoryScreen extends StatelessWidget {
  const POrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderCubit.get(context).getAllOrder();
    return BlocConsumer<ProviderCubit, ProviderStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = ProviderCubit.get(context);
    return Stack(
      children: [
        Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
        Column(
          children: [
            pDefaultAppBar(
                context: context,title:tr('order_history'),haveArrow: false,
                action: Image.asset(Images.manageProducts,width: 20, color: defaultColor)
            ),
            ConditionalBuilder(
              condition: cubit.orderHisModel!=null,
              fallback: (context)=>const ShimmerShared(),
              builder: (context)=> ConditionalBuilder(
                  condition: cubit.orderHisModel!.data!.data!.isNotEmpty,
                  fallback: (context)=>Expanded(child: NoProduct(isProduct: false)),
                  builder: (context){
                    Future.delayed(Duration.zero,(){
                      cubit.paginationOrder();
                    });
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                itemBuilder: (c,i)=>itemBuilder(context,cubit.orderHisModel!.data!.data![i]),
                                padding:const EdgeInsetsDirectional.all(20),
                                controller: cubit.orderScrollController,
                                physics:BouncingScrollPhysics(),
                                separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                                itemCount:cubit.orderHisModel!.data!.data!.length
                            ),
                          ),
                          if(state is AllOrderLoadingState)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: CupertinoActivityIndicator(),
                            ),
                        ],
                      ),
                    );
                  }
              ),
            )
          ],

        )
      ],
    );
  },
);
  }
  Widget itemBuilder(BuildContext context,OrderData data){
    return InkWell(
      onTap: (){
        ProviderCubit.get(context).singleOrderModel = null;
        ProviderCubit.get(context).getSingleOrder(data.id??'');
        navigateTo(context, POrderDetailsScreen());
      },
      child: Container(
        height: 93,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(15),
            color: defaultColor.withOpacity(.3)

        ),
        padding:const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  '#${data.itemNumber}',
                  style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text(
                  tr(data.status==1 ?'new_order' :data.status==2?'processing':data.status==3?'shipping':'done2'),
                  style: TextStyle(color:defaultColor,fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  data.createdAt??'',
                  style: TextStyle(fontSize: 13),
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: defaultColor,
                  radius: 10,
                  child: Icon(Icons.check,color: Colors.white,size: 14,),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}
