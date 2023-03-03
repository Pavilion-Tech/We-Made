import 'package:flutter/material.dart';
import 'package:wee_made/modules/provider/menu/manage_product/edit_product_screen.dart';
import 'package:wee_made/widgets/default_button.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../../user/widgets/menu/delete_dialog.dart';

class PProductScreen extends StatefulWidget {
  PProductScreen(this.image);
  String image;

  @override
  State<PProductScreen> createState() => _PProductScreenState();
}

class _PProductScreenState extends State<PProductScreen> {
  List<int> list = [
    0,1,2,3,4,5,6,7,8,9
  ];
  List<Color> listColors = [
    Colors.red,
    Colors.black,
    Colors.indigo,
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.teal,
    Colors.purple,
    Colors.pink,
    Colors.amber,
  ];

  int currentIndex = 0;
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.asset(Images.curvesBackGround,height: double.infinity,width: double.infinity,fit: BoxFit.cover,),
          Container(
            height: size!.height*.7,
            width: double.infinity,
            decoration:const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(20),
                  topStart: Radius.circular(20),
                )
            ),
            child: Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          ),
          Column(
            children: [
              pDefaultAppBar(title: 'Product Name',context:context,backColor:Colors.white,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset(widget.image,height: 230,width: 250,color: color,)),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: list.map((e) => chooseColor(e,listColors[e])).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Text(
                              '15 AED',
                              style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            Text(
                              '4.5',
                              maxLines: 1,
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 25),
                            ),
                            const SizedBox(width: 5,),
                            Image.asset(Images.star,width: 21,),
                          ],
                        ),
                      ),
                      Text(
                        'Details',
                        style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60,right: 20,left: 20),
            child: Row(
              children: [
                Expanded(child: DefaultButton(
                    text: 'Edit Product',
                    onTap: ()=>navigateTo(context, EditProductScreen())
                )
                ),
                const SizedBox(width: 25,),
                Expanded(child: InkWell(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context)=>DeleteDialog((){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        })
                    );
                  },
                  child: Container(
                    height: 51,
                    width:double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: Colors.red
                    ),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Delete Product',
                      style:const TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w700),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chooseColor(int index,Color color){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
          this.color = color;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child:currentIndex == index
            ?CircleAvatar(
          radius: 15,
          backgroundColor: color,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 11,
              backgroundColor: color,
            ),
          ),
        )
            : CircleAvatar(
          radius: 10,
          backgroundColor: color,
        ),
      ),
    );
  }
}
