import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:wee_made/modules/user/menu_screens/chat/chat_screen.dart';
import 'package:wee_made/shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../widgets/default_button.dart';
import '../../../menu_screens/menu_cubit/menu_cubit.dart';
import '../../../menu_screens/menu_cubit/menu_states.dart';

class SpecialDialog extends StatefulWidget {
  SpecialDialog(this.id);
  String id;

  @override
  State<SpecialDialog> createState() => _VoiceDialogState();
}

class _VoiceDialogState extends State<SpecialDialog> {



  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state2) {
        if(state2 is AskRequestSuccessState){

        }
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
                Image.asset(Images.confirmDialog,width: 50,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      tr('special_sure'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15.5),
                    ),
                  ),
                ),
                Row(
                  children: [

                    Expanded(
                      child:state2 is! AskRequestLoadingState?DefaultButton(
                          text: tr('continue'),
                          onTap: ()async{
                            MenuCubit.get(context).askForRequest(
                                id: widget.id,
                                file: File(''),
                              context:context,
                            );
                          }
                      ):CupertinoActivityIndicator(),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                        child:InkWell(
                          onTap: (){
                           Navigator.pop(context);
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
                              tr('discard'),
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

