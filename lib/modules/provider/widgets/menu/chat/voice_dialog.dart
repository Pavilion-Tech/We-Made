import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../widgets/default_button.dart';
import '../../../menu/pmenu_cubit/pmenu_cubit.dart';

class PVoiceDialog extends StatefulWidget {
  PVoiceDialog(this.id);

  String id;
  @override
  State<PVoiceDialog> createState() => _PVoiceDialogState();
}

class _PVoiceDialogState extends State<PVoiceDialog> {


  final recorder = FlutterSoundRecorder();

  String pathToAudio = '';

  @override
  void initState(){
    init();
    super.initState();
  }

  @override
  void dispose() {
    recorder.stopRecorder().then((value)
    => recorder.deleteRecord(fileName:value!));
    recorder.closeRecorder();
    super.dispose();
  }

  Future init ()async{
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth |
      AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
    await recorder.openRecorder().then((value) async{
      await start();
    });
  }


  Future start ()async{
    if (Platform.isIOS) {
      var directory = await getTemporaryDirectory();
      pathToAudio = directory.path + '/';
    } else {
      pathToAudio = '/sdcard/Download/appname/';
    }
    await recorder.startRecorder(
      toFile:filePathName(),
    );
    await recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
    setState(() {});
  }

  String filePathName() =>
      pathToAudio +
          DateTime.now().month.toString() +
          DateTime.now().day.toString() +
          DateTime.now().hour.toString() +
          DateTime.now().minute.toString() +
          DateTime.now().second.toString() +
          (Platform.isIOS ? ".mp4" : ".m4a");


  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
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
                        PMenuCubit.get(context).sendMessageWithFile(
                            type: 3,
                            id: widget.id,
                            file: File(path!)
                        );
                        Navigator.pop(context);

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
                      },
                      child: Container(
                      height: 51,
                      width:double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(10),
                          color: defaultColor
                      ),
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        tr('try_else'),
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

  }
}

