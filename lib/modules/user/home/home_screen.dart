import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
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
import '../widgets/shimmer/home_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool closeTop = false;
  bool closeCategory = false;
  ScrollController gridController = ScrollController();

  @override
  void initState() {
    gridController.addListener(() {
      setState(() {
        closeTop = gridController.offset>100;
        closeCategory = gridController.offset>150;
      });
    });
    super.initState();
  }

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
              fallback: (context)=>HomeShimmer(),
              builder: (context)=> Column(
                children: [
                  HomeAppBar(),
                  Expanded(
                    child: Column(
                      children: [
                        SearchWidget(readOnly: true),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: ConditionalBuilder(
                            condition: cubit.homeModel!.data!.categories!.isNotEmpty,
                              fallback: (context)=>Text(tr('no_categories')),
                              builder: (context)=> CategoryWidget(
                                  cubit.homeModel!.data!.categories!,
                                closeCategory: closeCategory,
                              )
                          ),
                        ),
                        ConditionalBuilder(
                          condition: cubit.homeModel!.data!.advertisements!.isNotEmpty,
                            fallback: (context)=>Text(tr('no_ads')),
                            builder: (context)=>ADSWidget(closeTop)
                        ),
                        const SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition: cubit.homeModel!.data!.products!.isNotEmpty,
                          fallback: (context)=>Text(tr('no_product')),
                          builder: (context)=> Expanded(
                            child: ProductGrid(
                              products: cubit.homeModel!.data!.products!,
                              gridController: gridController,
                              isScroll: false,
                            ),
                          )
                        ),
                        const SizedBox(height: 50,),
                      ],
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
