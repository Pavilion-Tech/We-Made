import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import 'order_details_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              defaultAppBar(context: context,title:tr('order_history')),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (c,i)=>itemBuilder(context),
                    padding:const EdgeInsetsDirectional.all(20),
                    separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                    itemCount:3
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget itemBuilder(context){
    return InkWell(
      onTap: (){
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
                  '#256368',
                  style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text(
                  'Done',
                  style: TextStyle(color:defaultColor,fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Date 20 jun 2019',
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
