import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/provider_layout/provider_layout.dart';
import 'package:wee_made/shared/components/constants.dart';
import '../../layouts/user_layout/user_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/images/images.dart';
import '../../widgets/default_button.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20)
      ),
      child: InkWell(
        onTap: (){
          if(userType == 'user'){
            navigateAndFinish(context, UserLayout());
          }else{
            navigateAndFinish(context, ProviderLayout());
          }
        },
        child: Container(
          height: 330,
          child: Stack(
            children: [
              Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
              Padding(
                padding:const EdgeInsets.symmetric(vertical: 40,horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(Images.confirmDialog,width: 100,),
                    Text(
                      tr('phone_confirmed'),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,height: 1.2),
                    ),
                    DefaultButton(
                        text: tr('done'),
                        onTap: (){
                          if(userType == 'user'){
                            navigateAndFinish(context, UserLayout());
                          }else{
                            navigateAndFinish(context, ProviderLayout());
                          }
                        }
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
