import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wee_made/modules/user/menu_screens/menu_cubit/menu_cubit.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../widgets/default_button.dart';
import '../../../../../widgets/default_form.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  Future<void> getAddress({LatLng? latLng}) async {
    if (latLng != null) {
      List<Placemark> place = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: 'ar');
      Placemark placeMark = place[0];
      locationController.text = placeMark.street!;
      locationController.text += ', ${placeMark.country!}';
      setState(() { });
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(cubit.position!.latitude,cubit.position!.longitude),
                zoom: 14
              ),
            onTap: (LatLng latlng)async=> await getAddress(latLng: latlng),
          ),
          Column(
            children: [
              defaultAppBar(context: context,haveCart: false),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 71,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(15)
                  ),
                  padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Row(
                    children: [
                      Image.asset(Images.address,width: 15,),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              titleController.text.isNotEmpty?titleController.text:tr('address_details'),
                              style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                locationController.text.isNotEmpty?locationController.text:tr('address_title'),
                                maxLines: 1,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                decoration:const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(20),
                    topStart: Radius.circular(20),
                  ),
                  color: Colors.white
                ),
                padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('address_details'),
                      style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20,),
                    DefaultForm(
                      controller: titleController,
                        hint: tr('address_title'),
                      onChanged: (val){
                        setState(() {});
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: DefaultForm(
                        hint: tr('location'),
                        readOnly: true,
                        controller: locationController,
                        prefix: Image.asset(Images.search,width: 12,),),
                    ),
                    DefaultButton(text: tr('save'), onTap: ()=>Navigator.pop(context))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
