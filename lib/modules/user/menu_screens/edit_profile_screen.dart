import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/default_form.dart';
import '../widgets/menu/choose_photo_type.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

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
          Column(
            children: [
              defaultAppBar(context: context,title: tr('profile_info')),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 180,width: 180,
                              decoration:const BoxDecoration(shape: BoxShape.circle,color: Colors.white,),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child:cubit.profileImage!=null
                                  ?Image.file(File(cubit.profileImage!.path),fit: BoxFit.cover,)
                                  : Image.asset(Images.story,fit: BoxFit.cover,),
                            ),
                            Positioned(
                              bottom: 15,
                              right: 10,
                              child: InkWell(
                                onTap: (){
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context)=>ChooseProfilePhotoType()
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.black54,
                                  child: Image.asset(Images.edit,width: 11,height: 11,),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: DefaultForm(
                            hint: tr('name'),
                            prefix: Image.asset(Images.person,width: 9,),
                          ),
                        ),
                        DefaultForm(
                          hint: tr('phone'),
                          type: TextInputType.phone,
                          prefix: Image.asset(Images.flag,width: 9,),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: DefaultForm(
                            hint: tr('email'),
                            type: TextInputType.emailAddress,
                            prefix: Image.asset(Images.email,width: 9,),
                          ),
                        ),
                        DefaultButton(
                            text: tr('save'),
                            onTap: (){
                              Navigator.pop(context);
                            }
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  },
);
  }
}
