import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas/main.dart';
import 'package:saas/shared/bloc/cubit.dart';
import 'package:saas/shared/bloc/states.dart';
//import 'package:saas/shared/components.dart';
//import 'package:saas/shared/colors.dart';
import 'package:saas/shared/items/components.dart';
import 'package:saas/shared/design/colors.dart';

var formKey2 = GlobalKey<FormState>();
var phoneController = TextEditingController();
var confirmController = TextEditingController();

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context,AppStates state){},
        builder: (BuildContext context,AppStates state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                isArabic ? 'تغيير رقم الهاتف' : 'Change Phone Number',
                style: isArabic
                    ? arTitleStyle(
                    color: defaultColor, size: 20, weight: FontWeight.w600)
                    : AppBarTheme.of(context).titleTextStyle?.copyWith(
                  color: MyApp.themeNotifier.value == ThemeMode.light? defaultColor: defaultLightColor,
                ),
              ),
              //leading: IconButton(
              //  icon: isArabic
              //      ? const Icon(Icons.arrow_forward_ios_rounded)
              //      : const Icon(Icons.arrow_back_ios_new_rounded),
              //  onPressed: () {
              //    Navigator.pop(context);
              //  },
              //),
              backgroundColor: MyApp.themeNotifier.value == ThemeMode.light? defaultBackgroundColor:defaultDarkBackgroundColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: MyApp.themeNotifier.value == ThemeMode.light? defaultBackgroundColor:defaultDarkBackgroundColor,
                statusBarIconBrightness: MyApp.themeNotifier.value == ThemeMode.light? Brightness.dark:Brightness.light,
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: formKey2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isArabic
                                ? 'أدخل رقم الهاتف :'
                                : 'Enter your phone number:',
                            style: isArabic
                                ? arBodyStyle(
                                size: 16,
                                color: defaultColor,
                                weight: FontWeight.bold)
                                : bodyStyle3(
                                size: 16,
                                color: defaultColor,
                                weight: FontWeight.bold),
                          ),
                          heightSpace(),
                          defaultTextField(
                            textEditingController: phoneController,
                            textInputType: TextInputType.phone,
                            preIcon: Icons.phone_android_outlined,
                            validator: (phoneController) {
                              if (phoneController.toString().isEmpty) {
                                return isArabic
                                    ? 'من فضلك أدخل الرقم!'
                                    : 'Please enter your phone number!';
                              } else {
                                return null;
                              }
                            },
                          ),
                          heightSpace(),
                          heightSpace(),
                          Text(
                            isArabic
                                ? 'أدخل الكود المرسل إليك لتأكيد رقمك :'
                                : 'Enter the code sent to you to verify your number:',
                            style: isArabic
                                ? arBodyStyle(
                                size: 16,
                                color: defaultColor,
                                weight: FontWeight.bold)
                                : bodyStyle3(
                                size: 16,
                                color: defaultColor,
                                weight: FontWeight.bold),
                          ),
                          heightSpace(),
                          defaultTextField(
                            textEditingController: confirmController,
                            textInputType: TextInputType.number,
                            preIcon: Icons.comment_outlined,
                            validator: (confirmController) {
                              if (confirmController.toString().isEmpty) {
                                return isArabic
                                    ? 'قم بمراجعة سجل رسائلك ثم أدخل الكود المرسل اليك'
                                    : 'Check your SMS then enter the sent code';
                              } else {
                                return null;
                              }
                            },
                          ),
                          heightSpace(),
                          heightSpace(),
                          defaultButton(
                            function: () {
                              if (formKey2.currentState!.validate()) {
                                print('Phone number changed');
                              }
                            },
                            text: isArabic ? 'حفظ التغييرات' : 'Save Changes',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
