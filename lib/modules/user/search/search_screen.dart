import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../widgets/item_shared/filter.dart';
import '../widgets/product/product_grid.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Image.asset(Images.searchCurve,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              defaultAppBar(context: context,backColor: Colors.white,isProduct: true),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color: Colors.white)),
                          enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color: Colors.white)),
                          focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color: Colors.white)),
                          hintText: tr('search_by_product'),
                          hintStyle: TextStyle(color: Colors.white,fontSize: 15),
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
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size!.height*.05,),
              Expanded(child: ProductGrid())
            ],
          )

        ],
      ),
    );
  }
}
