import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../widgets/default_button.dart';
import '../../../../user/widgets/menu/image_bottom.dart';
import '../../../menu/pmenu_cubit/pmenu_cubit.dart';
import '../../../menu/pmenu_cubit/pmenu_states.dart';


class PChooseProfilePhotoType extends StatefulWidget {



  @override
  State<PChooseProfilePhotoType> createState() => _PChooseProfilePhotoTypeState();
}

class _PChooseProfilePhotoTypeState extends State<PChooseProfilePhotoType> {
  void chooseImage(ImageSource source, BuildContext context) async {
    var cubit = PMenuCubit.get(context);
    cubit.profileImage = await cubit.pick(source);
    cubit.profileImage = await checkImageSize(cubit.profileImage);
    cubit.justEmit();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PMenuCubit, PMenuStates>(
      listener: (context, state) {
      //  if(state is SendMessageSuccessState)Navigator.pop(context);
      },
      builder: (context, state) {
        var cubit = PMenuCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(tr('select_image'), style:const TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),
              Row(
                children: [
                  ImageButtom(
                      onTap: () {
                        chooseImage(ImageSource.gallery, context);
                      },
                      title: tr('browse'),
                      image: Images.browse
                  ),
                  const Spacer(),
                  ImageButtom(
                      onTap: () {
                        chooseImage(ImageSource.camera, context);
                      },
                      title: tr('camera'),
                      image: Images.camera
                  ),
                ],
              ),
              if(cubit.profileImage!=null)
              Expanded(child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.file(File(cubit.profileImage!.path),fit: BoxFit.cover,),
                  InkWell(
                    onTap: (){
                      cubit.profileImage= null;
                      cubit.justEmit();
                    },
                      child: Image.asset(Images.delete,color: Colors.red,width: 30,))
                ],
              )),
              if(cubit.profileImage!=null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child:DefaultButton(
                      text: 'Send',
                      onTap: ()=>Navigator.pop(context)
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
