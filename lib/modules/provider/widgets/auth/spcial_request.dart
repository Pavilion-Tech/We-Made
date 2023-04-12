import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/styles/colors.dart';

class SpecialRequest extends StatefulWidget {
  SpecialRequest({this.currentIndex =2});

  int currentIndex;

  @override
  State<SpecialRequest> createState() => _SpecialRequestState();
}

class _SpecialRequestState extends State<SpecialRequest> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          border: Border.all(color: Colors.grey.shade500)
      ),
      alignment: AlignmentDirectional.center,
      padding:const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            tr('special_request'),
            style: TextStyle(color: Colors.grey.shade400),
          ),
          const Spacer(),
          itemBuilder(1,tr('yes')),
          const SizedBox(width: 10,),
          itemBuilder(2,tr('no'))

        ],
      ),
    );
  }

  Widget itemBuilder(int index,String text){
    return InkWell(
      onTap: (){
        setState(() {
          widget.currentIndex = index;
        });
      },
      child:Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.grey.shade300,
            child: widget.currentIndex == index?CircleAvatar(
              radius: 5,
              backgroundColor: defaultColor,
            ):null,
          ),
          const SizedBox(width: 5,),
          Text(text),
        ],
      ),
    );
  }
}