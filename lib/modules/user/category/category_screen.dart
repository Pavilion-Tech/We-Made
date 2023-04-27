import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import 'package:wee_made/modules/user/widgets/shimmer/product_shimmer.dart';
import 'package:wee_made/widgets/no_items/no_product.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../widgets/product/product_grid.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen(this.title);
  String title;
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
                  defaultAppBar(title: title, context: context),
                  ConditionalBuilder(
                    condition:cubit.categoryModel!=null,
                    fallback: (context)=> ProductShimmer(),
                    builder: (context)=> Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr('see_result'),
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey.shade600),
                            ),
                            Center(
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                            ),
                            ConditionalBuilder(
                              condition: cubit.categoryModel!.data!.isNotEmpty,
                                fallback: (context)=>NoProduct(),
                                builder: (context)=> Expanded(child: ProductGrid(padding: 0,products: cubit.categoryModel!.data!,isScroll: false,)))
                          ],
                        ),
                      ),
                    ),
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
