import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas/modules/for_student/setting_screen.dart';
import 'package:saas/modules/splash_screen.dart';
import 'package:saas/shared/bloc/cubit.dart';
import 'package:saas/shared/bloc/states.dart';
import 'package:saas/shared/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';




void main() {
  //Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //final bool lightMode;
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state){},
        builder: (BuildContext context,AppStates state){
          AppCubit cubit = AppCubit.get(context);
          return MaterialApp(
            themeMode: cubit.isLightTheme? ThemeMode.light:ThemeMode.dark,
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: const SettingScreen(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              cubit.isArabic()? const Locale('ar', 'AE') : const Locale('en', ''),
            ],
          );
        },
      ),
    );/*MaterialApp(
      home: const Splash(),
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        isArabic ? const Locale('ar', 'AE') : const Locale('en', ''),
      ],
    );*/
  }
}
