import 'package:flutter/material.dart';
import 'package:wee_made/shared/images/images.dart';

class ProviderInfo extends StatelessWidget {
  const ProviderInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,width: 170,
          decoration: BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(Images.story,fit: BoxFit.cover,),
        ),
        Text(
          'Family Name',
          style: TextStyle(color: Colors.black,fontSize: 34,fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 30,),
      ],
    );
  }
}
