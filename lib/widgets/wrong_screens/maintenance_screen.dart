import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Images.maintenance,width: size!.width*.5,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20),
                  child: Text(
                    tr('maintenance_title'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 21),
                  ),
                ),
                Text(
                  tr('maintenance_desc'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
