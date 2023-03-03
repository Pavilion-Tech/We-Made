import 'package:flutter/material.dart';

import '../shared/styles/colors.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    required this.text,
    required this.onTap,
    this.width = double.infinity,
    this.height = 51,
});

  double width;
  double height;
  String text;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width:width,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          color: defaultColor
        ),
        alignment: AlignmentDirectional.center,
        child: Text(
            text,
          style:const TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
