import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              defaultAppBar(context: context,title: tr('notifications')),
              //NoNotification()
              Expanded(
                child: ListView.separated(
                    itemBuilder: (c,i)=>itemBuilder(),
                    padding:const EdgeInsetsDirectional.all(20),
                    separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                    itemCount: 3
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget itemBuilder(){
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
                        'Order',
                        maxLines: 1,
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      '30 Min Ago',
                      style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  'Your Order Has Been Delivered',
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
