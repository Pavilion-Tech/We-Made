import 'package:flutter/material.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/shared/styles/colors.dart';
import 'package:wee_made/widgets/default_button.dart';
import 'package:wee_made/widgets/default_form.dart';

import '../../user/widgets/menu/delete_dialog.dart';

class AddEditProductScreen extends StatelessWidget {
  AddEditProductScreen({this.isEdit = false});
  bool isEdit;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
        Column(
          children: [
            pDefaultAppBar(
              context: context,title:isEdit?'Edit Product': 'Add Product',haveArrow: isEdit,
              action: Image.asset(Images.manageProducts,width: 20,)
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      DefaultForm(hint: 'Product Name'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: DefaultForm(hint: 'Describe Your Product / Price / Quantity / Size / Gender / Type ....  name',maxLines: 3),
                      ),
                      Row(
                        children: [
                          Expanded(child: DefaultForm(hint: 'Quantity')),
                          const SizedBox(width: 40,),
                          Expanded(child: DefaultForm(hint: 'Quantity')),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Row(
                          children: [
                            Expanded(child: DefaultForm(hint: 'Quantity')),
                            const SizedBox(width: 40,),
                            Expanded(child: DefaultForm(hint: 'Quantity')),
                          ],
                        ),
                      ),
                      Container(
                        height: 43,width: 143,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(10),
                          border: Border.all(color: Colors.black)
                        ),
                        alignment: AlignmentDirectional.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Images.camera2 ,color: defaultColor,width: 20,),
                            const SizedBox(width: 10,),
                            Text(
                              'Upload Image',
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50,),
                      DefaultButton(text: isEdit?'Edit Product': 'Add Product', onTap: (){}),
                      if(isEdit)
                        TextButton(
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (context)=>DeleteDialog((){
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  })
                              );
                            },
                            child: Text(
                              'Delete Product',
                              style: TextStyle(color: Colors.red),
                            )
                        ),
                      const SizedBox(height: 80,)
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
