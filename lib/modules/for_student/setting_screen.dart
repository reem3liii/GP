import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas/modules/setting_screens/password.dart';
import 'package:saas/modules/setting_screens/phone.dart';
import 'package:saas/shared/bloc/cubit.dart';
import 'package:saas/shared/bloc/states.dart';
import 'package:saas/shared/components.dart';
import 'package:saas/shared/colors.dart';
import 'package:saas/main.dart';
import '../login_screen.dart';
import '../setting_screens/app_info.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.isArabic() ? 'الاعدادات' : 'Settings',
                style: cubit.isArabic()
                    ? arTitleStyle(
                        color: defaultColor, size: 24, weight: FontWeight.w600)
                    : AppBarTheme.of(context).titleTextStyle?.copyWith(
                          color: AppCubit.get(context).isLightTheme
                              ? defaultColor
                              : defaultLightColor,
                        ),
              ),
              backgroundColor: AppCubit.get(context).isLightTheme
                  ? defaultBackgroundColor
                  : defaultDarkBackgroundColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppCubit.get(context).isLightTheme
                    ? defaultBackgroundColor
                    : defaultDarkBackgroundColor,
                statusBarIconBrightness: AppCubit.get(context).isLightTheme
                    ? Brightness.dark
                    : Brightness.light,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  settingSectionName(
                      cubit.isArabic() ? 'الملف الشخصي' : 'Account', context),
                  heightSpace(),
                  settingItem(
                    const Icon(Icons.lock),
                    cubit.isArabic() ? 'كلمة المرور' : 'Password',
                    context,
                    const PasswordScreen(),
                  ),
                  heightSpace(),
                  settingItem(
                    const Icon(
                      Icons.phone_android_rounded,
                    ),
                    cubit.isArabic() ? 'رقم الهاتف' : 'Phone number',
                    context,
                    const PhoneScreen(),
                  ),
                  heightSpace(),
                  settingSectionName(
                    cubit.isArabic() ? 'عام' : 'General',
                    context,
                  ),
                  heightSpace(),
                  settingSwitchItem(
                    const Icon(
                      Icons.language_rounded,
                    ),
                    cubit.isArabic() ? 'اللغة' : 'Language',
                    context,
                    //const PasswordScreen(),
                    Icons.change_circle_outlined,
                    Icons.change_circle_outlined,
                    (bool state) {
                      AppCubit.get(context).changeLanguage();
                    },
                  ),
                  heightSpace(),
                  settingSwitchItem(
                    const Icon(
                      Icons.brightness_4_rounded,
                    ),
                    cubit.isArabic() ? 'الاضاءة' : 'Theme',
                    context,
                    //const PasswordScreen(),
                    Icons.light_mode_outlined,
                    Icons.dark_mode_outlined,
                    (bool state) {
                      AppCubit.get(context).ChangeMode(state);
                    },
                  ),
                  heightSpace(),
                  settingItem(
                    const Icon(
                      Icons.info_rounded,
                    ),
                    cubit.isArabic() ? 'معلومات عن التطبيق' : 'App info',
                    context,
                    const InfoScreen(),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      //navigateToThenRemove(context, LoginScreen());
                      print('Logout');
                    },
                    /*child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: defaultColor,
                      ),*/
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: AppCubit.get(context).isLightTheme
                                ? defaultColor
                                : defaultLightColor,
                          ),
                          widthSpace(),
                          Text(
                            cubit.isArabic() ? 'تسجيل الخروج' : 'LOGOUT',
                            style: cubit.isArabic()
                                ? arTitleStyle(size: 20, color: defaultColor)
                                : titleStyle(
                                    size: 20,
                                    color: AppCubit.get(context).isLightTheme
                                        ? defaultColor
                                        : defaultLightColor,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    //),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
