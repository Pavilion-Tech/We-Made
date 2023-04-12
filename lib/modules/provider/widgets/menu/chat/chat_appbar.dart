import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_cubit.dart';
import 'package:wee_made/modules/provider/widgets/menu/chat/sendoffer_dialog.dart';

import '../../../../../shared/styles/colors.dart';

class PChatAppBar extends StatelessWidget {
  const PChatAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      leading: IconButton(
        onPressed: ()=>Navigator.pop(context),
        icon: Icon(Icons.arrow_back,color: Colors.black,),
      ),
      title: Text(PMenuCubit.get(context).chatModel!.data!.userName??'',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26,color: Colors.black),),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: InkWell(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context)=>SendOfferDialog(PMenuCubit.get(context).chatModel!.data!.id??'')
              );
            },
            child: Container(
              height: 41,
              decoration: BoxDecoration(
                color: defaultColor,
                borderRadius: BorderRadiusDirectional.circular(12),
              ),
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                tr('send_offer'),
                style:const TextStyle(
                    color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
