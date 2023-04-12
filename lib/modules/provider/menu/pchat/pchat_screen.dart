import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/images/images.dart';
import '../../widgets/menu/chat/chat_appbar.dart';
import '../../widgets/menu/chat/chat_body.dart';
import '../../widgets/menu/chat/chat_bottom.dart';
import '../pmenu_cubit/pmenu_cubit.dart';
import '../pmenu_cubit/pmenu_states.dart';

class PChatScreen extends StatefulWidget {
  PChatScreen(this.id);

  String id;

  @override
  State<PChatScreen> createState() => _PChatScreenState();
}

class _PChatScreenState extends State<PChatScreen> {

  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      PMenuCubit.get(context).singleChat(widget.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PMenuCubit, PMenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PMenuCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                Images.backGround, width: double.infinity, fit: BoxFit.cover,),
              ConditionalBuilder(
                condition: cubit.chatModel!=null,
                fallback: (context)=>const Center(child: CupertinoActivityIndicator(),),
                builder: (context)=> Column(
                  children: [
                    PChatAppBar(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            ConditionalBuilder(
                                condition: cubit.chatModel!.data!.messages!.isNotEmpty,
                                fallback: (context)=>const Expanded(child:  SizedBox()),
                                builder: (context)=> Expanded(child: PChatBody())
                            ),
                            PChatBottom()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
