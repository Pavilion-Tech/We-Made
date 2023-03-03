import 'package:flutter/material.dart';

import '../../../shared/images/images.dart';
import '../widgets/home/app_bar.dart';
import '../widgets/home/charts.dart';
import '../widgets/home/filter_statisrtics.dart';
import '../widgets/home/provider_info.dart';

class PHomeScreen extends StatelessWidget {
  const PHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
        Column(
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
                      Charts(),
                      const SizedBox(height: 100,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
