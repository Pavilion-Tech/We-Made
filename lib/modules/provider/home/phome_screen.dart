import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_states.dart';
import 'package:wee_made/modules/user/widgets/shimmer/home_shimmer.dart';

import '../../../shared/images/images.dart';
import '../widgets/home/app_bar.dart';
import '../widgets/home/charts.dart';
import '../widgets/home/filter_statisrtics.dart';
import '../widgets/home/provider_info.dart';

class PHomeScreen extends StatelessWidget {
  const PHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Stack(
      children: [
        Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
        ConditionalBuilder(
          condition: ProviderCubit.get(context).providerModel!=null,
          fallback: (context)=>HomeShimmer(),
          builder: (context)=> Column(
            children: [
              PHomeAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        ProviderInfo(),
                        FilterStatistics(),
                        if(ProviderCubit.get(context).statisticsModel!=null)
                        ConditionalBuilder(
                          condition: state is! StatisticsLoadingState,
                          fallback: (context)=>CupertinoActivityIndicator(),
                          builder: (context)=> ConditionalBuilder(
                            condition: ProviderCubit.get(context).statisticsModel!.data!.isNotEmpty,
                              fallback: (context)=>Text(
                                tr('no_statistics')
                              ),
                              builder: (context)=> Charts()
                          ),
                        ),
                        const SizedBox(height: 100,)
                      ],
                    ),
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
