import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../splash_screen.dart';
import '../menu/delete_dialog.dart';

class CartItem extends StatelessWidget {
  CartItem(this.image);
  String image;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 205,width: 177,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20),
            color: defaultColor.withOpacity(.3)
          ),
          alignment: AlignmentDirectional.center,
          child: Image.asset(image),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 15,top: 15,end: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name Name',
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w700),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '15 AED',
                      style: TextStyle(color: defaultColor,fontSize: 25,fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context)=>DeleteDialog((){
                              Navigator.pop(context);
                            })
                        );
                      },
                        child: Image.asset(Images.delete,width: 21,))
                  ],
                ),
                Text(
                  'X2',
                  maxLines: 1,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      '4.5',
                      maxLines: 1,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                    ),
                    Icon(Icons.star,color: defaultColor,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: (){},
                        child: Text(
                            '-',
                          style: TextStyle(color: defaultColor,fontSize: 25),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        height: 34,width: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: defaultColor
                        ),
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          '1',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20,height: 1.7),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (){},
                        child: Text(
                            '+',
                          style: TextStyle(color: defaultColor,fontSize: 25),
                        )
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
