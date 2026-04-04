import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_international/Utils/AppColors/app_colors.dart';
import 'package:quran_international/Utils/AppIcons/app_icons.dart';
import 'package:quran_international/View/Widget/CustomBottomNavBar/custom_bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            _buildProfileSection(),
            SizedBox(height: 40.h),
            _buildSectionHeader("GENERAL"),
            _buildSettingItem(
              icon: AppIcons.language,
              title: "App Language",
              trailing: "English",
              onTap: () {},
            ),
            _buildSettingItem(
              icon: AppIcons.notifications,
              title: "Notifications",
              isSwitch: true,
              switchValue: true,
              onChanged: (val) {},
            ),
            _buildSettingItem(
              icon: AppIcons.time,
              title: "Prayer Times",
              onTap: () => Get.toNamed('/prayer_times'),
            ),
            SizedBox(height: 35.h),
            _buildSectionHeader("DISPLAY"),
            _buildSettingItem(
              icon: AppIcons.darkMode,
              title: "Dark Mode",
              trailing: "System",
              onTap: () {},
            ),
            _buildSettingItem(
              icon: AppIcons.fontSettings,
              title: "Font Settings",
              onTap: () => Get.toNamed('/font_settings'),
            ),
            _buildSettingItem(
              icon: AppIcons.mushafType,
              title: "Mushaf Type",
              trailing: "Uthmani",
              onTap: () {},
            ),
            SizedBox(height: 35.h),
            _buildSectionHeader("SUPPORT"),
            _buildSettingItem(icon: AppIcons.faq, title: "FAQ", onTap: () {}),
            _buildSettingItem(
              icon: AppIcons.about,
              title: "About Quran App",
              onTap: () {},
            ),
            _buildSettingItem(
              icon: AppIcons.logout,
              title: "Log Out",
              isDestructive: true,
              onTap: () {},
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 4),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        Container(
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF1B5E34), width: 2.w),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35.r),
            child: Image.asset(
              'assets/icons/img.png', // Using existing user image
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ahmed Khan",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "ahmed.k@example.com",
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF8DA493),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Edit",
            style: GoogleFonts.montserrat(
              color: const Color(0xFF22C55E),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          color: const Color(0xFF328A44),
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String icon,
    required String title,
    String? trailing,
    bool isSwitch = false,
    bool switchValue = false,
    Function(bool)? onChanged,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.white.withOpacity(0.05),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        child: Row(
          children: [
            // Dark circular background for icon
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: isDestructive
                    ? Colors.red.withOpacity(0.08)
                    : const Color(0xFF0D2517),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SvgPicture.asset(
                icon,
                width: 22.w,
                colorFilter: ColorFilter.mode(
                  isDestructive ? Colors.redAccent : const Color(0xFF22C55E),
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 18.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  color: isDestructive
                      ? Colors.redAccent
                      : Colors.white.withOpacity(0.9),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isSwitch)
              Transform.scale(
                scale: 0.8.w,
                child: Switch(
                  value: switchValue,
                  onChanged: onChanged,
                  activeColor: const Color(0xFF22C55E),
                  activeTrackColor: const Color(0xFF22C55E).withOpacity(0.35),
                  inactiveThumbColor: const Color(0xFF8DA493),
                  inactiveTrackColor: Colors.white.withOpacity(0.1),
                ),
              )
            else ...[
              if (trailing != null)
                Text(
                  trailing,
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF8DA493),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_forward_ios,
                color: const Color(0xFF8DA493).withOpacity(0.4),
                size: 14.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
