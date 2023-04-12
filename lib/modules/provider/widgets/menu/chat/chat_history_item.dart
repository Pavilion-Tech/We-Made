import 'package:flutter/material.dart';

import '../../../../../models/chathis_model.dart';
import '../../../../../shared/components/components.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../menu/pchat/pchat_screen.dart';
import '../../../menu/pmenu_cubit/pmenu_cubit.dart';

class PChatHistoryItem extends StatelessWidget {
  PChatHistoryItem(this.data);
  ChatHisData data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        PMenuCubit.get(context).singleChat(data.id??'');
        navigateTo(context, PChatScreen(data.id??''));
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
                  data.userName??'',
                  style: TextStyle(color: Colors.black,fontSize: 18,fontWeight:FontWeight.w600),
                ),
                Text(
                  data.lastMessage!.sender != 'user'?'You:':'${data.userName??''}:',
                  style: TextStyle(color:defaultColor,fontSize: 8,fontWeight:FontWeight.w500),
                ),
                Text(
                  data.lastMessage!.messageType == 1
                      ?data.lastMessage!.message??''
                      :data.lastMessage!.messageType == 2
                      ? 'Sent Image'
                      : 'Sent Voice',
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
