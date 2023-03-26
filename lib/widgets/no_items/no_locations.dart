import 'package:flutter/material.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';

import '../../modules/user/menu_screens/address/add_address/add_address_screen.dart';
import '../../shared/components/components.dart';

class NoLocations extends StatelessWidget {
  const NoLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.noLocation,width: size!.width*.5,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:15.0,horizontal: 20),
                child: Text(
                  'No locations yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 21),
                ),
              ),
              Text(
                'You can add new locations now',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
              ),
              const SizedBox(height: 30,),
              DefaultButton(text: 'Add Locations', onTap: ()async{
                await MenuCubit.get(context).getCurrentLocation();
                navigateTo(context, AddAddressScreen());
              })
            ],
          ),
        ),
      ],
    );
  }
}
