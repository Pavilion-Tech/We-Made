import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../widgets/menu/chat/chat_appbar.dart';
import '../../widgets/menu/chat/chat_body.dart';
import '../../widgets/menu/chat/chat_bottom.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              chatAppBar(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(child: ChatBody()),
                      ChatBottom()

                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
