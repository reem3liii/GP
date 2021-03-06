import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:saas/main.dart';
import 'package:saas/modules/for_student/semester_courses.dart';
import 'package:saas/shared/bloc/cubit.dart';
import 'package:saas/shared/bloc/states.dart';
import 'package:saas/shared/items/components.dart';
import 'package:saas/shared/design/colors.dart';
import 'package:saas/shared/items/json_models.dart';


class Details extends StatefulWidget {
   Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
   @override
   Widget build(BuildContext context) {
     double height = MediaQuery.of(context).size.height;
     double width = MediaQuery.of(context).size.width;
     int standard = 1;

     AppCubit cubitDegrees = AppCubit.get(context);
     return BlocProvider(
       create: (BuildContext context) => AppCubit(),
       child: BlocConsumer<AppCubit,AppStates>(
         listener: (BuildContext context,AppStates state){},
         builder: (BuildContext context,AppStates state){
           AppCubit cubit = AppCubit.get(context);
           return Scaffold(
             appBar: AppBar(
               title: Text(
                 isArabic ? 'تقرير الدرجات' : 'Degrees Report',
                 style: isArabic
                     ? arTitleStyle(
                   size: 20,
                   color: Colors.white,
                 )
                     : AppBarTheme.of(context).titleTextStyle,
               ),
               automaticallyImplyLeading: false,
             ),
             //backgroundColor: Colors.grey.shade100,
             body: ConditionalBuilder(
               condition: semestersAndGrades.isNotEmpty,
               builder: (context) => SingleChildScrollView(
                 physics: const BouncingScrollPhysics(),
                 child: Column(
                   children: [
                     const SizedBox(
                       height: 20,
                     ),
                     Padding(
                       padding: const EdgeInsets.only(
                         left: 20,
                         right: 20,
                       ),
                       child: ListView.separated(
                           physics: const BouncingScrollPhysics(),
                           shrinkWrap: true,
                           itemBuilder: (context, index) => Container(
                             decoration: BoxDecoration(
                               color: MyApp.themeNotifier.value == ThemeMode.light?
                               Colors.white
                                   :
                               Colors.black.withOpacity(0.8),
                               borderRadius: BorderRadius.circular(10),
                               boxShadow: const [
                                 BoxShadow(
                                   blurRadius: 0,
                                   offset: Offset(0.2, 0.2),
                                   color: Colors.grey,
                                 ),
                               ],
                             ),
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                 children: [
                                   Row(
                                     children: [
                                       SizedBox(
                                         width: width / 5,
                                         child: Padding(
                                           padding: const EdgeInsets.all(5),
                                           child: GestureDetector(
                                             child: Text(
                                               semestersAndGrades[index].semesterName.toString(),
                                               style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                                 fontSize: width/15,
                                                 fontWeight: FontWeight.w500,
                                                 color: MyApp.themeNotifier.value == ThemeMode.light? defaultColor : defaultLightColor,
                                               ),
                                             ),
                                             onTap: () {
                                               setState(() {
                                                 navigateTo(context, showSemesterCourses(semestersAndGrades[index].semesterName.toString()));
                                                 //cubitDegrees.visible(index);

                                               });
                                             },
                                           ),
                                         ),
                                       ),
                                       Column(
                                         children: [
                                           Text(
                                             '   GPA',
                                             style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                               fontSize: width/30,
                                             ),
                                           ),
                                           SizedBox(
                                             height: height / 200,
                                           ),
                                           Stack(
                                             children: [
                                               LinearPercentIndicator(
                                                 width: width / 2,
                                                 animation: true,
                                                 animationDuration: 750,
                                                 lineHeight: height / 35,
                                                 percent: semestersAndGrades[index].gpAofSemester! / 4,
                                                 progressColor: semestersAndGrades[index].gpAofSemester! >= standard
                                                     ? defaultGreenColor.shade300
                                                     : Colors.red.shade400,
                                                 backgroundColor: MyApp.themeNotifier.value == ThemeMode.light? Colors.grey.shade200 : Colors.grey.shade800,
                                                 barRadius: const Radius.circular(12),
                                                 curve: Curves.easeInOut,
                                               ),
                                               Positioned(
                                                 top: 1,
                                                 left: 14,
                                                 child: Text(
                                                   semestersAndGrades[index].gpAofSemester!.toStringAsFixed(2),
                                                   style: bodyStyle(
                                                     size: width / 30,
                                                     weight: FontWeight.w600,
                                                     color: Colors.white,
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ],
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                       ),
                                     ],
                                   ),
                                   /*Visibility(
                                   visible: cubitDegrees.arrayOfVisible[index],
                                   child: Container(
                                     padding: const EdgeInsets.symmetric(
                                         vertical: 10, horizontal: 20),
                                     child: Column(
                                       children: [
                                         ListView.separated(
                                           physics: const ScrollPhysics(),
                                           shrinkWrap: true,
                                           itemBuilder: (context, sub) => Row(
                                               mainAxisAlignment:
                                               MainAxisAlignment
                                                   .spaceBetween,
                                               children: [
                                                 Text(
                                                   //isArabic
                                                   //? arSubjects[index].keys.toList()[sub]:
                                                   courses_Semester[sub].courseName.toString(),
                                                   style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.w500,
                                                     overflow: TextOverflow.ellipsis,
                                                   ),
                                                 ),
                                                 Text(
                                                   courses_Semester[sub].gpa!.toStringAsFixed(1),
                                                   /*subjects[index][
                                                     subjects[index]
                                                         .keys
                                                         .toList()[sub]]
                                                         .toString(),*/
                                                   style: bodyStyle(
                                                       size: 16,
                                                       weight: FontWeight.w600,
                                                       color: courses_Semester[sub].gpa! >
                                                           standard
                                                           ? Colors.green
                                                           : Colors.red),
                                                 ),
                                               ]),
                                           separatorBuilder: (context, sub) =>
                                           const SizedBox(height: 10),
                                           itemCount: courses_Semester.length,),
                                         /*ConditionalBuilder(
                                           condition: state is CoursesOnSemesterLoadingState,
                                           builder: (context) =>
                                           fallback: (context) => const Center(child: CircularProgressIndicator(),),
                                         ),*/
                                       ],
                                     ),
                                   ),
                                 )*/
                                 ],
                                 crossAxisAlignment: CrossAxisAlignment.start,
                               ),
                             ),
                           ),
                           separatorBuilder: (context, index) => SizedBox(
                             height: height / 50,
                           ),
                           itemCount: semestersAndGrades.length),
                     ),
                     const SizedBox(
                       height: 20,
                     ),
                   ],
                 ),
               ),
               fallback: (context) => Padding(
                 padding: EdgeInsets.symmetric(
                   vertical: height/4,
                 ),
                 child: Center(
                   child: Column(
                     children: [
                       Image.asset(
                         'assets/images/noCourses.png',
                         width: width/1.75,
                         height: height/3.75,
                       ),
                       const Text('You do not have Semesters now.',style: TextStyle(
                         fontSize: 17,
                         color: Colors.grey,
                       ),),
                     ],
                   ),
                 ),
               ),
             ),
           );
         },
       ),
     );
   }

/*
=======
class Details extends StatelessWidget {
  Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int standard = 2;

    AppCubit cubitDegrees = AppCubit.get(context);
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                isArabic ? 'تقرير الدرجات' : 'Degrees Report',
                style: isArabic
                    ? arTitleStyle(
                        size: 20, color: Colors.white, weight: FontWeight.w600)
                    : titleStyle(
                        color: Colors.white, size: 24, weight: FontWeight.w600),
              ),
              automaticallyImplyLeading: false,
            ),
            //backgroundColor: Colors.grey.shade100,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 0,
                                    offset: Offset(0.2, 0.2),
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width / 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: GestureDetector(
                                              child: Text(
                                                semesters[index]
                                                    .keys
                                                    .toList()
                                                    .first,
                                                style: titleStyle(
                                                  size: width / 15,
                                                  color: defaultColor,
                                                ),
                                                //TextStyle(fontSize: 25, color: defaultColor),
                                              ),
                                              onTap: () {
                                                cubitDegrees.visible(index);
                                                /*setState(() {
                                             arrayOfVisible[index] =
                                             !arrayOfVisible[index];
                                           });*/
                                              },
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '   GPA',
                                              style: titleStyle(
                                                size: width / 30,
                                                //color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: height / 200,
                                            ),
                                            Stack(
                                              children: [
                                                LinearPercentIndicator(
                                                  width: width / 2,
                                                  animation: true,
                                                  animationDuration: 750,
                                                  lineHeight: height / 35,
                                                  percent: semesters[index]
                                                          .values
                                                          .last
                                                          .toDouble() /
                                                      4,
                                                  progressColor:
                                                      semesters[index]
                                                                  .values
                                                                  .last
                                                                  .toDouble() >
                                                              standard
                                                          ? defaultGreenColor
                                                              .shade300
                                                          : Colors.red.shade400,
                                                  backgroundColor:
                                                      Colors.grey.shade200,
                                                  barRadius:
                                                      const Radius.circular(12),
                                                  curve: Curves.easeInOut,
                                                ),
                                                Positioned(
                                                  top: 1,
                                                  left: 14,
                                                  child: Text(
                                                    semesters[index]
                                                        .values
                                                        .last
                                                        .toString(),
                                                    style: bodyStyle(
                                                      size: width / 30,
                                                      weight: FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible:
                                          cubitDegrees.arrayOfVisible[index],
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Column(
                                          children: [
                                            ListView.separated(
                                                physics: const ScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, sub) =>
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            isArabic
                                                                ? arSubjects[
                                                                            index]
                                                                        .keys
                                                                        .toList()[
                                                                    sub]
                                                                : subjects[
                                                                        index]
                                                                    .keys
                                                                    .toList()[sub],
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          Text(
                                                            subjects[
                                                                    index][subjects[
                                                                        index]
                                                                    .keys
                                                                    .toList()[sub]]
                                                                .toString(),
                                                            style: bodyStyle(
                                                                size: 16,
                                                                weight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: double.parse(subjects[index][subjects[index].keys.toList()[sub]]
                                                                            .toString()) >
                                                                        standard
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .red),
                                                          ),
                                                        ]),
                                                separatorBuilder: (context,
                                                        sub) =>
                                                    const SizedBox(height: 10),
                                                itemCount:
                                                    subjects[index].length)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: height / 50,
                            ),
                        itemCount: int.parse(data[5].toString())),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }*/
}

