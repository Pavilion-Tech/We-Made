import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_cubit.dart';
import 'package:wee_made/modules/user/widgets/product/product_grid.dart';
import 'package:wee_made/modules/user/widgets/shimmer/product_shimmer.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';
import 'package:wee_made/widgets/no_items/no_product.dart';

import '../../../../layouts/provider_layout/provider_cubit/provider_cubit.dart';
import '../../../../layouts/provider_layout/provider_layout.dart';
import '../../../../widgets/no_items/no_pproduct.dart';
import '../pmenu_cubit/pmenu_states.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PMenuCubit, PMenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PMenuCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(Images.backGround),
              Column(
                children: [
                  pDefaultAppBar(
                      context: context, title: tr('manage_products'),
                      action: Image.asset(Images.manageProducts, width: 20,),
                      isMenu: true
                  ),
                  ConditionalBuilder(
                    condition: cubit.providerProductsModel!=null,
                    fallback: (context)=>ProductShimmer(isProvider: true,),
                    builder: (context)=>ConditionalBuilder(
                      condition: cubit.providerProductsModel!.data!.data!.isNotEmpty,
                      fallback: (context)=>Expanded(child: NoPProduct()),
                      builder: (context)=> Expanded(
                        child: Column(
                          children: [
                            Expanded(child: ProductGrid(
                              isScroll: false,
                              isProvider: true,
                              products: cubit.providerProductsModel!.data!.data!,
                            )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, left: 20, bottom: 60),
                              child: DefaultButton(
                                  text: tr('add_product'),
                                  onTap: () {
                                    ProviderCubit.get(context).changeIndex(
                                        2, context);
                                    navigateAndFinish(context, ProviderLayout());
                                  }
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )

                ],
              )
            ],
          ),
        );
      },
    );
  }
}
