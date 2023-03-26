import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/components/components.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../search/search_screen.dart';

class SearchWidget extends StatelessWidget {
    SearchWidget({
    this.readOnly =false,
    this.padding = 20
});

  bool readOnly;
  double padding;
  @override
  Widget build(BuildContext context) {
    print(readOnly);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:padding),
      child: InkWell(
        onTap: readOnly?(){
          navigateTo(context, SearchScreen());
        }:null,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsetsDirectional.only(start: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(43),
                  border: Border.all(color: defaultColor),
                  color: Colors.transparent
                ),
                child: Text(
                  tr('search_by_product'),
                  style: TextStyle(color: Colors.grey.shade500,fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              Images.filter,
              width: 30,
            )
          ],
        ),
      ),
    );
  }
}
