import 'package:flutter/material.dart';
import 'package:wee_made/models/chathis_model.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../menu_screens/chat/chat_screen.dart';
import '../../../menu_screens/menu_cubit/menu_cubit.dart';

class ChatHistoryItem extends StatelessWidget {
  ChatHistoryItem(this.data);
  ChatHisData data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        MenuCubit.get(context).singleChat(data.id??'');
        navigateTo(context, ChatScreen(data.id??''));
      },
      child: Row(
        children: [
          Container(
            height: 72,width: 72,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade400
            ),
            child: Text(
              '${data.providerName!.characters.first}',
              style: TextStyle(color: Colors.black,fontSize: 50,height: 1.5),
            ),
          ),
          const SizedBox(width: 25,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.providerName??'',
                  style: TextStyle(color: Colors.black,fontSize: 18,fontWeight:FontWeight.w600),
                ),
                Text(
                  data.lastMessage!.sender == 'user'?'You:':'${data.providerName??''}:',
                  style: TextStyle(color:defaultColor,fontSize: 8,fontWeight:FontWeight.w500),
                ),
                Text(
                  data.lastMessage!.messageType == 1
                      ?data.lastMessage!.message??''
                      :data.lastMessage!.messageType == 2
                      ? 'Sent Image'
                      : '',
                  maxLines: 3,
                  style: TextStyle(fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
