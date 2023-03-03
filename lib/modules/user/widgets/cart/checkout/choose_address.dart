import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/modules/user/menu_screens/address/add_address/add_address_screen.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/shared/components/components.dart';

import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';

class ChooseAddress extends StatefulWidget {
  const ChooseAddress({Key? key}) : super(key: key);

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('delivery_address'),
            style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ListView.separated(
                itemBuilder: (c,i)=>itemBuilder(index: i),
                padding: EdgeInsetsDirectional.zero,
                shrinkWrap: true,
                separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                itemCount: 2
            ),
          ),
          InkWell(
            onTap: ()async{
              if (MenuCubit.get(context).position != null) {
                navigateTo(context, AddAddressScreen());
              } else {
                await MenuCubit.get(context).getCurrentLocation();
                if (MenuCubit.get(context).position != null) {
                  navigateTo(context, AddAddressScreen());
                }
              }
              },
            child: Row(
              children: [
                Image.asset(Images.address,width: 20,),
                const SizedBox(width: 8,),
                Text(
                  tr('add_address')
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuilder({
  required int index
}){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        height: 93,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(15),
          color: defaultColor.withOpacity(.3)
        ),
        padding:const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Image.asset(Images.address,width: 16,height: 18,),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),
                  ),
                  Text(
                    '26985 Brighton Lane, Lake Forest, CA 92630.',
                    maxLines: 1,
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: 10,
              backgroundColor: defaultColor,
              child: CircleAvatar(
                radius: 9,
                backgroundColor: Colors.white,
                child:currentIndex==index? CircleAvatar(
                  radius: 7,
                  backgroundColor: defaultColor,
                ):null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
