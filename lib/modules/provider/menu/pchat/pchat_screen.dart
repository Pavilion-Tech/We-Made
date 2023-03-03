import 'package:flutter/material.dart';
import '../../../../shared/images/images.dart';
import '../../widgets/menu/chat/chat_appbar.dart';
import '../../widgets/menu/chat/chat_body.dart';
import '../../widgets/menu/chat/chat_bottom.dart';

class PChatScreen extends StatelessWidget {
  const PChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              PChatAppBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(child: PChatBody()),
                      PChatBottom()
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
