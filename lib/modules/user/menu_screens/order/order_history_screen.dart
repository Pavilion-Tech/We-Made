import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/models/user/order_his_model.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/widgets/no_items/no_product.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../widgets/shimmer/shimmer_shared.dart';
import '../menu_cubit/menu_states.dart';
import 'order_details_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({this.isMenu = false});
  bool isMenu;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              defaultAppBar(context: context,title:tr('order_history'),isMenu: isMenu),
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
      ),
    );
  },
);
  }

  Widget itemBuilder(BuildContext context,OrderData data){
    return InkWell(
      onTap: (){
        MenuCubit.get(context).singleOrderModel = null;
        MenuCubit.get(context).getSingleOrder(data.id??'');
        navigateTo(context, OrderDetailsScreen());
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
