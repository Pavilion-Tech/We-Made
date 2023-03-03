import 'package:flutter/material.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';

class ADSWidget extends StatelessWidget {
  const ADSWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      child: ListView.separated(
          itemBuilder: (c,i)=>ADSItem(listImages[i]),
          separatorBuilder: (c,i)=>const SizedBox(width: 20,),
          padding:const EdgeInsetsDirectional.only(start: 20),
          scrollDirection: Axis.horizontal,
          itemCount: listImages.length
      ),
    );
  }
}

class ADSItem extends StatelessWidget {
  ADSItem(this.image);
  String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,width: size!.width*.85,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: defaultColor),
          borderRadius: BorderRadiusDirectional.circular(20),
      ),
      padding:const EdgeInsets.symmetric(horizontal: 36,vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Offer',
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontSize: 32,fontWeight: FontWeight.w500),
                ),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and.',
                  maxLines: 2,
                  style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,height: 1),
                ),
                const SizedBox(height: 10,),
                Container(
                  height: 28,width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(23),
                    border: Border.all(color: defaultColor)
                  ),
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Get Now',
                    style: TextStyle(color: defaultColor,fontSize: 12,fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(image)
        ],
      ),
    );
  }
}

