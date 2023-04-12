import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../splash_screen.dart';
import '../../menu/manage_product/manage_products_screen.dart';
import '../../menu/pchat/pchat_history_screen.dart';
import '../../menu/pedit_profile_screen.dart';
import '../../menu/pmenu_cubit/pmenu_cubit.dart';

class PAccountSettings extends StatelessWidget {
  const PAccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0,bottom: 40),
          child: Column(
            children: [
              itemBuilder(
                  image: Images.person,
                  title: tr('profile_info'),
                  onTap:  (){
                    navigateTo(context, PEditProfileScreen());
                  }
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: itemBuilder(
                    image: Images.manageProducts,
                    title: tr('manage_products'),
                    onTap:  (){
                      PMenuCubit.get(context).getProducts();
                      navigateTo(context, ManageProductsScreen());
                    }
                ),
              ),
              itemBuilder(
                  image: Images.send,
                  title: tr('chats'),
                  onTap:  (){
                    PMenuCubit.get(context).chatHistory();
                    navigateTo(context, PChatHistoryScreen(isMenu: true,));
                  }
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget itemBuilder({
    required String image,
      required String title,
      required VoidCallback onTap
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            image,
            width: 20,
            height: 20,
            color: defaultColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }
}
