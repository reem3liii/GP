import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:saas/main.dart';
import 'package:saas/shared/models.dart';
import 'package:saas/shared/colors.dart';

import 'bloc/cubit.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateToThenRemove(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (route) => false,
);

TextStyle titleStyle(
    {color = Colors.black, double size = 30, weight = FontWeight.bold}) =>
    GoogleFonts.jost(
      textStyle: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );

TextStyle arTitleStyle(
    {color = Colors.black, double size = 30, weight = FontWeight.bold}) =>
    TextStyle(
      fontFamily: 'IBM',
      fontSize: size,
      fontWeight: weight,
      color: color,
    );

TextStyle arBodyStyle(
    {color = Colors.black,
      double size = 20.0,
      weight = FontWeight.normal}) =>
    TextStyle(
      fontFamily: 'IBM',
      fontSize: size,
      fontWeight: weight,
      color: color,
    );

TextStyle bodyStyle(
    {color = Colors.black,
      double size = 20.0,
      weight = FontWeight.normal}) =>
    GoogleFonts.abel(
      textStyle: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
TextStyle bodyStyle2(
    {color = Colors.black,
      double size = 20.0,
      weight = FontWeight.normal}) =>
    GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
TextStyle bodyStyle3(
    {color = Colors.black,
      double size = 20.0,
      weight = FontWeight.normal}) =>
    GoogleFonts.actor(
      textStyle: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );

Widget defaultTextField({
  required TextEditingController textEditingController,
  required TextInputType textInputType,
  String labelText = '',
  required preIcon,
  required validator,
  bool isPassword = false,
  suffixIcon,
  suffixPressed,
  onTapFunction,
  Color iconcolor = Colors.white,
}) =>
    TextFormField(
      controller: textEditingController,
      keyboardType: textInputType,
      obscureText: isPassword,
      validator: validator,
      onTap: onTapFunction,
      decoration: InputDecoration(
        //filled: true,
        labelText: labelText,
        prefixIcon: Icon(
          preIcon,
          //color: iconcolor,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixPressed,
        )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 0.8),
        ),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  double height = 50,
  Color textColor = Colors.white,
  required function,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            defaultColor,
            defaultColor1,
          ],
        ),
        borderRadius: BorderRadiusDirectional.circular(25.0),
        /*boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(1, 3),
            color: Colors.grey.shade700,
          ),
        ],*/
      ),
      height: height,
      width: width,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 17),
        ),
        //color: HexColor('064B68'),
      ),
    );

//Widget defaultBackArrow() => const Icon(Icons.arrow_back_ios_new_rounded);

Widget defaultForwardArrow() => const Icon(
  Icons.arrow_forward_ios_rounded,
  size: 20,
);

Widget settingSectionName(name,context) => Text(
  name,
  style: isArabic
      ? arTitleStyle(size: 20)
      : Theme.of(context).textTheme.bodyText1?.copyWith(
    fontWeight: FontWeight.w700,
    color: AppCubit.get(context).isLightTheme? defaultColor:defaultLightColor,
  ),
);

Widget settingItem(icon, title, context, screen) => InkWell(
  onTap: () {
    navigateTo(context, screen);
  },
  child: Container(
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(10),
      //color: defaultLightColor.withOpacity(0.5),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          icon,
          widthSpace(),
          Text(
            title,
            style: isArabic ? arBodyStyle(size: 18) : Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          defaultForwardArrow(),
        ],
      ),
    ),
  ),
);

Widget settingSwitchItem(icon, title, context, leftIcon, rightIcon,function) =>
    InkWell(
      /*onTap: () {
        navigateTo(context, screen);
      },*/
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          //color: defaultLightColor.withOpacity(0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              icon,
              widthSpace(),
              Text(
                title,
                style: isArabic ? arBodyStyle(size: 18) : Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              RollingSwitch.icon(
                onChanged: function,/*(bool state) {
                  print('turned ${(state) ? 'on' : 'off'}');
                },*/
                rollingInfoLeft: RollingIconInfo(
                  icon: leftIcon,
                  backgroundColor: defaultColor,
                ),
                rollingInfoRight: RollingIconInfo(
                  icon: rightIcon,
                  backgroundColor: defaultColor,
                ),
                width: 80,
                //h//eight: 30,
                //innerSize: 20,
              )
            ],
          ),
        ),
      ),
    );

Widget heightSpace() => const SizedBox(
  height: 10,
);
Widget widthSpace() => const SizedBox(
  width: 10,
);

Widget containerWithOROutShadow({
  required widget,
  double blurRadiusValue = 4,
  double offsetValue1 = 1,
  double offsetValue2 = 2,
  required height,
  required  Color color,

}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
        boxShadow: [
          BoxShadow(
            blurRadius: blurRadiusValue,
            offset: Offset(offsetValue1, offsetValue2),
            color: Colors.grey,
          ),
        ],
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: height,
      child: widget,
    );

Widget defaultCircularPercentIndicator({
  required String titleText,
  required String value,
  required Color color,
  required Color titlecolor,
  required Color backgroundcolor,
  required double percentValue,
  required double radius,
  required double height,
  required BuildContext context,
}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            titleText,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: height,
          ),
          Center(
            child: CircularPercentIndicator(
              radius: radius,
              lineWidth: 9.0,
              backgroundWidth: 5,
              animation: true,
              animationDuration: 1500,
              percent: percentValue,
              center: Text(
                value,
                style: bodyStyle(
                  color: color,
                  weight: FontWeight.w700,
                ),
                //TextStyle(fontSize: 18.0,color: color,fontWeight: FontWeight.w500),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: color,
              //backgroundColor: Colors.grey.shade100,
              backgroundColor: backgroundcolor,
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );

Widget defaultGridViewList({
  required list,
  required itembuild,
}) =>
    GridView.builder(
      padding: const EdgeInsets.all(5),
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 170,
      ),
      itemBuilder: itembuild,
    );

Widget coursesList(CurrentCourses course, {
  required double height,
  required Color color,
  required Color titleColor,
  required BuildContext context,
}) => containerWithOROutShadow(
  blurRadiusValue: 0,
  offsetValue1: 0,
  offsetValue2: 0.2,
  widget: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            course.courseAbbreviation,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: course.color
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: course.color.withOpacity(0.2),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        ),
        SizedBox(
          height: height / 20,
        ),
        Text(
          isArabic ? course.arCourseName : course.courseName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style:Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          '(${course.courseCode})',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(
          height: height / 120,
        ),
        Row(
          children: [
            Icon(
              Icons.perm_identity,
              color: Colors.grey.shade600,
              size: 12,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                isArabic
                    ? "دكتور ${course.arCourseProfessor}"
                    : "Dr. ${course.courseProfessor}",
                style:
                TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                //softWrap: false,
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
  ),
  height: height,
  color: color,
);

Widget recCoursesItem(CurrentCourses course,{
  required double height,
  required double width,
  required Color color,
  required Color titleColor,
  required BuildContext context,
}) => Padding(
  padding: const EdgeInsetsDirectional.only(
    bottom: 12,
  ),
  child: Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              course.courseAbbreviation,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: courses[1].color),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: courses[1].color.withOpacity(0.2),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
          const Spacer(),
          SizedBox(
            width: width/3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? course.arCourseName : course.courseName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 18,
                  ),
                ),
                Text(
                  '(${course.courseCode})',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.perm_identity,
                      color: Colors.grey.shade600,
                      size: 15,
                    ),
                    SizedBox(
                      width: width/100,
                    ),
                    Flexible(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        //strutStyle: StrutStyle(fontSize: 12.0),
                        text: TextSpan(
                          style: TextStyle(fontSize: 12.0,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w800,),
                          text: isArabic
                              ? "دكتور  ${course.arCourseProfessor}"
                              : "Dr. ${course.courseProfessor}",
                        ),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_rounded),
            color: defaultColor,
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cancel_rounded),
            color: Colors.red.shade600,
            iconSize: 30,
          ),
        ],
      ),
    ),
  ),
);
