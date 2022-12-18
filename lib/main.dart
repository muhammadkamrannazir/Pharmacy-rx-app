import 'package:custom_material_color/custom_material_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pharmacy_rx/views/pages/Auth/login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Pharmacy',
        theme: ThemeData(
          // primaryColor: Colors.blue,
          primarySwatch: MaterialColorFromHex(0xff0170BA),
          textTheme: Typography.englishLike2021.apply(
            fontSizeFactor: 1.sp,
            // bodyColor: Colors.black,
          ),
          iconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Poppins',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
      ),
    );
  }
}



    // <uses-permission android:name="android.permission.INTERNET" />