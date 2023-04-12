import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import 'package:wee_made/modules/user/widgets/shimmer/product_shimmer.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../../widgets/no_items/no_product.dart';
import '../widgets/product/product_grid.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                Images.backGround, width: double.infinity, fit: BoxFit.cover,),
              Column(
                children: [
                  defaultAppBar(
                      context: context, title: tr('favorites'), isMenu: true),
                  ConditionalBuilder(
                    condition: cubit.favModel!=null&&state is! GetFavLoadingState,
                    fallback: (context)=>ProductShimmer(),
                    builder: (context)=> ConditionalBuilder(
                        condition: cubit.favModel!.data!.data!.isNotEmpty,
                        fallback: (context)=>NoProduct(),
                        builder: (context){
                          Future.delayed(Duration.zero,(){
                            cubit.paginationFav();
                          });
                          return Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                      itemBuilder: (c,i)=>ProductGrid(
                                        isScroll: false,
                                        products: cubit.favModel!.data!.data!,padding: 0,
                                        isFav: true,
                                      ),
                                      padding:const EdgeInsetsDirectional.all(20),
                                      controller: cubit.favScrollController,
                                      physics:BouncingScrollPhysics(),
                                      separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                                      itemCount:cubit.favModel!.data!.data!.length
                                  ),
                                ),
                                if(state is GetFavLoadingState)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 30.0),
                                    child: CupertinoActivityIndicator(),
                                  ),
                              ],
                            ),
                          );
                        }
                    ),
                  )

                ],
              )
            ],
          ),
        );
      },
    );
  }
}
