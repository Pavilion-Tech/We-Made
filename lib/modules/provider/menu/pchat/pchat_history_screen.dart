import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../widgets/menu/chat/chat_history_item.dart';

class PChatHistoryScreen extends StatelessWidget {
  const PChatHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              pDefaultAppBar(
                  context: context,title: 'Chat History',
                  action: Image.asset(Images.send,width: 20,color: defaultColor,)
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (c,i)=>PChatHistoryItem(),
                    padding:const EdgeInsetsDirectional.all(20),
                    separatorBuilder: (c,i)=>Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 2),
                      child: Container(
                        color: Colors.grey.shade400,
                        height: 1,
                        width: double.infinity,
                      ),
                    ),
                    itemCount: 3
                ),
              )
            ],
          )
        ],
      ),
    );  }
}
