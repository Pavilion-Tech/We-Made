import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wee_made/modules/user/widgets/menu/chat/voice_dialog.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../menu/pmenu_cubit/pmenu_cubit.dart';
import 'choose_photo_type.dart';

class PChatBottom extends StatelessWidget {
  const PChatBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = PMenuCubit.get(context);
    return Row(
      children: [
        Expanded(
            child: Container(
                height: 63,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(15)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: cubit.controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Type a Message',
                      hintStyle: const TextStyle(
                          fontSize: 13, color: Colors.grey),
                      suffixIcon: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => PChoosePhotoType()
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(Images.camera, width: 10,),
                        ),
                      )
                  ),
                )
            )
        ),
        const SizedBox(width: 5,),
       // state is! SendMessageWithFileLoadingState?
        InkWell(
          onTap: () async {
            var status = await Permission.microphone.request();
            if (status != PermissionStatus.granted) {
              showToast(msg: 'Microphone permission not granted');
              await openAppSettings();
            } else {
              showDialog(
                  context: context,
                  builder: (context) => VoiceDialog()
              );
            }
          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(15)
            ),
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(Images.microPhone),
            ),
          ),
        ),
            //:const CircularProgressIndicator(),
        const SizedBox(width: 5,),
       // state is! SendMessageLoadingState ?
        InkWell(
          onTap: () {
            if (cubit.controller.text.isNotEmpty) {
            //  cubit.sendMessageWithOutFile();
            }
          },
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(15)
            ),
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(Icons.send, color: defaultColor,),
            ),
          ),
        )
       //     :const CircularProgressIndicator(),
      ],
    );
  }
}
