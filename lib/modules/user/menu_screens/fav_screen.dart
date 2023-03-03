import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../widgets/product/product_grid.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              defaultAppBar(context: context,title: tr('favorites')),
              Expanded(child: ProductGrid(isScroll: false,))
            ],
          )
        ],
      ),
    );
  }
}
