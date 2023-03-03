import 'package:flutter/material.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../menu/pchat/pchat_screen.dart';

class PChatHistoryItem extends StatelessWidget {
  const PChatHistoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>navigateTo(context, PChatScreen()),
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
              'A',
              style: TextStyle(color: Colors.black,fontSize: 50,height: 1.5),
            ),
          ),
          const SizedBox(width: 25,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Essam',
                  style: TextStyle(color: Colors.black,fontSize: 18,fontWeight:FontWeight.w600),
                ),
                Text(
                  'Ahmed Essam:',
                  style: TextStyle(color:defaultColor,fontSize: 8,fontWeight:FontWeight.w500),
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla dapibus tristique lacus ut consectetur.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla dapibus tristique lacus ut consectetur.',
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
