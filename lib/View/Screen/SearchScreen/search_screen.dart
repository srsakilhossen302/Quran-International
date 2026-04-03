import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_international/Utils/AppColors/app_colors.dart';
import 'package:quran_international/Utils/AppIcons/app_icons.dart';
import 'package:quran_international/View/Widget/CustomBottomNavBar/custom_bottom_nav_bar.dart';
import 'Controller/search_controller.dart' as sc;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(sc.SearchController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              _buildSearchBox(),
              SizedBox(height: 30.h),
              _buildSectionHeader("QUICK SEARCH"),
              SizedBox(height: 15.h),
              _buildQuickSearchGrid(controller),
              SizedBox(height: 35.h),
              _buildSectionHeaderWithClear("RECENT SEARCHES", controller),
              SizedBox(height: 15.h),
              _buildRecentSearchList(controller),
              SizedBox(height: 35.h),
              _buildDailyInspirationCard(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white70),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Search',
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0E2515), // Exact dark green background
        borderRadius: BorderRadius.circular(35.r), // Fully rounded Pill shape
      ),
      child: TextField(
        cursorColor: const Color(0xFF22C55E),
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 16.sp,
          letterSpacing: 0.2,
        ),
        decoration: InputDecoration(
          hintText: 'Search Surah, Ayat, or Topics',
          hintStyle: GoogleFonts.montserrat(
            color: const Color(0xFF8DA493).withOpacity(0.6), // Muted grey-green hint
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 12.w),
            child: Icon(
              Icons.search,
              color: const Color(0xFF8DA493), // Matches image icon color
              size: 26.sp,
            ),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18.h),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        color: const Color(0xFF7F9285).withOpacity(0.8),
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSectionHeaderWithClear(String title, sc.SearchController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSectionHeader(title),
        GestureDetector(
          onTap: () => controller.clearRecentSearches(),
          child: Text(
            "Clear All",
            style: GoogleFonts.montserrat(
              color: const Color(0xFF22C55E).withOpacity(0.6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickSearchGrid(sc.SearchController controller) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: controller.quickSearchItems.map((item) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFF0D2517), // Deep selection green
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.05),
              width: 1.w,
            ),
          ),
          child: Text(
            item,
            style: GoogleFonts.montserrat(
              color: const Color(0xFFB5C1B8), // Muted greyish white
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecentSearchList(sc.SearchController controller) {
    return Obx(() {
      if (controller.recentSearches.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            "No recent searches",
            style: GoogleFonts.montserrat(color: Colors.white30, fontSize: 13.sp),
          ),
        );
      }
      return Column(
        children: controller.recentSearches.map((item) {
          return Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppIcons.time, // Matches Time-Icons.svg
                  width: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF7F9285),
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 15.w),
                Text(
                  item,
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF8DA493), // Subtitle color
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildDailyInspirationCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0D2D1E), // Dark emerald green card
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Stack(
        children: [
          // Background icon watermark
          Positioned(
            right: -20,
            bottom: -20,
            child: SvgPicture.asset(
              AppIcons.book, // Using book icon as background
              width: 100.w,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.04),
                BlendMode.srcIn,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daily Inspiration",
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF22C55E), // Exact green link
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "\"So verily, with every difficulty, there is relief.\"",
                style: GoogleFonts.montserrat(
                  color: Colors.white70,
                  fontSize: 14.sp,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(
                  "EXPLORE SURAH AL-INSHIRAH",
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF7F9285),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
