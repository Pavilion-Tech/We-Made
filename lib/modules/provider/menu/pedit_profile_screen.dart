import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_cubit.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_states.dart';
import '../../../layouts/provider_layout/provider_cubit/provider_cubit.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../../../widgets/default_button.dart';
import '../../../widgets/default_form.dart';
import '../../../widgets/image_net.dart';
import '../../auth/auth_cubit/auth_cubit.dart';
import '../widgets/auth/category_form.dart';
import '../widgets/auth/dropdownfield.dart';
import '../widgets/auth/spcial_request.dart';
import '../widgets/menu/edit_profile/choose_category.dart';
import '../widgets/menu/edit_profile/choose_photo_type.dart';

class PEditProfileScreen extends StatefulWidget {
  PEditProfileScreen({Key? key}) : super(key: key);

  @override
  State<PEditProfileScreen> createState() => _PEditProfileScreenState();
}

class _PEditProfileScreenState extends State<PEditProfileScreen> {

  String? cityTitle;

  String? neighborhoodTitle;

  late CustomDropDownField cityDropDown;

  TextEditingController storeC = TextEditingController();

  TextEditingController ownerC = TextEditingController();

  TextEditingController emailC = TextEditingController();

  TextEditingController phoneC = TextEditingController();

  TextEditingController addressC = TextEditingController();

  TextEditingController categoryC = TextEditingController();

  TextEditingController idC = TextEditingController();

  TextEditingController commercialC = TextEditingController();

  List<String> categoryValues = [];

  var formKey = GlobalKey<FormState>();

  SpecialRequest specialRequest = SpecialRequest();

  @override
  void initState(){
    var c = ProviderCubit.get(context);
    if(c.providerModel!=null){
      // getImage();
      // print(c.userModel!.data!.hasSpecialRequests);
      PMenuCubit.get(context).getNeighborhood(c.providerModel!.data!.cityId??'');
      storeC.text = c.providerModel!.data!.storeName??'';
      ownerC.text = c.providerModel!.data!.ownerName??'';
      emailC.text = c.providerModel!.data!.email??'';
      phoneC.text = c.providerModel!.data!.phoneNumber??'';
      idC.text = c.providerModel!.data!.idNumber??'';
      commercialC.text = c.providerModel!.data!.commercialRegisterationNumber??'';
      c.providerModel!.data!.categoryId!.forEach((element) {
        categoryValues.add(element.id!);
      });
      specialRequest =SpecialRequest(currentIndex:c.providerModel!.data!.hasSpecialRequests??1) ;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PMenuCubit.get(context).getCities();
    PMenuCubit.get(context).getCategory();
    return BlocConsumer<PMenuCubit, PMenuStates>(
  listener: (context, state) {
    if(state is UpdateProviderSuccessState){
      Navigator.pop(context);Navigator.pop(context);
    }
  },
  builder: (context, state) {
    var cubit = PMenuCubit.get(context);
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
                                child: cubit.profileImage!=null
                                    ?Image.file(File(cubit.profileImage!.path),fit: BoxFit.cover,height: double.infinity,)
                                    :ImageNet(image: ProviderCubit.get(context).providerModel!.data!.personalPhoto??''),
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
                          const SizedBox(height: 20,),
                          DefaultForm(
                            hint: tr('owner_name'),
                            controller: ownerC,
                            validator: (val){
                              if(val.isEmpty)return tr('name_empty');
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: DefaultForm(
                              hint: tr('family_name'),
                              controller: storeC,
                              validator: (val){
                                if(val.isEmpty)return tr('name_empty');
                              },
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
                              type: TextInputType.emailAddress,
                              controller: emailC,
                              validator: (val){
                                if(val.isEmpty)return tr('email_empty');
                                if(!val.contains('.'))return tr('email_invalid');
                                if(!val.contains('@'))return tr('email_invalid');
                              },
                            ),
                          ),
                          ConditionalBuilder(
                              condition: cubit.citiesModel!=null,
                              fallback: (context)=>const SizedBox(height: 20,),
                              builder: (context){
                                if(PMenuCubit.get(context).citiesModel!=null){
                                  PMenuCubit.get(context).citiesModel!.data!.forEach((element) {
                                    if(element.id == ProviderCubit.get(context).providerModel!.data!.cityId){
                                      cubit.cityValue = element.id??'';
                                      cityTitle = element.name??'';
                                    }
                                  });
                                }
                                cityDropDown = CustomDropDownField(
                                  value: cubit.cityValue,
                                  list: cubit.citiesModel!.data!,
                                  hint: tr('city'),
                                  isCity: true,
                                  isEdit: true,
                                  title: cityTitle,
                                  id: ProviderCubit.get(context).providerModel?.data?.cityId,

                                );
                                return cityDropDown;
                              }
                          ),
                          ConditionalBuilder(
                              condition: state is GetNeighborhoodLoadingState,
                              builder: (context)=>Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Center(child: CupertinoActivityIndicator(),),
                              ),
                              fallback: (context)=>const SizedBox()
                          ),
                          ConditionalBuilder(
                              condition: cubit.neighborhoodModel!=null,
                              fallback: (context)=>const SizedBox(height: 20,),
                              builder: (context){
                                PMenuCubit.get(context).neighborhoodModel!.data!.forEach((element) {
                                  if(element.id == ProviderCubit.get(context).providerModel!.data!.neighborhoodId){
                                    neighborhoodTitle = element.name??'';
                                    cubit.neighborhoodValue = element.id??'';
                                  }
                                });
                                cubit.neighborhoodDropDown = CustomDropDownField(
                                  value: cubit.neighborhoodValue,
                                  list: cubit.neighborhoodModel!.data!,
                                  isNe: true,
                                  hint: tr('neighborhood'),
                                  isEdit: true,
                                  id: ProviderCubit.get(context).providerModel?.data?.neighborhoodId,
                                  title: neighborhoodTitle,
                                );
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                                  child: cubit.neighborhoodDropDown,
                                );
                              }
                          ),
                          ConditionalBuilder(
                            condition: cubit.categoryModel!=null,
                            fallback: (context)=> const SizedBox(height: 20,),
                            builder: (context){
                              var c = ProviderCubit.get(context);
                              cubit.categoryModel!.data!.forEach((element) {
                                if(c.providerModel!.data!.categoryId!.any((element2) => element2.id == element.id)){
                                  if(!categoryC.text.contains(element.title!)){
                                    categoryC.text += element.title??'';
                                  }
                                  if(!categoryValues.contains(element.id)){
                                    categoryValues.add(element.id??'');
                                  }
                                }
                              });
                              return ChooseCategory(
                              controller: categoryC,
                              values: categoryValues,
                              data:cubit.categoryModel!.data!,
                              validator: (str){
                                if(str.isEmpty)return tr('category_empty');
                              },
                            );
                            }
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: DefaultForm(
                              controller: idC,
                              hint: tr('id_number'),
                              type: TextInputType.number,
                              validator: (str){
                                if(str.isEmpty)return tr('id_number_empty');
                              },
                            ),
                          ),
                          specialRequest,
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: DefaultForm(
                              controller: commercialC,
                              hint: tr('commercial_registration'),
                              validator: (str){
                                if(str.isEmpty)return tr('commercial_registration_empty');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 60),
                child: ConditionalBuilder(
                  condition: state is! UpdateProviderLoadingState,
                  fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                  builder: (context)=> DefaultButton(text: tr('save'), onTap: (){
                    if(formKey.currentState!.validate()){
                      print(cubit.cityValue);
                      if(cubit.cityValue!=null){
                        if(cubit.neighborhoodDropDown.value!=null){
                          cubit.updateUser(
                              context: context,
                              phone: phoneC.text,
                              storeName: storeC.text,
                              ownerName: ownerC.text,
                              email: emailC.text,
                              cityId: cubit.cityValue!,
                              neighborhoodId: cubit.neighborhoodDropDown.value,
                              idNum: idC.text,
                              commercial: commercialC.text,
                              special: specialRequest.currentIndex,
                              categories: categoryValues,
                              id: userId??'',
                              file:cubit.profileImage!=null? File(cubit.profileImage!.path):null

                          );
                        }else{
                          showToast(msg: 'Choose Neighborhood');
                        }

                      }else{
                        showToast(msg: 'Information Not Completed');
                      }
                    }

                  }),
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
