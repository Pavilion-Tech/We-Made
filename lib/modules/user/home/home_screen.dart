import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import '../../../shared/images/images.dart';
import '../widgets/category/category_widget.dart';
import '../widgets/home/ads.dart';
import '../widgets/home/app_bar.dart';
import '../widgets/home/search/search_widget.dart';
import '../widgets/product/product_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Stack(
          children: [
            Image.asset(
              Images.backGround, width: double.infinity, fit: BoxFit.cover,),
            ConditionalBuilder(
              condition: cubit.homeModel!=null,
              fallback: (context)=>const Center(child: CircularProgressIndicator(),),
              builder: (context)=> Column(
                children: [
                  HomeAppBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SearchWidget(readOnly: true),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: ConditionalBuilder(
                              condition: cubit.homeModel!.data!.categories!.isNotEmpty,
                                fallback: (context)=>Text('No Categories Yet'),
                                builder: (context)=> CategoryWidget(
                                    cubit.homeModel!.data!.categories!
                                )
                            ),
                          ),
                          ConditionalBuilder(
                            condition: cubit.homeModel!.data!.advertisements!.isNotEmpty,
                              fallback: (context)=>Text('No Ads Yet'),
                              builder: (context)=>ADSWidget()
                          ),
                          const SizedBox(height: 30,),
                          ConditionalBuilder(
                            condition: cubit.homeModel!.data!.products!.isNotEmpty,
                            fallback: (context)=>Text('No Products Yet'),
                            builder: (context)=> ProductGrid(products: cubit.homeModel!.data!.products!,)
                          ),
                          const SizedBox(height: 50,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
