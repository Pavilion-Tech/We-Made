
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/widgets/default_button.dart';

import '../../../../shared/styles/colors.dart';

class DeleteDialog extends StatelessWidget {

  DeleteDialog(this.deleteTap);

  VoidCallback deleteTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(20)),
      child: Padding(
        padding:const EdgeInsets.symmetric(vertical: 40,horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete,size: 82,color: Colors.red,),
            const SizedBox(height: 25,),
            Text(
              tr('delete_sure'),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: DefaultButton(
                  text: tr('delete'),
                  onTap: deleteTap
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                height: 51,
                width:double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    border: Border.all(color: defaultColor),
                    color: Colors.white
                ),
                alignment: AlignmentDirectional.center,
                child: Text(
                  tr('discard'),
                  style:TextStyle(color:defaultColor,fontSize: 17,fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
