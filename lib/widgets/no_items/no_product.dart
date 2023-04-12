import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';

class NoProduct extends StatelessWidget {
  NoProduct({this.isProduct = true});

  bool isProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.noProducts,width: size!.width*.5,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20),
            child: Text(
              isProduct?tr('no_product'):tr('no_order'),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 21),
            ),
          ),
          DefaultButton(text: tr('back'), onTap: (){
            Navigator.pop(context);
          })
        ],
      ),
    );
  }
}
