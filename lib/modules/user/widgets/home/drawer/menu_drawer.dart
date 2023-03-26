import 'package:flutter/material.dart';

import '../../../../../shared/components/constants.dart';
import '../../../../../shared/images/images.dart';
import 'account_settings.dart';
import 'our_app.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

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
                  Container(
                    width: 98,height: 98,
                    decoration:const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(Images.story,fit: BoxFit.cover,),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if(token !=null)
                          AccountSettings(),
                          OurApp(),
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
