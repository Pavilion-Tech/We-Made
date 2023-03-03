import 'package:flutter/material.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';

class NoLocations extends StatelessWidget {
  const NoLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.noLocation,width: size!.width*.5,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20),
                child: Text(
                  'No locations yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 21),
                ),
              ),
              Text(
                'You can add new locations now',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
              ),
              DefaultButton(text: 'Add Locations', onTap: (){})
            ],
          ),
        ),
      ],
    );
  }
}
