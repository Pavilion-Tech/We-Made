import 'package:flutter/material.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../splash_screen.dart';
import '../../menu/manage_product/manage_products_screen.dart';
import '../../menu/pchat/pchat_history_screen.dart';
import '../../menu/pedit_profile_screen.dart';

class PAccountSettings extends StatelessWidget {
  const PAccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: ()=>navigateAndFinish(context, SplashScreen()),
          child: Text(
            'Sign In Now',
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0,bottom: 40),
          child: Column(
            children: [
              itemBuilder(
                  image: Images.person,
                  title: 'Profile info',
                  onTap:  (){
                    navigateTo(context, PEditProfileScreen());
                  }
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: itemBuilder(
                    image: Images.manageProducts,
                    title: 'Manage Products',
                    onTap:  ()=>navigateTo(context, ManageProductsScreen())
                ),
              ),
              itemBuilder(
                  image: Images.send,
                  title: 'Chats',
                  onTap:  ()=>navigateTo(context, PChatHistoryScreen())
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
