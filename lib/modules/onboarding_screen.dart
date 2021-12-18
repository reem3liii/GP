import 'package:flutter/material.dart';
import 'package:saas/modules/login_screen.dart';
import 'package:saas/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:saas/models/models.dart';
import 'package:saas/shared/styles/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarding1.png',
        title: 'Welcome to SAAS',
        body:
            'It is an acadimic support system for students and acadimic advisors.'),
    BoardingModel(
        image: 'assets/images/onboarding2.png',
        title: 'The goal of the application',
        body:
            'It helps you by suggesting courses that meet your current needs, and at the same time improve your academic performance.'),
    BoardingModel(
        image: 'assets/images/onboarding3.png',
        title: 'Let\'s get started',
        body:
            'You are now ready to use the application, you can login or sign up by using your university email.'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: defaultBackgroundColor,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                navigateToThenRemove(context, const LoginScreen());
              },
              child: Text(
                'SKIP',
                style: bodyStyle(),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                      activeDotColor: defaultColor,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        navigateToThenRemove(context, const LoginScreen());
                      } else {
                        boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    backgroundColor: defaultColor,
                    mini: true,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        Text(
          model.title,
          style: titleStyle(),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          model.body,
          style: bodyStyle(),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
