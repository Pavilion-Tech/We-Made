import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../layouts/user_layout/user_cubit/user_cubit.dart';
import '../../layouts/user_layout/user_layout.dart';
import '../images/images.dart';
import '../styles/colors.dart';
import 'constants.dart';

Future<XFile?> checkImageSize (XFile? image)async{
  if(image!=null) {
    final bytes = (await image.readAsBytes()).lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    if(mb<5.0){
      return image;
    }else {
      showToast(msg: tr('image_size'));
      return null;
    }
  }
}

Future<void> openUrl(String url) async {
  print(url);
  if(await canLaunchUrl(Uri.parse(url))){
    await launchUrl(Uri.parse(url));
  }else{
    showToast(msg: 'This Url can\'t launch');
  }
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}




Future showToast ({required String msg , bool? toastState})
{
 return Fluttertoast.showToast(
   msg: msg,
   toastLength: Toast.LENGTH_LONG,
   gravity: ToastGravity.BOTTOM,
   timeInSecForIosWeb: 5,
   textColor: Colors.white,
   fontSize: 16.0,
   backgroundColor: toastState != null
       ? toastState ?Colors.yellow[900]
       : Colors.red : Colors.green,
 );
}



checkNet(context) {
  if (!isConnect!) {
   // navigateTo(context,const NoNetScreen(),);
  }
}

PreferredSizeWidget defaultAppBar({
  String? title,
  bool haveCart = true,
  bool haveArrow = true,
  bool isProduct = false,
  required BuildContext context,
  Color backColor = Colors.black
}){
  return AppBar(
    title:title!=null? Text(
      title,
      style: TextStyle(
          fontSize: 17,fontWeight: FontWeight.w700,color: isProduct?Colors.white:Colors.black,
      ),
    ):null,
    elevation: 0,
    leading:haveArrow? IconButton(
      onPressed: ()=>Navigator.pop(context),
      icon: Icon(Icons.arrow_back,color: backColor,),
    ):null,
    backgroundColor: Colors.transparent,
    centerTitle: false,
    actions: [
      if(haveCart)
      Padding(
        padding: const EdgeInsetsDirectional.only(end: 20),
        child: InkWell(
          onTap: (){
            UserCubit.get(context).changeIndex(1, context);
            navigateAndFinish(context, UserLayout());
          },
            child: Image.asset(Images.cartYes,width: 22,color: isProduct?Colors.white:defaultColor,)),
      )
    ],
  );
}

PreferredSizeWidget pDefaultAppBar({
  String? title,
  Widget? action,
  bool haveArrow = true,
  required BuildContext context,
  Color backColor = Colors.black
}){
  return AppBar(
    title:title!=null? Text(
      title,
      style: TextStyle(
        fontSize: 26,fontWeight: FontWeight.w700,color:backColor,
      ),
    ):null,
    elevation: 0,
    leading:haveArrow? IconButton(
      onPressed: ()=>Navigator.pop(context),
      icon: Icon(Icons.arrow_back,color: backColor,),
    ):null,
    backgroundColor: Colors.transparent,
    centerTitle: false,
    actions: [
      if(action!=null)
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 20),
          child:action,
        )
    ],
  );
}
