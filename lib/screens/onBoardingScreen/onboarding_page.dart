import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatefulWidget {
  final double top2;
  final double left2;
  final String imagePath2;
  final String que;
  final String soln;
  final String nextButtonLabel;
  final String? backButtonLabel;
  final VoidCallback onNextButtonPressed;
  final VoidCallback? onBackButtonPressed;
  final double currentPageValue;
  const OnboardingPage({
    super.key,
    required this.top2,
    required this.left2,
    required this.imagePath2,
    required this.que,
    required this.soln,
    required this.nextButtonLabel,
    required this.onNextButtonPressed,
    this.backButtonLabel,
    this.onBackButtonPressed,
    required this.currentPageValue});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390,844),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover, 
              )
            ),
          ),
          Positioned(
            top: widget.top2,
            left: widget.left2,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(widget.imagePath2,height: 300.h,width: 400.w,),
            ),
          ),
          Positioned(
            top: 450,
            left: 27,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                widget.que,
                style: TextStyle(
                  fontFamily: 'Montserrat-Bold',
                  color: Colors.black,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            top: 490,
            left: 27,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.soln,
                  style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 150.75,
            top: 590,
            child: DotsIndicator(
              dotsCount: 3,
              position: widget.currentPageValue.toInt(),
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                color: Colors.black26,
                activeColor: Colors.green, // Set the active color here
                activeSize: const Size(20.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: widget.onNextButtonPressed,
              style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 14.0),
                  backgroundColor: Color(0xFF80BCA7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
              child: Text(
                widget.nextButtonLabel,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat-Bold',
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (widget.backButtonLabel != null &&
              widget.onBackButtonPressed != null)
            Positioned(
              bottom: 16.0,
              left: 16.0,
              child: TextButton(
                onPressed: widget.onBackButtonPressed,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, // Set the text color here
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios,
                        color: Color(0xFF343D6B)), // Add back arrow icon
                    SizedBox(
                        width: 1.0.w), // Add some spacing between the icon and text
                    Text(
                      widget.backButtonLabel!,
                      style: TextStyle(
                        color: Color(0xFF343D6B),
                        fontSize: 15.0.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}