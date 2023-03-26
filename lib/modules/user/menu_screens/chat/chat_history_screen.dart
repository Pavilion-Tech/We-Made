import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:wee_made/widgets/no_items/no_product.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../widgets/menu/chat/chat_history_item.dart';

class ChatHistoryScreen extends StatelessWidget {
  const ChatHistoryScreen({Key? key}) : super(key: key);

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
              defaultAppBar(context: context,title: tr('chats')),
              ConditionalBuilder(
                condition: cubit.chatHisModel!=null,
                fallback: (context)=>const SizedBox(),
                builder: (context)=> ConditionalBuilder(
                  condition: cubit.chatHisModel!.data!.isNotEmpty,
                  fallback: (context)=>Expanded(child: NoProduct(isProduct: false)),
                  builder: (context)=> Expanded(
                    child: ListView.separated(
                        itemBuilder: (c,i)=>ChatHistoryItem(cubit.chatHisModel!.data![i]),
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
);
  }
}
