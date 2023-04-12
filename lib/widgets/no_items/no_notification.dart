import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';

class NoNotification extends StatelessWidget {
  NoNotification({this.isMenu = false,this.isProvider = false});
  bool isMenu;
  bool isProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.notification2,width: size!.width*.7,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20),
            child: Text(
              tr('no_notifications'),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 21),
            ),
          ),
          if(!isProvider)
          DefaultButton(text: tr('start_shopping'), onTap: (){
            Navigator.pop(context);
            if(isMenu) Navigator.pop(context);
          })
        ],
      ),
    );
  }
}
