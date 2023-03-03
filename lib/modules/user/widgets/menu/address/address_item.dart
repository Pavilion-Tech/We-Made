import 'package:flutter/material.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../menu_screens/address/add_address/add_address_screen.dart';
import '../../../menu_screens/menu_cubit/menu_cubit.dart';
import '../delete_dialog.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({Key? key}) : super(key: key);

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
                        'Home',
                        style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context)=>DeleteDialog((){
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
                          '26985 Brighton Lane, Lake Forest, CA 92630.26985 Brighton Lane, Lake Forest, CA 92630.',
                          maxLines: 1,
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      InkWell(
                          onTap:()async{
                            if (cubit.position != null) {
                              navigateTo(context, AddAddressScreen());
                            } else {
                              await cubit.getCurrentLocation();
                              if (cubit.position != null) {
                                navigateTo(context, AddAddressScreen());
                              }
                            }
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
