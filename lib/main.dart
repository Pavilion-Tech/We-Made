import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:wee_made/shared/bloc_observer.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/firebase_helper/firebase_options.dart';
import 'package:wee_made/shared/firebase_helper/notification_helper.dart';
import 'package:wee_made/shared/network/local/cache_helper.dart';
import 'package:wee_made/shared/network/remote/dio.dart';
import 'package:wee_made/shared/styles/colors.dart';
import 'package:wee_made/shared/uuid/uuid.dart';
import 'package:wee_made/splash_screen.dart';

import 'layouts/user_layout/user_cubit/user_cubit.dart';
import 'modules/provider/menu/pmenu_cubit/pmenu_cubit.dart';
import 'modules/user/menu_screens/menu_cubit/menu_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  try{
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );
    NotificationHelper();
    fcmToken = await  FirebaseMessaging.instance.getToken();
  }catch(e){
    print(e.toString());
  }
  await CacheHelper.init();
  DioHelper.init1();
  intro = CacheHelper.getData(key: 'intro');
  joinUs = CacheHelper.getData(key: 'joinUs');
  token = CacheHelper.getData(key: 'token');
  userId = CacheHelper.getData(key: 'userId');
  userType = CacheHelper.getData(key: 'userType');
  String? loca = CacheHelper.getData(key: 'locale');
  if(loca !=null){
    myLocale = loca;
  }else{
    Platform.localeName.contains('ar')
        ?myLocale = 'ar'
        :myLocale = 'en';
  }
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  version = packageInfo.version;
  uuid = await Uuid.getUuid();
 // print(userId);
  print(token);
  BlocOverrides.runZoned(
        () {
      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          useOnlyLangCode: true,
          path: 'assets/langs',
          fallbackLocale: const Locale('en'),
          startLocale: Locale(myLocale),
          child: const MyApp(),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:  (context) => AuthCubit(),),
        BlocProvider(create:  (context) => UserCubit()..checkInterNet()..getHome()..getCart(),),
        BlocProvider(create:  (context) => MenuCubit()..checkInterNet()..init()),
        BlocProvider(create:  (context) => PMenuCubit()..checkInterNet()..init(),),
        BlocProvider(create:  (context) => ProviderCubit()..checkInterNet()..getProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: defaultColor
          ),
          primarySwatch: Colors.blue,
          fontFamily: 'Cairo',
        ),
        home: SplashScreen(),
      ),
    );
  }
}
