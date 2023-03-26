import 'package:flutter/material.dart';
import 'package:wee_made/widgets/default_button.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../user/widgets/cart/checkout/checkout_list_products.dart';
import '../../user/widgets/cart/checkout/invoice.dart';
import '../../user/widgets/menu/order/order_appbar.dart';
import '../../user/widgets/menu/order/track_widget.dart';

class POrderDetailsScreen extends StatefulWidget {
  const POrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<POrderDetailsScreen> createState() => _POrderDetailsScreenState();
}

class _POrderDetailsScreenState extends State<POrderDetailsScreen> {
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        itemBuilder(Images.person2,'User Name'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: itemBuilder(Images.phone,'0211515454'),
                        ),
                        itemBuilder(Images.address,'26985 Brighton Lane, Lake Forest, CA 92630.'),
                      ],
                    ),
                  ),
                  if(showTrack)
                  //TrackWidget(),
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
                                'Track',
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
                  //Invoice(),
                  const SizedBox(height: 100,),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60,right: 20,left: 20),
              child: DefaultButton(
                  text: 'In Progress',
                  onTap: (){}
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget itemBuilder(String image,String title){
    return Row(
      children: [
        Image.asset(image,width: 20,color: defaultColor,),
        const SizedBox(width: 15,),
        Expanded(
          child: Text(
            title,
            maxLines: 2,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
