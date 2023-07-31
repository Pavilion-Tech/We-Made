import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../layouts/user_layout/user_cubit/user_cubit.dart';
import '../../layouts/user_layout/user_layout.dart';
import '../../widgets/wrong_screens/no_net_screen.dart';
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
    PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.fastOutSlowIn;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.fastOutSlowIn;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }
    ),
        (route) => false,
  );
}




Future showToast ({required String msg , bool? toastState,ToastGravity gravity = ToastGravity.BOTTOM})
{
 return Fluttertoast.showToast(
   msg: msg,
   toastLength: Toast.LENGTH_LONG,
   gravity: gravity,
   timeInSecForIosWeb: 5,
   textColor: Colors.white,
   fontSize: 16.0,
   backgroundColor: toastState != null
       ? toastState ?Colors.yellow[900]
       : Colors.red : Colors.green,
 );
}



checkNet(context,{bool isUser = true}) {
  if (!isConnect!) {
    navigateTo(context,NoNetScreen(isUser: isUser),);
  }
}

PreferredSizeWidget defaultAppBar({
  String? title,
  bool haveCart = true,
  bool haveArrow = true,
  bool isProduct = false,
  bool isMenu = false,
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
      onPressed: (){
        Navigator.pop(context);
        if(isMenu)Navigator.pop(context);
      },
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
  bool isMenu = false,
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
      onPressed: (){
        Navigator.pop(context);
        if(isMenu)Navigator.pop(context);
      },
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
