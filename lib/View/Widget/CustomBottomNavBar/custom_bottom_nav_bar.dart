import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: const Color(0xFF0D1E15), // Matches the dark background from image
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.05),
            width: 1.w,
          ),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // Disable click splash light
          highlightColor: Colors.transparent, // Disable click highlight
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            onTap(index);
            // Unified Navigation Logic
            if (index == 0) Get.offAllNamed('/home');
            if (index == 2) Get.offAllNamed('/bookmark');
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF22C55E), // Active green
          unselectedItemColor: const Color(0xFF7F9285).withOpacity(0.8), // Inactive muted color
          selectedLabelStyle: GoogleFonts.montserrat(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        items: [
          _buildNavItem(
            icon: 'assets/icons/Home_Icons-navbar.svg',
            label: 'HOME',
            index: 0,
          ),
          _buildNavItem(
            icon: 'assets/icons/Search_Icons-navbar.svg',
            label: 'SEARCH',
            index: 1,
          ),
          _buildNavItem(
            icon: 'assets/icons/Bookmarks_Icons-navbar.svg',
            label: 'BOOKMARKS',
            index: 2,
          ),
          _buildNavItem(
            icon: 'assets/icons/Highlights_Icons-navbar.svg',
            label: 'HIGHLIGHTS',
            index: 3,
          ),
          _buildNavItem(
            icon: 'assets/icons/Settings_Icons-navbar.svg',
            label: 'SETTINGS',
            index: 4,
          ),
        ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = currentIndex == index;
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child: SvgPicture.asset(
          icon,
          width: 24.w,
          height: 24.w,
          colorFilter: ColorFilter.mode(
            isSelected ? const Color(0xFF22C55E) : const Color(0xFF7F9285),
            BlendMode.srcIn,
          ),
        ),
      ),
      label: label,
    );
  }
}
