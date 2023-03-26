import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wee_made/models/user/address_model.dart';
import 'package:wee_made/modules/user/menu_screens/address/add_address/add_address_screen.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:wee_made/shared/components/components.dart';

import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';

class ChooseAddress extends StatefulWidget {
  ChooseAddress({Key? key}) : super(key: key);

  LatLng? currentLatLng;

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {

  @override
  void initState() {
    if(MenuCubit.get(context).addressModel!=null){
      if(MenuCubit.get(context).addressModel!.data!.isNotEmpty){
        widget.currentLatLng = LatLng(
            double.parse(MenuCubit.get(context).addressModel!.data![0].latitude!),
            double.parse(MenuCubit.get(context).addressModel!.data![0].longitude!),
        );
      }
    }
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {
    if(state is GetAddressesSuccessState){
      widget.currentLatLng = LatLng(
        double.parse(MenuCubit.get(context).addressModel!.data![0].latitude!),
        double.parse(MenuCubit.get(context).addressModel!.data![0].longitude!),
      );
    }
  },
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
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
            child: ConditionalBuilder(
              condition: cubit.addressModel!=null,
              fallback: (context)=>const Center(child: CupertinoActivityIndicator(),),
              builder: (context)=> ListView.separated(
                  itemBuilder: (c,i)=>itemBuilder(index: i,data:cubit.addressModel!.data![i]),
                  padding: EdgeInsetsDirectional.zero,
                  shrinkWrap: true,
                  separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                  itemCount: cubit.addressModel!.data!.length
              ),
            ),
          ),
          InkWell(
            onTap: ()async{
              await cubit.getCurrentLocation();
              navigateTo(context, AddAddressScreen());
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
  },
);
  }

  Widget itemBuilder({
  required int index,
  required AddressData data,
}){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
          widget.currentLatLng = LatLng(
            double.parse(data.latitude!),
            double.parse(data.longitude!),
          );
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
                    data.title??'',
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),
                  ),
                  Text(
                    data.address??'',
                    maxLines: 2,
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
