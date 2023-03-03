import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_cubit.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/default_form.dart';
import '../widgets/menu/edit_profile/choose_category.dart';
import '../widgets/menu/edit_profile/choose_photo_type.dart';

class PEditProfileScreen extends StatelessWidget {
  PEditProfileScreen({Key? key}) : super(key: key);

  //List<String> dropItems

  String? val;
  TextEditingController controller = TextEditingController();
  List<String> categoryValues = [];
  List<CategoryData> data = [
    CategoryData(id: '1',name: 'Category1'),
    CategoryData(id: '2',name: 'Category2'),
    CategoryData(id: '3',name: 'Category3'),
    CategoryData(id: '4',name: 'Category4'),
  ];


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PMenuCubit, PMenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = PMenuCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              defaultAppBar(context: context,title: 'Edit Profile'),
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
                                      builder: (context) => PChooseProfilePhotoType()
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
                            hint: 'Family Name',
                          ),
                        ),
                        DefaultForm(
                          hint: 'Phone Number',
                          type: TextInputType.phone,
                          prefix: Image.asset(Images.flag,width: 9,),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: DefaultForm(
                            hint: 'Email Address',
                            type: TextInputType.emailAddress,
                          ),
                        ),
                        DefaultForm(
                          hint: 'Neighborhood*',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: DefaultForm(
                            hint: 'Address*',
                          ),
                        ),
                        DefaultForm(
                          hint: 'Category',
                          readOnly: true,
                          controller: controller,
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context)=>CategoryDialog(
                                  controller: controller,
                                  data: data,
                                  values: categoryValues,
                                )
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 60),
                child: DefaultButton(
                    text: 'Save',
                    onTap: (){}
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
}

class CategoryData {
  String id;
  String name;
  CategoryData({required this.id,required this.name});


}
