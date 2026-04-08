import 'package:quran_international/service/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_international/View/Screen/SplashScreen/splash_screen.dart';
import 'package:quran_international/View/Screen/HomeScreen/home_screen.dart';
import 'package:quran_international/View/Screen/BookmarkScreen/bookmark_screen.dart';
import 'package:quran_international/View/Screen/HighlightScreen/highlight_screen.dart';
import 'package:quran_international/View/Screen/SearchScreen/search_screen.dart';
import 'package:quran_international/View/Screen/SettingsScreen/settings_screen.dart';
import 'package:quran_international/View/Screen/FontSettingsScreen/font_settings_screen.dart';
import 'package:quran_international/View/Screen/PrayerTimesScreen/prayer_times_screen.dart';
import 'package:quran_international/View/Screen/ReadingScreen/reading_screen.dart';
import 'package:quran_international/View/Screen/ReadingScreen/Controller/reading_controller.dart';

import 'package:quran_international/Utils/AppColors/app_colors.dart';

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
            scaffoldBackgroundColor: AppColors.background, // Fixed white flash
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF22C55E),
              brightness: Brightness.dark,
            ),
          ),
          defaultTransition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 200),
          home: const SplashScreen(),
          getPages: [
            GetPage(name: '/home', page: () => const HomeScreen()),
            GetPage(name: '/search', page: () => const SearchScreen()),
            GetPage(name: '/bookmark', page: () => const BookmarkScreen()),
            GetPage(name: '/highlights', page: () => const HighlightScreen()),
            GetPage(name: '/settings', page: () => const SettingsScreen()),
            GetPage(name: '/font_settings', page: () => const FontSettingsScreen()),
            GetPage(name: '/prayer_times', page: () => const PrayerTimesScreen()),
            GetPage(
              name: '/reading',
              page: () => const ReadingScreen(),
              binding: BindingsBuilder(() {
                Get.lazyPut<ReadingController>(() => ReadingController());
              }),
            ),
          ],
        );
      },
    );
  }
}
