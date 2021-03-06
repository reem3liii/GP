import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saas/modules/login_screen.dart';
import 'package:saas/modules/setting_screens/app_info.dart';
import 'package:saas/modules/setting_screens/password.dart';
import 'package:saas/modules/setting_screens/phone.dart';
import 'package:saas/shared/design/colors.dart';
import 'package:saas/shared/items/components.dart';


class SettingScreenAdv extends StatelessWidget {
  const SettingScreenAdv({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: titleStyle(
              color: defaultColor, size: 24, weight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: defaultBackArrow(),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: defaultBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: defaultBackgroundColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        color: defaultBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      settingSectionName('Account'),
                      heightSpace(),
                      settingItem(const Icon(Icons.lock_outline_rounded),
                          'Password', context, const PasswordScreen()),
                      heightSpace(),
                      settingItem(const Icon(Icons.phone_android_outlined),
                          'Phone number', context, const PhoneScreen()),
                      heightSpace(),
                      settingSectionName('General'),
                      heightSpace(),
                      settingSwitchItem(
                          const Icon(Icons.language_rounded),
                          'Language',
                          context,
                          const PasswordScreen(),
                          Icons.change_circle_outlined,
                          Icons.change_circle_outlined),
                      heightSpace(),
                      settingSwitchItem(
                          const Icon(Icons.brightness_4_rounded),
                          'Theme',
                          context,
                          const PasswordScreen(),
                          Icons.light_mode_outlined,
                          Icons.dark_mode_outlined),
                      heightSpace(),
                      settingItem(const Icon(Icons.info_outline_rounded),
                          'App info', context, const InfoScreen()),
                      heightSpace(),
                      settingSectionName('Advanced'),
                      heightSpace(),
                      settingItem(const Icon(Icons.account_box_outlined),
                          'Students', context, const PasswordScreen()),
                      heightSpace(),
                      settingItem(const Icon(Icons.account_tree_outlined),
                          'Courses', context, const PasswordScreen()),
                      heightSpace(),
                      settingItem(const Icon(Icons.account_circle_outlined),
                          'Advisors', context, const PasswordScreen()),
                      heightSpace(),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  navigateToThenRemove(context,  LoginScreen());
                  print('Logout');
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(8),
                    color: defaultColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          color: defaultBeigeColor,
                        ),
                        widthSpace(),
                        Text(
                          'LOGOUT',
                          style: titleStyle(size: 20, color: defaultBeigeColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
