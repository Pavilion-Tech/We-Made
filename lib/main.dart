import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/shared/bloc_observer.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/network/local/cache_helper.dart';
import 'package:wee_made/shared/network/remote/dio.dart';
import 'package:wee_made/splash_screen.dart';

import 'layouts/user_layout/user_cubit/user_cubit.dart';
import 'modules/provider/menu/pmenu_cubit/pmenu_cubit.dart';
import 'modules/user/menu_screens/menu_cubit/menu_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await CacheHelper.init();
  DioHelper.init1();
  intro = CacheHelper.getData(key: 'intro');
  joinUs = CacheHelper.getData(key: 'joinUs');
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  version = packageInfo.version;
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
        BlocProvider(create:  (context) => UserCubit(),),
        BlocProvider(create:  (context) => MenuCubit(),),
        BlocProvider(create:  (context) => PMenuCubit(),),
        BlocProvider(create:  (context) => ProviderCubit(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Cairo',
        ),
        home: SplashScreen(),
      ),
    );
  }
}
