import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/styles/colors.dart';

class PaymentMethod extends StatefulWidget {
  PaymentMethod({Key? key}) : super(key: key);

  int currentIndex = 0;


  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('payment_method'),
            style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: itemBuilder(
              title: tr('cash'),
              index: 0
            ),
          ),
          itemBuilder(
            title: tr('credit_card'),
            index: 1
          )
        ],
      ),
    );
  }

  Widget itemBuilder({
  required String title,
  required int index,
}){
    return InkWell(
      onTap: (){
        setState(() {
          widget.currentIndex = index;
        });
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: defaultColor,
            child: CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
              child:widget.currentIndex==index? CircleAvatar(
                radius: 7,
                backgroundColor: defaultColor,
              ):null,
            ),
          ),
          const SizedBox(width: 10,),
          Text(
            title
          ),
        ],
      ),
    );
  }
}
