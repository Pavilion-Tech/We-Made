import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/models/user/notification_model.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_states.dart';

import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';
import '../../../widgets/no_items/no_notification.dart';
import '../widgets/shimmer/shimmer_shared.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({this.isMenu = false});
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
              defaultAppBar(context: context,title: tr('notifications'),isMenu: isMenu),
              //NoNotification()
              ConditionalBuilder(
                condition: cubit.notificationModel!=null,
                fallback: (context)=>const ShimmerShared(),
                builder: (context)=> ConditionalBuilder(
                  condition: cubit.notificationModel!.data!.data!.isNotEmpty,
                  fallback: (context)=>NoNotification(isMenu: isMenu),
                  builder: (context)=> Expanded(
                    child: ListView.separated(
                        itemBuilder: (c,i)=>itemBuilder(cubit.notificationModel!.data!.data![i]),
                        padding:const EdgeInsetsDirectional.all(20),
                        separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                        itemCount: cubit.notificationModel!.data!.data!.length
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  },
);
  }

  Widget itemBuilder(NotificationData data){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: Colors.grey.shade300
      ),
      padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 28,width: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(5),
              color: Colors.grey.shade400,
            ),
            child: Icon(Icons.check,color:defaultColor,size: 16,),
          ),
          const SizedBox(width: 15,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        data.title??'',
                        maxLines: 1,
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      data.createdAt??'',
                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  data.body??'',
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
