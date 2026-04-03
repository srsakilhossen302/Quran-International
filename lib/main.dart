import 'package:quran_international/service/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_international/View/Screen/SplashScreen/splash_screen.dart';
import 'package:quran_international/View/Screen/HomeScreen/home_screen.dart';
import 'package:quran_international/View/Screen/BookmarkScreen/bookmark_screen.dart';
import 'package:quran_international/View/Screen/HighlightScreen/highlight_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ConnectivityService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 976),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quran International',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const SplashScreen(),
          getPages: [
            GetPage(name: '/home', page: () => const HomeScreen()),
            GetPage(name: '/bookmark', page: () => const BookmarkScreen()),
            GetPage(name: '/highlights', page: () => const HighlightScreen()),
          ],
        );
      },
    );
  }
}
