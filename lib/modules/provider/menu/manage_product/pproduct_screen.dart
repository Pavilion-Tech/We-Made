import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/modules/provider/menu/manage_product/edit_product_screen.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_cubit.dart';
import 'package:wee_made/widgets/default_button.dart';

import '../../../../models/user/home_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../widgets/image_net.dart';
import '../../../user/widgets/menu/delete_dialog.dart';

class PProductScreen extends StatefulWidget {
  PProductScreen(this.products);
  Products products;

  @override
  State<PProductScreen> createState() => _PProductScreenState();
}

class _PProductScreenState extends State<PProductScreen> {
  int currentIndex = 0;
  int quantity = 1;

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
              pDefaultAppBar(title:widget.products.title??'',context:context,backColor:Colors.white,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: ImageNet(image:widget.products.images!.isNotEmpty?widget.products.images![currentIndex]:'',height: 230,width: 250,)),
                      const SizedBox(height: 30,),
                      SizedBox(
                        height: 20,
                        child: ListView.separated(
                          itemBuilder: (c,i)=>chooseColor(i,widget.products.images![i]),
                          separatorBuilder: (c,i)=>const SizedBox(width: 15,),
                          itemCount: widget.products.images!.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Text(
                              '${widget.products.priceAfterDicount} AED',
                              style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            Text(
                              '${widget.products.totalRate}',
                              maxLines: 1,
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 25),
                            ),
                            const SizedBox(width: 5,),
                            Image.asset(Images.star,width: 21,),
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
                            widget.products.description??'',
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
                    text: tr('edit_product'),
                    onTap: ()=>navigateTo(context, EditProductScreen(widget.products))
                )
                ),
                const SizedBox(width: 25,),
                Expanded(child: InkWell(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context)=>DeleteDialog((){
                          PMenuCubit.get(context).deleteProduct(widget.products!.id??'',context);
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
                      tr('delete_product'),
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

  Widget chooseColor(int index,String image){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
        });
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child:CircleAvatar(
            radius: currentIndex == index?15:10,
            backgroundColor: Colors.red,
            child: ImageNet(image: image,),
          )
      ),
    );
  }}
