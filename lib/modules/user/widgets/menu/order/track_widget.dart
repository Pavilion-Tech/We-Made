import 'package:flutter/material.dart';

import '../../../../../shared/styles/colors.dart';

class TrackWidget extends StatelessWidget {
  const TrackWidget({Key? key}) : super(key: key);

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
                      radius: 16,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.check,color: Colors.white,),
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.check,color: Colors.white,),
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey,
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
                  'New Order',
                  style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                ),
                Text(
                  'Processing',
                  style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w600),
                ),
                Text(
                  'Shipping',
                  style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w600),
                ),
                Text(
                  'Done',
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
