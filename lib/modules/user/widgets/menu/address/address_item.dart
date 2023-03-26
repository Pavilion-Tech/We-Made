import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wee_made/models/user/address_model.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../menu_screens/address/add_address/add_address_screen.dart';
import '../../../menu_screens/menu_cubit/menu_cubit.dart';
import '../delete_dialog.dart';

class AddressItem extends StatelessWidget {
  AddressItem(this.address);
  AddressData address;
  @override
  Widget build(BuildContext context) {
    var cubit = MenuCubit.get(context);
    return Container(
      height: 93,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: defaultColor.withOpacity(.3)
      ),
      padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Row(
        children: [
          Image.asset(Images.address,width: 16,height: 17,),
          const SizedBox(width: 15,),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        address.title??'',
                        style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context)=>DeleteDialog((){
                                cubit.deleteAddresses(id: address.id??'');
                                Navigator.pop(context);
                              })
                          );
                        },
                          child: Image.asset(Images.delete,width: 18,))
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          address.address??'',
                          maxLines: 2,
                          style: TextStyle(fontSize: 13,height: 1.2),
                        ),
                      ),
                      InkWell(
                          onTap:()async{
                            navigateTo(context, AddAddressScreen(
                              addressData: address,
                              latLng: LatLng(
                              double.parse(address.latitude??''),
                              double.parse(address.longitude??''),
                            ),));
                          },
                          child: Image.asset(Images.edit,width: 18,color: Colors.black,))
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
