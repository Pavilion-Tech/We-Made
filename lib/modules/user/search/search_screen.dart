import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import 'package:wee_made/widgets/no_items/no_product.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';
import '../widgets/home/search/provider_search.dart';
import '../widgets/item_shared/filter.dart';
import '../widgets/product/product_grid.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = UserCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Image.asset(Images.curveHome,width: double.infinity,fit: BoxFit.cover,),
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
                        onChanged: (val){
                          if(val.isNotEmpty){
                            cubit.getSearch();
                          }else{
                            cubit.searchModel = null;
                            cubit.providerItemModel = null;
                            cubit.emitState();
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        controller: cubit.searchC,
                        decoration: InputDecoration(
                          border:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color: Colors.white)),
                          enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color: Colors.white)),
                          focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color: Colors.white)),
                          hintText: tr('search_by_product'),
                          hintStyle: TextStyle(color: Colors.white,fontSize: 15),
                          suffix: IconButton(
                            onPressed: (){
                              cubit.searchC.text = '';
                              cubit.emitState();
                            },
                            icon: Icon(Icons.highlight_remove,color: Colors.white,),
                          ),
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
                      onTap: ()async{
                        await cubit.getCurrentLocation();
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
              ConditionalBuilder(
                  condition: cubit.searchModel!=null,
                  fallback: (context)=>const SizedBox(),
                  builder: (context)=> ConditionalBuilder(
                    condition: state is! GetSearchLoadingState,
                    fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                    builder: (context)=> ConditionalBuilder(
                      condition: cubit.searchModel!.data!.isNotEmpty,
                        fallback: (context)=>NoProduct(),
                        builder: (context)=> Expanded(child: ProductGrid(products: cubit.searchModel!.data!,))
                    ),
                  )
              ),
              ConditionalBuilder(
                  condition: cubit.providerItemModel!=null,
                  fallback: (context)=>const SizedBox(),
                  builder: (context)=> ConditionalBuilder(
                    condition: state is! GetSearchLoadingState,
                    fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                    builder: (context)=> ConditionalBuilder(
                        condition: cubit.providerItemModel!.data!.isNotEmpty,
                        fallback: (context)=>NoProduct(),
                        builder: (context)=> Expanded(child: ProviderSearch(cubit.providerItemModel!.data!,))
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  },
);
  }
}