import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saas/main.dart';
import 'package:saas/shared/components/components.dart';
import 'package:saas/shared/styles/colors.dart';

class GPACalculator extends StatefulWidget {
  var initialCount;

  //int initialCount;
  GPACalculator({
    this.initialCount = 5,
  });

  @override
  _GPACalculatorState createState() => _GPACalculatorState();
}

class _GPACalculatorState extends State<GPACalculator> {
  int initialCount = 5;
  int fieldCount = 0;
  int nextIndex = 0;
  double a = 0, a2 = 0;
  double res = 0;

  List<TextEditingController> gpaControllers = <TextEditingController>[];
  List<TextEditingController> creditControllers = <TextEditingController>[];

  // create the list of TextFields, based off the list of TextControllers
  List<Widget> _buildList1() {
    int i;
    // fill in keys if the list is not long enough (in case we added one)
    if (gpaControllers.length < fieldCount) {
      for (i = gpaControllers.length; i < fieldCount; i++) {
        gpaControllers.add(TextEditingController());
      }
    }

    i = 0;
    // cycle through the controllers, and recreate each, one per available controller
    return gpaControllers.map<Widget>((
      TextEditingController controller,
    ) {
      int displayNumber = i + 1;
      i++;
      return Row(
        children: [
          widthSpace(),
          widthSpace(),
          Expanded(
            child: Text(
              isArabic ? 'مقرر $displayNumber' : 'Course $displayNumber',
              style: isArabic
                  ? arTitleStyle(
                      size: 17,
                      color: defaultGreenColor,
                    )
                  : titleStyle(
                      size: 17,
                      color: defaultGreenColor,
                    ),
            ),
          ),
          //const Spacer(),
          widthSpace(),
          widthSpace(),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                labelText: isArabic ? 'تقدير المقرر' : "GPA",
                counterText: "",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      );
    }).toList(); // convert to a list
  }

  List<Widget> _buildList2() {
    int i;
    // fill in keys if the list is not long enough (in case we added one)
    if (creditControllers.length < fieldCount) {
      for (i = creditControllers.length; i < fieldCount; i++) {
        creditControllers.add(TextEditingController());
      }
    }
    // cycle through the controllers, and recreate each, one per available controller
    return creditControllers.map<Widget>((
      TextEditingController controller1,
    ) {
      return Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller1,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                labelText: isArabic ? 'عدد الساعات' : "Credit",
                counterText: "",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // generate the list of TextFields
    final List<Widget> children = _buildList1();
    final List<Widget> children2 = _buildList2();

    // append an 'add player' button to the end of the list
    //children2.add();

    // build the ListView
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        title: Text(
          isArabic ? 'حساب المعدل الاكاديمي' : 'GPA Calculator',
          style: isArabic
              ? arTitleStyle(
                  size: 20,
                  color: Colors.white,
                )
              : titleStyle(
                  size: 20,
                  color: Colors.white,
                ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: defaultColor,
          statusBarIconBrightness: Brightness.light,
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: defaultColor,
        onPressed: () {
          setState(() {
            fieldCount++;
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  widthSpace(),
                  widthSpace(),
                  Expanded(
                    child: Text(
                      isArabic ? 'المقرر' : 'Courses',
                      style: isArabic
                          ? arTitleStyle(
                              size: 18.0,
                              color: defaultOrangeColor.shade300,
                            )
                          : titleStyle(
                              size: 18.0,
                              color: defaultOrangeColor.shade300,
                            ),
                    ),
                  ),
                  widthSpace(),
                  widthSpace(),
                  Expanded(
                    child: Text(
                      isArabic ? 'التقدير' : 'GPA',
                      style: isArabic
                          ? arTitleStyle(
                              size: 18.0,
                              color: defaultOrangeColor.shade300,
                            )
                          : titleStyle(
                              size: 18.0,
                              color: defaultOrangeColor.shade300,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      isArabic ? 'الساعات' : 'Credits',
                      style: isArabic
                          ? arTitleStyle(
                              size: 18.0,
                              color: defaultOrangeColor.shade300,
                            )
                          : titleStyle(
                              size: 18.0,
                              color: defaultOrangeColor.shade300,
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: children,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: children2,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultButton(
                  width: 150,
                  function: () {
                    for (int j = 0; j < fieldCount; j++) {
                      if (gpaControllers[j].text.toString() != "") {
                        if (double.parse(gpaControllers[j].text.toString()) >=
                            1.0) {
                          a2 += double.parse(
                              creditControllers[j].text.toString());
                          a +=
                              (double.parse(gpaControllers[j].text.toString()) *
                                  double.parse(
                                      creditControllers[j].text.toString()));
                        }
                      }
                    }
                    res = (a / a2);
                    print(a / a2);
                    setState(() {
                      res = res;
                    });
                  },
                  text: isArabic ? 'احسب' : 'CALCULATE',
                ),
              ),
              // ignore: unnecessary_string_interpolations
              heightSpace(),
              heightSpace(),
              Text(
                isArabic
                    ? "المعدل الاكاديمي : ${res.toStringAsFixed(2)}"
                    : "Semester GPA: ${res.toStringAsFixed(2)}",
                style: isArabic
                    ? arTitleStyle(
                        size: 20,
                        color: a == 0 && a2 == 0
                            ? Colors.white.withOpacity(0)
                            : defaultOrangeColor,
                      )
                    : titleStyle(
                        size: 20,
                        color: a == 0 && a2 == 0
                            ? Colors.white.withOpacity(0)
                            : defaultOrangeColor,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // upon creation, copy the starting count to the current count
    fieldCount = widget.initialCount;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(GPACalculator oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  } // convert to a list

}







/*

class CoursesList extends StatefulWidget {
  const CoursesList({
    this.initialCount = 5,
  });

  final int initialCount;
  @override
  _CoursesListState createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {

  }


  @override

}*/




























  /*alert()  {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text('Please enter number of courses to calculate GPA'),
          actions: <Widget>[
            FlatButton(
              child:  const Icon(Icons.clear,size: 40.0,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}*//*Column(
        children: [

          heightSpace(),
          /*ContainerWithOROutShadow(
                    blurRadiusValue: 0,
                    offsetValue1: 0.2,
                    offsetValue2: 0.2,
                    widget: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          /*list.forEach((coursesNumbers){
                            ;
                          });*/
                          Row(
                            children:[
                              Text('Your course:',style: TextStyle(color: defaultBlueColor.shade400,fontSize: 16,fontWeight: FontWeight.w500),),
                              const Spacer(),
                              SizedBox(
                                width: 50,
                                child: TextField(
                                  controller: GradeByNumberController,
                                  keyboardType: TextInputType.number,
                                  //onTap: (){},
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Grade',
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 50,
                                child: TextField(
                                  controller: GradeController,
                                  keyboardType: TextInputType.text,
                                  //onTap: (){},
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Grade',
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 50,
                                child: TextField(
                                  controller: CreditController,
                                  keyboardType: TextInputType.number,
                                  //onTap: (){},
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Credit',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          defaultButton(
                              function: (){
                                setState(() {
                                  coursesNumbers++;
                                  print(coursesNumbers);
                                });
                              },
                              text: '+',
                              width:50,
                          ),
                        ],
                      ),
                    )),*/
          /*SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => CoursesList(courses[index]),
                    itemCount: courses.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),*/
        ],
      ),
    );
  }
}*/
