import 'package:flutter/material.dart';
import 'package:wee_made/widgets/default_button.dart';

import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';

class PContactUsScreen extends StatelessWidget {
  PContactUsScreen({Key? key}) : super(key: key);

  List<String> images = [
    Images.gmail2,
    Images.whats2,
    Images.face2,
    Images.twitter2,
    Images.insta2,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          Image.asset(Images.contactBack,width: double.infinity,fit: BoxFit.cover,),
          Column(
            children: [
              pDefaultAppBar(context: context,title: 'Contact Us',),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemBuilder(
                                image: images[0],
                                onTap:(){}
                            ),
                            itemBuilder(
                                image: images[1],
                                onTap:(){}
                            ),
                            itemBuilder(
                                image: images[2],
                                onTap:(){}
                            ),
                            itemBuilder(
                                image: images[3],
                                onTap:(){}
                            ),
                            itemBuilder(
                                image: images[4],
                                onTap:(){}
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.only(start: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadiusDirectional.circular(10),
                              border: Border.all(color: Colors.grey)
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: 'Subject'
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsetsDirectional.only(start: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadiusDirectional.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: TextFormField(
                            maxLines: 5,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintText: 'Your message to us'
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        DefaultButton(text: 'Send Message', onTap: (){})
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
  }

  Widget itemBuilder({
  required String image,
  required VoidCallback onTap
}){
    return InkWell(
      onTap: onTap,
        child: Image.asset(image,width: 20,height: 20,));
  }
}
