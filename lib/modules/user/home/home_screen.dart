import 'package:flutter/material.dart';
import '../../../shared/images/images.dart';
import '../widgets/category/category_widget.dart';
import '../widgets/home/ads.dart';
import '../widgets/home/app_bar.dart';
import '../widgets/home/search_widget.dart';
import '../widgets/product/product_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
        Column(
          children: [
            HomeAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SearchWidget(readOnly: true),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: CategoryWidget(),
                    ),
                    ADSWidget(),
                    const SizedBox(height: 30,),
                    ProductGrid(),
                    const SizedBox(height:50,),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
