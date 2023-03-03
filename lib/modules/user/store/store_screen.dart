import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';
import '../../../widgets/stories/list_stories.dart';
import '../widgets/category/category_widget.dart';
import '../widgets/home/search_widget.dart';
import '../widgets/item_shared/filter.dart';
import '../widgets/product/product_grid.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {


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
              defaultAppBar(isProduct: true,title: 'Family Name',backColor:Colors.white,context: context),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset(Images.story,height: 230,width: 250,)),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child:  ListStories(padding:0,color:Colors.black),
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey.shade300,
                                    child: Image.asset(Images.whats2,color: defaultColor,width: 25,),
                                  ),
                                  const SizedBox(width: 20,),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: defaultColor,
                                    child: Icon(Icons.phone,color: Colors.white,size: 25,),
                                  ),
                                  const Spacer(),
                                  Text(
                                    tr('special_request'),
                                    style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child:Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          border:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color:defaultColor)),
                                          enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color:defaultColor)),
                                          focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color:defaultColor)),
                                          hintText: tr('search_by_product'),
                                          hintStyle: TextStyle(color: defaultColor,fontSize: 15),
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child:  Image.asset(Images.search,width: 1,height: 1,),
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (context)=>FilterWidget()
                                        );
                                      },
                                      child: Image.asset(
                                        Images.filter,
                                        width: 30,
                                        color: defaultColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              CategoryWidget(padding: 0),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: Center(
                                  child: Text(
                                    'Dress',
                                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30),
                                  ),
                                ),
                              ),
                              ProductGrid(padding: 0),
                            ],
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
}
