import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';
import '../../../widgets/default_button.dart';
import '../store/store_screen.dart';
import '../widgets/cart/cart_dialog.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen(this.image);
  String image;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
              defaultAppBar(isProduct: true,title: 'Product Name',context:context,backColor:Colors.white),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding:const EdgeInsetsDirectional.only(end:5),
                  child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.favorite,color: Colors.white,)
                  ),
                ),
              ),
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
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '4.5',
                            maxLines: 1,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 25),
                          ),
                          const SizedBox(width: 5,),
                          Image.asset(Images.star,width: 21,),
                          const Spacer(),
                          DefaultButton(
                              text: tr('add_to_cart'),
                              width: size!.width*.4,
                              height: 43,
                              onTap: (){
                                showDialog(context: context, builder: (context)=>CartDialog());
                              }
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 40),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 61,
                                padding: EdgeInsetsDirectional.only(start: 20),
                                alignment: AlignmentDirectional.centerStart,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadiusDirectional.circular(10)
                                ),
                                child: Text(
                                    'Store Name',
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(width: 30,),
                            TextButton(
                                onPressed: (){
                                  navigateTo(context, StoreScreen());
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      tr('visit'),
                                      style: TextStyle(color: defaultColor,fontWeight: FontWeight.w600,fontSize: 17),
                                    ),
                                    const SizedBox(width: 3,),
                                    Icon(Icons.arrow_forward,color: defaultColor,size: 10,)
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                      Text(
                        tr('details'),
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
              )
            ],
          )
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
