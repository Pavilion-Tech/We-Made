import 'package:flutter/material.dart';
import 'package:wee_made/modules/user/widgets/product/product_grid.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';
import 'package:wee_made/widgets/no_items/no_product.dart';

import '../../../../layouts/provider_layout/provider_cubit/provider_cubit.dart';
import '../../../../layouts/provider_layout/provider_layout.dart';
import '../../../../widgets/no_items/no_pproduct.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround),
          Column(
            children: [
              pDefaultAppBar(
                context: context,title: 'Product Manager',
                action: Image.asset(Images.manageProducts,width: 20,)
              ),
              //Expanded(child: NoPProduct()),
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: ProductGrid(isScroll: false,isProvider: true,)),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,right: 20,left: 20,bottom: 60),
                      child: DefaultButton(
                          text: 'Add Product',
                          onTap: (){
                            ProviderCubit.get(context).changeIndex(2, context);
                            navigateAndFinish(context, ProviderLayout());
                          }
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
