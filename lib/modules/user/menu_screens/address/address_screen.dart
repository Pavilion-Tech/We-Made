import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../widgets/default_button.dart';
import '../../widgets/menu/address/address_item.dart';
import 'add_address/add_address_screen.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Images.backGround,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              defaultAppBar(context: context, title: tr('addresses')),
              //  Expanded(child: NoLocations())
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (c, i) => AddressItem(),
                            separatorBuilder: (c, i) => const SizedBox(
                                  height: 20,
                                ),
                            itemCount: 5),
                      ),
                      DefaultButton(
                          text: tr('add_address'),
                          onTap: () async {
                            if (cubit.position != null) {
                              navigateTo(context, AddAddressScreen());
                            } else {
                              await cubit.getCurrentLocation();
                              if (cubit.position != null) {
                                navigateTo(context, AddAddressScreen());
                              }
                            }
                          })
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
