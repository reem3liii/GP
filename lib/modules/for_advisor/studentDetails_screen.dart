import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saas/shared/design/colors.dart';
import 'package:saas/shared/items/components.dart';
import 'package:saas/shared/items/data.dart';
import 'package:saas/shared/items/json_models.dart';

class StudentDetails extends StatelessWidget {
  final chosenStudent;

  const StudentDetails({Key? key, required this.chosenStudent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: defaultColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: lightDefaultColor),
        title: Text(
          chosenStudent["fullName"],
          style: titleStyle(
            size: 20,
            color: Colors.white,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: defaultColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            // scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) => SizedBox(
                  //  height: height / 15,
                  child: Row(
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: width / 2.8,
                          child: Text(studentKeysLabel[index],
                     style: TextStyle(color: defaultColor,fontSize: 20)
),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          chosenStudent[studentKeys[index]].toString(),
              style: TextStyle(color: defaultColor,fontSize: 20)

                        ),
                      )
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => SizedBox(
              height: height/10,
              child: Divider(
                  thickness: 2,
                  indent: width / 3,
                  color: Colors.grey[300]),
            ),
            itemCount: studentKeys.length),
      ),
    );
  }
}
