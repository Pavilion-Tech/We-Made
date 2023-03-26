import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/styles/colors.dart';

class TrackWidget extends StatelessWidget {
  TrackWidget(this.status);

  int status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                color: Colors.black,
                height: 1,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: defaultColor,
                      child: Icon(Icons.check,color: Colors.white,),
                    ),
                    CircleAvatar(
                      radius: status == 2 ||status == 3 || status == 4 ? 20:16,
                      backgroundColor:status == 2 ||status == 3 || status == 4 ?defaultColor : Colors.grey,
                      child: Icon(Icons.check,color: Colors.white,),
                    ),
                    CircleAvatar(
                      radius: status == 3 || status == 4 ? 20:16,
                      backgroundColor:status == 3 || status == 4 ?defaultColor : Colors.grey,
                      child: Icon(Icons.check,color: Colors.white,),
                    ),
                    CircleAvatar(
                      radius:  status == 4 ? 20:16,
                      backgroundColor: status == 4 ?defaultColor : Colors.grey,
                      child: Icon(Icons.check,color: Colors.white,),
                    )
                  ],
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr('new_order'),
                  style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                ),
                Text(
                tr('processing'),
                  style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w600),
                ),
                Text(
                  tr('shipping'),
                  style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w600),
                ),
                Text(
                  tr('done2'),
                  style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
