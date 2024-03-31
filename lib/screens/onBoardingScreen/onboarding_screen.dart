import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycleright/screens/onBoardingScreen/onboarding_page.dart';
import 'package:recycleright/screens/signup.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  double currentPageValue = 0;
  double vehiclePosition = 0;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390,844),
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentPageValue = page.toDouble();
                  vehiclePosition = currentPageValue * MediaQuery.of(context).size.width;
                });
              },
              children: [
                 OnboardingPage(
                  imagePath2: 'assets/images/bg_1.png',
                  que: 'Are you Recycling Right?',
                  soln: "80% of E-waste ends in landfill or being informally recycled ",
                  nextButtonLabel: "Next",
                  onNextButtonPressed: () {
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  },
                  currentPageValue: currentPageValue,
                  top2: 150,
                  left2: 0,
                 ),
                 OnboardingPage(
                  imagePath2: 'assets/images/bg_2.png',
                  que: 'Power of A Single Phone',
                  soln: "Recycling 1 million mobile phones can save enough energy to power approx 11,000  Indian Households for a year",
                  nextButtonLabel: "Next",
                  onNextButtonPressed: () {
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  },
                  backButtonLabel: "Back",
                  onBackButtonPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                  },
                  currentPageValue: currentPageValue,
                  top2: 150,
                  left2: 0,
                 ),
                 OnboardingPage(
                  imagePath2: 'assets/images/bg_3.png',
                  que: 'Recycle with Ease & Earn',
                  soln: "Find convenient E-waste recycling locations and earn rewards for your waste",
                  nextButtonLabel: "Next",
                  onNextButtonPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  backButtonLabel: "Back",
                  onBackButtonPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                  },
                  currentPageValue: currentPageValue,
                  top2: 150,
                  left2: 0,
                 ),
              ],
            )
          ],
        ),
      ),
    );
  }
}