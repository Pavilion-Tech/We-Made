import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:wee_made/widgets/no_items/no_locations.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../widgets/default_button.dart';
import '../../widgets/menu/address/address_item.dart';
import '../../widgets/shimmer/shimmer_shared.dart';
import 'add_address/add_address_screen.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                  defaultAppBar(context: context, title: tr('addresses'),isMenu: true),
                  ConditionalBuilder(
                    condition: cubit.addressModel!=null,
                    fallback: (context)=>const ShimmerShared(),
                    builder: (context)=> ConditionalBuilder(
                      condition: cubit.addressModel!.data!.isNotEmpty,
                      fallback: (context)=>Expanded(child: NoLocations()),
                      builder: (context)=> Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                    itemBuilder: (c, i) => AddressItem(cubit.addressModel!.data![i]),
                                    separatorBuilder: (c, i) =>
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    itemCount: cubit.addressModel!.data!.length
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: DefaultButton(
                                    text: tr('add_address'),
                                    onTap: () async {
                                      await cubit.getCurrentLocation();
                                      navigateTo(context, AddAddressScreen());
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
