import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../splash_screen.dart';
import '../../../menu_screens/address/address_screen.dart';
import '../../../menu_screens/chat/chat_history_screen.dart';
import '../../../menu_screens/edit_profile_screen.dart';
import '../../../menu_screens/fav_screen.dart';
import '../../../menu_screens/notification.dart';
import '../../../menu_screens/order/order_history_screen.dart';
import '../../item_shared/filter.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: ()=>navigateAndFinish(context, SplashScreen()),
          child: Text(
          tr('sign_in_now'),
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.w700),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: itemBuilder(
                  image: Images.person,
                  title: tr('profile_info'),
                  onTap:  (){
                    navigateTo(context, EditProfileScreen());
                  }
              ),
            ),
            itemBuilder(
                image: Images.orderHistory,
                title: tr('order_history'),
                onTap:  ()=>navigateTo(context, OrderHistoryScreen())
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: itemBuilder(
                  image: Images.address,
                  title: tr('addresses'),
                  onTap:  ()=>navigateTo(context, AddressScreen())
              ),
            ),
            itemBuilder(
                image: Images.notification,
                title: tr('notifications'),
                onTap:  ()=>navigateTo(context, NotificationScreen())
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: itemBuilder(
                  image: Images.fav,
                  title: tr('favorites'),
                  onTap:  ()=>navigateTo(context, FavScreen())
              ),
            ),
            itemBuilder(
                image: Images.send,
                title: tr('chats'),
                onTap:  ()=>navigateTo(context, ChatHistoryScreen())
            ),
            const SizedBox(height: 40,)
          ],
        ),
      ],
    );
  }

  Widget itemBuilder(
      {required String image,
      required String title,
      required VoidCallback onTap}) {
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
