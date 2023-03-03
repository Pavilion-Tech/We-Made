import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../widgets/cart/checkout/checkout_list_products.dart';
import '../../widgets/cart/checkout/invoice.dart';
import '../../widgets/menu/order/order_appbar.dart';
import '../../widgets/menu/order/track_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool showTrack = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:orderAppbar(context),
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(showTrack)
                  TrackWidget(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Text(
                          'Family name (4 items)',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),
                        ),
                        const Spacer(),
                        if(!showTrack)
                        InkWell(
                          onTap: (){
                            setState(() {
                              showTrack = true;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                tr('track'),
                                style: TextStyle(color:defaultColor,fontWeight: FontWeight.w600,fontSize: 17),
                              ),
                              const SizedBox(width: 3,),
                              Icon(Icons.arrow_forward,color: defaultColor,size: 10,),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  CheckoutListProducts(),
                  Invoice()
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
