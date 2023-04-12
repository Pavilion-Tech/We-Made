import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_states.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../widgets/default_button.dart';
import '../../../../layouts/provider_layout/provider_cubit/provider_cubit.dart';
import '../../../user/widgets/menu/image_bottom.dart';


class ChooseHighlightPhoto extends StatefulWidget {



  @override
  State<ChooseHighlightPhoto> createState() => _ChooseHighlightPhotoState();
}

class _ChooseHighlightPhotoState extends State<ChooseHighlightPhoto> {
  void chooseImage(ImageSource source, BuildContext context) async {
    var cubit = ProviderCubit.get(context);
    cubit.highlightImage = await cubit.pick(source);
    cubit.highlightImage = await checkImageSize(cubit.highlightImage);
    cubit.justEmit();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderStates>(
      listener: (context, state) {
      //  if(state is SendMessageSuccessState)Navigator.pop(context);
      },
      builder: (context, state) {
        var cubit = ProviderCubit.get(context);
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
              if(cubit.highlightImage!=null)
              Expanded(child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.file(File(cubit.highlightImage!.path),fit: BoxFit.cover,),
                  InkWell(
                    onTap: (){
                      cubit.highlightImage= null;
                      cubit.justEmit();
                    },
                      child: Image.asset(Images.delete,color: Colors.red,width: 30,))
                ],
              )),
              if(cubit.highlightImage!=null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child:DefaultButton(
                      text: tr('send'),
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
