import 'package:flutter/material.dart';
import 'package:wee_made/modules/provider/order/porder_details_screen.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/shared/styles/colors.dart';

class POrderHistoryScreen extends StatelessWidget {
  const POrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
        Column(
          children: [
            pDefaultAppBar(
                context: context,title: 'Order History',haveArrow: false,
                action: Image.asset(Images.manageProducts,width: 20,)
            ),
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
    );
  }
  Widget itemBuilder(context){
    return InkWell(
      onTap: (){
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
