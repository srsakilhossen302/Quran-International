import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_international/Utils/AppColors/app_colors.dart';
import 'package:quran_international/Utils/AppIcons/app_icons.dart';
import 'package:quran_international/View/Widget/CustomBottomNavBar/custom_bottom_nav_bar.dart';
import 'Controller/prayer_times_controller.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrayerTimesController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              Text(
                'Prayer Times',
                style: GoogleFonts.amiri(
                  color: Colors.white,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: const Color(0xFF8DA493), size: 14.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'Dhaka, Bangladesh',
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF8DA493),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                'FRIDAY, JAN 24, 2026',
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF328A44),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 25.h),
              _buildNextPrayerCard(),
              SizedBox(height: 35.h),
              _buildPrayerList(controller),
              SizedBox(height: 30.h),
              _buildActionButtons(),
              SizedBox(height: 35.h),
              _buildQuoteSection(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 4),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white70),
        onPressed: () {},
      ),
      centerTitle: true,
      title: Text(
        'Sacred Observatory',
        style: GoogleFonts.amiri(
          color: const Color(0xFF22C55E),
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20.w),
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xFF0D2517),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF22C55E).withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Icon(Icons.notifications_none, color: const Color(0xFF22C55E), size: 24.sp),
        ),
      ],
    );
  }

  Widget _buildNextPrayerCard() {
    return Container(
      width: double.infinity,
      height: 196.h,
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFA2D1BB), // Light green from Figma
            Color(0xFF0F3D2E), // Dark green from Figma
          ],
        ),
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA2D1BB).withOpacity(0.1), // 10% Drop shadow
            blurRadius: 20,
            offset: const Offset(0, 0),
          )
        ],
        border: Border.all(
          color: const Color(0xFFA2D1BB).withOpacity(0.3), // Simulating inner shadow/highlight
          width: 0.5.w,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Decorative Arches
          Positioned(
            right: -50.w,
            bottom: -50.h,
            child: Opacity(
              opacity: 0.08,
              child: SvgPicture.asset(AppIcons.mainContentWrapper, width: 250.w),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'NEXT PRAYER',
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF0D1D13).withOpacity(0.6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '12:15',
                        style: GoogleFonts.amiri(
                          color: const Color(0xFF0D1D13).withOpacity(0.7),
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'PM',
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF0D1D13).withOpacity(0.5),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dhuhr',
                    style: GoogleFonts.amiri(
                      color: const Color(0xFF0D1D13),
                      fontSize: 52.sp,
                      fontWeight: FontWeight.w700,
                      height: 0.9,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D1D13).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, size: 16.sp, color: const Color(0xFF0D1D13)),
                        SizedBox(width: 8.w),
                        Text(
                          "in 2h 15m",
                          style: GoogleFonts.montserrat(
                            color: const Color(0xFF0D1D13),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerList(PrayerTimesController controller) {
    return Column(
      children: controller.prayers.map((prayer) {
        final prayerName = prayer['name'] as String;
        final prayerTime = prayer['time'] as String;
        
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1D13).withOpacity(0.5),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D2517),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: SvgPicture.asset(
                  _getPrayerIcon(prayerName),
                  width: 22.w,
                  colorFilter: const ColorFilter.mode(const Color(0xFF22C55E), BlendMode.srcIn),
                ),
              ),
              SizedBox(width: 18.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prayerName,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      prayerTime,
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF8DA493),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => Switch(
                value: controller.prayerStates[prayerName] ?? false,
                onChanged: (val) => controller.togglePrayer(prayerName),
                activeColor: const Color(0xFF22C55E),
                activeTrackColor: const Color(0xFF22C55E).withOpacity(0.3),
                inactiveThumbColor: const Color(0xFF8DA493),
                inactiveTrackColor: Colors.white.withOpacity(0.1),
              )),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(18.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.iconSound, width: 22.w, colorFilter: const ColorFilter.mode(const Color(0xFF22C55E), BlendMode.srcIn)),
            SizedBox(width: 12.w),
            Text(
              "Change Adhan Sound",
              style: GoogleFonts.montserrat(
                color: const Color(0xFFB5C1B8),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1D13).withOpacity(0.4),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        children: [
          SvgPicture.asset(AppIcons.iconStar, width: 24.w, colorFilter: const ColorFilter.mode(const Color(0xFFFFD700), BlendMode.srcIn)),
          SizedBox(height: 25.h),
          Text(
            '"The most beloved of deeds to Allah is prayer at its proper time."',
            textAlign: TextAlign.center,
            style: GoogleFonts.amiri(
              color: const Color(0xFFB5C1B8),
              fontSize: 18.sp,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            'SAHIH BUKHARI',
            style: GoogleFonts.montserrat(
              color: const Color(0xFF328A44),
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  String _getPrayerIcon(String name) {
    switch (name) {
      case 'Fajr':
        return AppIcons.iconFajr;
      case 'Dhuhr':
        return AppIcons.iconDhuhr;
      case 'Asr':
        return AppIcons.iconAsr;
      case 'Maghrib':
        return AppIcons.iconFajr; // Using Fajr but UI will likely be similar
      case 'Isha':
        return AppIcons.iconIsha;
      default:
        return AppIcons.iconDhuhr;
    }
  }
}
