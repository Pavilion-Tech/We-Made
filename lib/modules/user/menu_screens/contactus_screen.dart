import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_states.dart';
import 'package:wee_made/widgets/default_button.dart';

import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  List<String> images = [
    Images.gmail2,
    Images.whats2,
    Images.face2,
    Images.twitter2,
    Images.insta2,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Image.asset(Images.contactBack,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              defaultAppBar(context: context,title: tr('contact_us'),haveCart: false),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        if(cubit.settingsModel!=null)
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemBuilder(
                                image: images[0],
                                onTap:(){
                                  final Uri params = Uri(
                                    scheme: 'mailto',
                                    path: cubit.settingsModel?.data?.projectEmailAddress??'',
                                  );
                                  final url = params.toString();
                                  openUrl(url);
                                }
                            ),
                            itemBuilder(
                                image: images[1],
                                onTap:(){
                                  String phone = cubit.settingsModel?.data?.projectWhatsAppNumber ?? '';
                                  String waUrl = 'https://wa.me/$phone';
                                  openUrl(waUrl);
                                }
                            ),
                            itemBuilder(
                                image: images[2],
                                onTap:(){
                                  openUrl(cubit.settingsModel?.data?.projectFacebookLink??'');
                                }
                            ),
                            itemBuilder(
                                image: images[3],
                                onTap:(){
                                  openUrl(cubit.settingsModel?.data?.projectTwitterLink??'');
                                }
                            ),
                            itemBuilder(
                                image: images[4],
                                onTap:(){
                                  openUrl(cubit.settingsModel?.data?.projectInstagramLink??'');
                                }
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.only(start: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadiusDirectional.circular(10),
                              border: Border.all(color: Colors.grey)
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: tr('subject')
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsetsDirectional.only(start: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadiusDirectional.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: TextFormField(
                            maxLines: 5,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: tr('your_message')
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        DefaultButton(text: tr('send_message'), onTap: (){})
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  },
);
  }

  Widget itemBuilder({
  required String image,
  required VoidCallback onTap
}){
    return InkWell(
      onTap: onTap,
        child: Image.asset(image,width: 20,height: 20,));
  }
}
