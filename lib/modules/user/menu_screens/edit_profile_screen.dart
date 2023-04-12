import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/default_form.dart';
import '../../../widgets/image_net.dart';
import '../widgets/menu/choose_photo_type.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if(MenuCubit.get(context).userModel!=null){
      nameC.text = MenuCubit.get(context).userModel!.data!.name??'';
      phoneC.text = MenuCubit.get(context).userModel!.data!.phoneNumber??'';
      emailC.text = MenuCubit.get(context).userModel!.data!.email??'';
    }
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {
    if(state is UpdateProfileSuccessState){
      Navigator.pop(context);
      Navigator.pop(context);
    }
  },
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              defaultAppBar(context: context,title: tr('profile_info'),isMenu: true),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
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
                                    : ImageNet(image:cubit.userModel?.data?.personalPhoto??'',),
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
                              controller: nameC,
                              validator: (val){
                                if(val.isEmpty)return tr('name_empty');
                              },
                              prefix: Image.asset(Images.person,width: 9,),
                            ),
                          ),
                          DefaultForm(
                            hint: tr('phone'),
                            controller: phoneC,
                            textLength: 10,
                            digitsOnly: true,
                            validator: (val){
                              if(val.isEmpty)return tr('phone_empty');
                            },
                            type: TextInputType.phone,
                            prefix: Image.asset(Images.flag,width: 9,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: DefaultForm(
                              hint: tr('email'),
                              controller: emailC,
                              validator: (val){
                                if(val.isEmpty)return tr('email_empty');
                                if(!val.contains('.'))return tr('email_invalid');
                                if(!val.contains('@'))return tr('email_invalid');
                              },
                              type: TextInputType.emailAddress,
                              prefix: Image.asset(Images.email,width: 9,),
                            ),
                          ),
                          state is! UpdateProfileLoadingState ?
                          DefaultButton(
                              text: tr('save'),
                              onTap: (){
                                if(formKey.currentState!.validate()){
                                  MenuCubit.get(context).updateUser(
                                      phone: phoneC.text,
                                      name: nameC.text,
                                      email: emailC.text
                                  );
                                }
                              }
                          ):const Center(child: CupertinoActivityIndicator(),)
                        ],
                      ),
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
