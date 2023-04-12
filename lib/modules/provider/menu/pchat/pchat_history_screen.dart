import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_cubit.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_states.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../widgets/no_items/no_product.dart';
import '../../../user/widgets/shimmer/shimmer_shared.dart';
import '../../widgets/menu/chat/chat_history_item.dart';

class PChatHistoryScreen extends StatelessWidget {
  PChatHistoryScreen({this.isMenu = false});
  bool isMenu;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PMenuCubit, PMenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = PMenuCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              pDefaultAppBar(
                  context: context,title: tr('chats'),
                  isMenu: isMenu,
                  action: Image.asset(Images.send,width: 20,color: defaultColor,)
              ),
              ConditionalBuilder(
                condition: cubit.chatHisModel!=null,
                fallback: (context)=>const ShimmerShared(),
                builder: (context)=> ConditionalBuilder(
                  condition: cubit.chatHisModel!.data!.isNotEmpty,
                  fallback: (context)=>Expanded(child: NoProduct(isProduct: isMenu)),
                  builder: (context)=> Expanded(
                    child: ListView.separated(
                        itemBuilder: (c,i)=>PChatHistoryItem(cubit.chatHisModel!.data![i]),
                        padding:const EdgeInsetsDirectional.all(20),
                        separatorBuilder: (c,i)=>Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 2),
                          child: Container(
                            color: Colors.grey.shade400,
                            height: 1,
                            width: double.infinity,
                          ),
                        ),
                        itemCount: cubit.chatHisModel!.data!.length
                    ),
                  ),
                ),
              )

            ],
          )
        ],
      ),
    );
  },
);  }
}
