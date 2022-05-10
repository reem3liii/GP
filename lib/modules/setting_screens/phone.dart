import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saas/main.dart';
import 'package:saas/shared/bloc/cubit.dart';
import 'package:saas/shared/bloc/states.dart';
import 'package:saas/shared/components.dart';
import 'package:saas/shared/colors.dart';

var formKey2 = GlobalKey<FormState>();
var phoneController = TextEditingController();
var confirmController = TextEditingController();

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({Key? key}) : super(key: key);
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
                cubit.isArabic() ? 'تغيير رقم الهاتف' : 'Change Phone Number',
                style: cubit.isArabic()
                    ? arTitleStyle(
                        color: defaultColor, size: 20, weight: FontWeight.w600)
                    : AppBarTheme.of(context).titleTextStyle?.copyWith(
                          color: AppCubit.get(context).isLightTheme
                              ? defaultColor
                              : defaultLightColor,
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
              backgroundColor: defaultBackgroundColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: defaultBackgroundColor,
                statusBarIconBrightness: Brightness.dark,
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
                            cubit.isArabic()
                                ? 'أدخل رقم الهاتف :'
                                : 'Enter your phone number:',
                            style: cubit.isArabic()
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
                                return cubit.isArabic()
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
                            cubit.isArabic()
                                ? 'أدخل الكود المرسل إليك لتأكيد رقمك :'
                                : 'Enter the code sent to you to verify your number:',
                            style: cubit.isArabic()
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
                                return cubit.isArabic()
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
                            text: cubit.isArabic()
                                ? 'حفظ التغييرات'
                                : 'Save Changes',
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
