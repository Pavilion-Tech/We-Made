import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/modules/auth/login_screen.dart';
import 'package:wee_made/modules/user/widgets/menu/lang.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../splash_screen.dart';
import '../../../../../widgets/default_button.dart';
import '../../../menu_screens/aboutus.dart';
import '../../../menu_screens/terms.dart';
import '../../../menu_screens/contactus_screen.dart';
import '../../menu/delete_dialog.dart';

class OurApp extends StatelessWidget {
  const OurApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            tr('our_app'),
            style: TextStyle(color: Colors.black,fontSize: 32,fontWeight: FontWeight.w500),
          ),
        ),
        itemBuilder(
                image: Images.lang,
                title: tr('change_language'),
                onTap:  (){
                  showModalBottomSheet(
                      context: context,
                      shape:const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(30),
                              topStart: Radius.circular(30))
                      ),
                      builder: (context)=>ChangeLangBottomSheet()
                  );
                }
            ),
        const SizedBox(height: 20,),
        itemBuilder(
            image: Images.email,
            title: tr('contact_us'),
            onTap:  ()=>navigateTo(context, ContactUsScreen())
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: itemBuilder(
              image: Images.info,
              title: tr('about_us'),
              onTap:  ()=>navigateTo(context, AboutUsScreen())
          ),
        ),
        itemBuilder(
            image: Images.lock2,
            title: tr('terms'),
            onTap:  ()=>navigateTo(context, TermsScreen())
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            '${tr('version')} $version',
            style:const TextStyle(fontSize: 17),
          ),
        ),
        Column(
          children: [
            InkWell(
                onTap: ()=>openUrl('https://pavilion-teck.com/'),
                child: Image.asset(Images.pavilion,width: 87,height: 20,)),
            const SizedBox(height: 20,),
            Center(
              child: DefaultButton(
                  text: tr('logout'),
                  width: size!.width*.5,
                  onTap: (){
                    navigateAndFinish(context, LoginScreen());
                  }
              ),
            ),
            TextButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context)=>DeleteDialog((){
                        navigateAndFinish(context, LoginScreen());
                      })
                  );
                },
                child: Text(
                  tr('delete_account'),
                  style: TextStyle(color: defaultColor,fontSize: 17,fontWeight: FontWeight.w500),
                )
            ),
          ],
        )
      ],
    );
  }

  Widget itemBuilder({
    required String image,
    required String title,
    required VoidCallback onTap
  }){
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(image,width:20,height: 20,color: defaultColor,),
          const SizedBox(width: 10,),
          Text(
            title,
            style:const TextStyle(fontSize: 17),
          )

        ],
      ),
    );
  }
}
