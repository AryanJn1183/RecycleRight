import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycleright/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390,844),
      child: MaterialApp(
        title: 'Recycle Right',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}


