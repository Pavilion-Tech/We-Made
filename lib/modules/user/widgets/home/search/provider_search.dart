import 'package:flutter/material.dart';
import 'package:wee_made/modules/user/store/store_screen.dart';
import 'package:wee_made/shared/components/components.dart';

import '../../../../../models/user/provider_item_model.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../widgets/image_net.dart';

class ProviderSearch extends StatelessWidget {
  ProviderSearch(this.providers);
  List<ProviderData> providers;
  @override
  Widget build(BuildContext context) {
    double currentSize = size!.height> 800 ?size!.width / (size!.height / 1.73):size!.width / (size!.height / 1.45);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:20),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsetsDirectional.only(bottom: 100),
        itemBuilder: (c,i)=>ProviderItem(providers[i]),
        itemCount: providers.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 30,mainAxisSpacing: 30,
          childAspectRatio: currentSize,
        ),
      ),
    );  }
}

class ProviderItem extends StatelessWidget {

  ProviderItem(this.provider);
  ProviderData provider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo(context, StoreScreen());
      },
      child: Container(
        height: 205,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20),
            color: defaultColor.withOpacity(.3)
        ),
        padding:const EdgeInsets.symmetric(horizontal: 15),
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageNet(image:provider.personalPhoto??'',width: 124,height: 124,),
            Text(
              provider.storeName??'',
              maxLines: 1,
              style:const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

