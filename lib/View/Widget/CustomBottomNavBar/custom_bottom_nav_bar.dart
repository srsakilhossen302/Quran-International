import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavBar({super.key, required this.selectedIndex});

  void _onItemTapped(int index) {
    // Only navigate if we are not already on the selected page
    if (index == selectedIndex) return;

    switch (index) {
      case 0:
        Get.offAllNamed('/home');
        break;
      case 1:
        Get.offAllNamed('/search');
        break;
      case 2:
        Get.offAllNamed('/bookmark');
        break;
      case 3:
        Get.offAllNamed('/highlights');
        break;
      case 4:
        Get.offAllNamed('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1E15), // Premium dark green background
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.r,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _navItem(
              'assets/icons/Home_Icons-navbar.svg',
              "HOME",
              0,
            ),
          ),
          Expanded(
            child: _navItem(
              'assets/icons/Search_Icons-navbar.svg',
              "SEARCH",
              1,
            ),
          ),
          Expanded(
            child: _navItem(
              'assets/icons/Bookmarks_Icons-navbar.svg',
              "BOOKMARKS",
              2,
            ),
          ),
          Expanded(
            child: _navItem(
              'assets/icons/Highlights_Icons-navbar.svg',
              "HIGHLIGHTS",
              3,
            ),
          ),
          Expanded(
            child: _navItem(
              'assets/icons/Settings_Icons-navbar.svg',
              "SETTINGS",
              4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String iconPath, String label, int index) {
    final bool isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque, // To capture clicks more easily
      child: Container(
        // Add a transparent rectangle to increase tap area without visible splash
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
        color: Colors.transparent, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24.w,
              height: 24.w,
              colorFilter: ColorFilter.mode(
                isActive ? const Color(0xFF22C55E) : const Color(0xFF7F9285),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 10.sp,
                color: isActive ? const Color(0xFF22C55E) : const Color(0xFF7F9285),
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
