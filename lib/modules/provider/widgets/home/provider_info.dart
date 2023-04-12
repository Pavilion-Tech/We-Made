import 'package:flutter/material.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/shared/images/images.dart';

import '../../../../widgets/image_net.dart';

class ProviderInfo extends StatelessWidget {
  const ProviderInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,width: 170,
          decoration: BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: ImageNet(image: ProviderCubit.get(context).providerModel!.data!.personalPhoto??''),
        ),
        Text(
          ProviderCubit.get(context).providerModel!.data!.storeName??'',
          style: TextStyle(color: Colors.black,fontSize: 34,fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 30,),
      ],
    );
  }
}
