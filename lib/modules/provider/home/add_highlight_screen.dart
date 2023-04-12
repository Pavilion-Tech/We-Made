import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_states.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/shared/styles/colors.dart';
import 'package:wee_made/widgets/default_button.dart';
import 'package:wee_made/widgets/default_form.dart';

import '../widgets/home/choose_highlight_type.dart';

class AddHighlightScreen extends StatelessWidget {
  const AddHighlightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderStates>(
  listener: (context, state) {
    if(state is AddHighlightSuccessState)Navigator.pop(context);
  },
  builder: (context, state) {
    var cubit = ProviderCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround),
          Column(
            children: [
              pDefaultAppBar(
                context: context,
                title: tr('add_highlight'),
                action: Image.asset(Images.addNo,width: 20,color: defaultColor,)
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        //DefaultForm(hint: 'Highlight title'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context)=>ChooseHighlightPhoto()
                              );
                            },
                            child: Container(
                              height: 43,width: 143,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.circular(10),
                                  border: Border.all(color: Colors.black)
                              ),
                              alignment: AlignmentDirectional.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Images.camera2 ,color: defaultColor,width: 20,),
                                  const SizedBox(width: 10,),
                                  Text(
                                    tr('upload_image'),
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (cubit.highlightImage!=null)
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Image.file(
                                    File(cubit.highlightImage!.path),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        cubit.highlightImage=null;
                                        cubit.justEmit();
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ]),
                          ),
                        const SizedBox(height: 20,),
                        state is! AddHighlightLoadingState ?
                        DefaultButton(
                            text: tr('add_highlight'),
                            onTap: (){
                              if(cubit.highlightImage!=null){
                                cubit.addHighlight();
                              }else{
                                showToast(msg: tr('upload_image'));
                              }
                            }
                        ):Center(child: CupertinoActivityIndicator(),)
                      ],
                    ),
                  ),
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
