import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../widgets/product/product_grid.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              defaultAppBar(title: 'Hoodle',context: context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'See results about',
                        style: TextStyle(fontSize: 17,color: Colors.grey.shade600),
                      ),
                      Center(
                        child: Text(
                          'Hoodie',
                          style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),
                        ),
                      ),

                      Expanded(child: ProductGrid(padding: 0,))
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
