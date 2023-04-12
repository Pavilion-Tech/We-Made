import 'package:flutter/material.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';

import '../../../../../shared/images/images.dart';
import '../../../shared/components/constants.dart';
import '../../../widgets/image_net.dart';
import '../widgets/menu/paccount_settings.dart';
import '../widgets/menu/pour_app.dart';

class PMenuDrawer extends StatelessWidget {
  const PMenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Image.asset(Images.backGround,fit: BoxFit.cover,height: double.infinity,),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(token !=null)
                    Container(
                      width: 98,height: 98,
                      decoration:const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:ImageNet(image:ProviderCubit.get(context).providerModel?.data?.personalPhoto??'',),
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          PAccountSettings(),
                          POurApp(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
