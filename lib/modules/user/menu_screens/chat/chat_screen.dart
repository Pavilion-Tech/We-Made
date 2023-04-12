import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_states.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../widgets/menu/chat/chat_appbar.dart';
import '../../widgets/menu/chat/chat_body.dart';
import '../../widgets/menu/chat/chat_bottom.dart';
import '../menu_cubit/menu_cubit.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(this.id);

  String id;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      MenuCubit.get(context).singleChat(widget.id);
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
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MenuCubit.get(context);
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
                    chatAppBar(context),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            ConditionalBuilder(
                                condition: cubit.chatModel!.data!.messages!.isNotEmpty,
                                fallback: (context)=>const Expanded(child:  SizedBox()),
                                builder: (context)=> Expanded(child: ChatBody())
                            ),
                            ChatBottom()
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
