import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../widgets/default_button.dart';
import '../../../menu_screens/menu_cubit/menu_cubit.dart';
import '../../../menu_screens/menu_cubit/menu_states.dart';

class VoiceDialog extends StatefulWidget {

  @override
  State<VoiceDialog> createState() => _VoiceDialogState();
}

class _VoiceDialogState extends State<VoiceDialog> {

  final recorder = FlutterSoundRecorder();

  @override
  void initState(){
    super.initState();
    init();
  }

  @override
  void dispose() {
    recorder.stopRecorder().then((value)
    => recorder.deleteRecord(fileName:value!));
    recorder.closeRecorder();
    super.dispose();
  }

  Future init ()async{
    await recorder.openRecorder().then((value) async{
      await start();

    });
  }

  Future start ()async{
    await recorder.startRecorder(toFile: 'audio');
    await recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state2) {
        //  if(state2 is SendMessageWithFileLoadingState)Navigator.pop(context);
      },
      builder: (context, state2) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(20)
          ),
          content: Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(20)
            ),
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Image.asset(Images.checkoutAlert,width: 50,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: StreamBuilder<RecordingDisposition>(
                        stream: recorder.onProgress,
                        builder:(context,snapshot){
                          final duration = snapshot.hasData?snapshot.data!.duration:Duration.zero;
                          String twoDigits (int n)=>n.toString().padLeft(2,'0');
                          final twoDigitsMinutes = twoDigits(duration.inMinutes.remainder(60));
                          final twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));
                          return Text(
                            '${tr('you_wait')} $twoDigitsMinutes:$twoDigitsSeconds ${tr('have_reply')}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15.5),
                          );
                        }
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child:DefaultButton(
                          text: tr('continue'),
                          onTap: ()async{
                            final path =
                            await recorder.stopRecorder();

                          }
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                        child:InkWell(
                          onTap: ()async{
                            final path = await recorder.stopRecorder();
                            recorder.deleteRecord(fileName:path!);
                            await start();
                          },                            child: Container(
                          height: 51,
                          width:double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(10),
                              color: defaultColor
                          ),
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            'Try Else',
                            style:const TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w700),
                          ),
                        ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}

