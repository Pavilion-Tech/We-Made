import 'package:flutter/material.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../splash_screen.dart';
import '../../../../../widgets/default_button.dart';
import '../../../auth/login_screen.dart';
import '../../../user/widgets/menu/delete_dialog.dart';
import '../../../user/widgets/menu/lang.dart';
import '../../menu/paboutus_screen.dart';
import '../../menu/pcontactus_screen.dart';
import '../../menu/pterms_screen.dart';

class POurApp extends StatelessWidget {
  const POurApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Our App',
            style: TextStyle(color: Colors.black,fontSize: 32,fontWeight: FontWeight.w500),
          ),
        ),
        itemBuilder(
                image: Images.lang,
                title: 'Change Language',
                onTap:  (){
                  showModalBottomSheet(
                      context: context,
                      shape:const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(30),
                              topStart: Radius.circular(30))
                      ),
                      builder: (context)=>ChangeLangBottomSheet(isProvider:true)
                  );
                }
            ),
        const SizedBox(height: 20,),
        itemBuilder(
            image: Images.email,
            title: 'Contact Us',
            onTap:  ()=>navigateTo(context, PContactUsScreen())
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: itemBuilder(
              image: Images.info,
              title: 'About Us',
              onTap:  ()=>navigateTo(context, PAboutUsScreen())
          ),
        ),
        itemBuilder(
            image: Images.lock2,
            title: 'Terms & conditions',
            onTap:  ()=>navigateTo(context, PTermsScreen())
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            'Version $version',
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
                  text: 'Logout',
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
                  'Delete Account',
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
