import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_international/View/Widget/CustomBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:quran_international/View/Widget/Skeleton/skeleton_loader.dart';

import '../../../../Utils/AppColors/app_colors.dart';
import 'Controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inject Controller
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: _buildAppBar(),

      body: RefreshIndicator(
        onRefresh: () => controller.refreshData(),
        color: const Color(0xFF22C55E), // Progress color
        backgroundColor: const Color(0xFF0D1E15), // Background of the circle
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ), // Ensure it's always scrollable for drag down
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                _buildSearchBar(),
                SizedBox(height: 20.h),
                _buildTabBar(controller),
                SizedBox(height: 20.h),
                _buildLastReadCard(),
                SizedBox(height: 25.h),
                _buildSurahList(controller),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0, // Disable color change on scroll
      surfaceTintColor: Colors.transparent, // Disable surface tint
      leadingWidth: 70.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Center(
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: Color(0xFF162A1E), // Circular background for menu icon
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.menu, color: Colors.white, size: 22.sp),
          ),
        ),
      ),
      title: Text(
        'Al-Quran Karim',
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Icon(
            Icons.notifications_none,
            color: const Color(0xFF38FF7E), // Vibrant green from image
            size: 30.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 56.h, // Match Figma height
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05), // #FFFFFF 5% Fill
        borderRadius: BorderRadius.circular(24.r), // 24px Radius
        border: Border.all(
          color: const Color(0xFFB6CDBD).withOpacity(0.2), // #22C55E 20% Border
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF22C55E,
            ).withOpacity(0.1), // #22C55E 10% Drop Shadow
            blurRadius: 15.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        cursorColor: const Color(0xFF22C55E),
        style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: 'Search Surah, Juz, or Ayat',
          hintStyle: GoogleFonts.montserrat(
            color: const Color.fromARGB(255, 189, 207, 194), // Subtitle color
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 12.w),
            child: Icon(
              Icons.search,
              color: const Color(0xFF22C55E), // Exact green color from Figma
              size: 26.sp,
            ),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    );
  }

  Widget _buildTabBar(HomeController controller) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: controller.tabController,
        isScrollable: true,
        tabAlignment:
            TabAlignment.start, // Align to the very start of the container
        padding: EdgeInsets.zero, // Remove default TabBar internal padding
        dividerColor: Colors.transparent, // Remove default divider
        indicatorColor: const Color(0xFF1B402C), // Dark green indicator
        indicatorWeight: 4.h,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ), // Slightly shorter indicator
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF7F9285),
        labelStyle: GoogleFonts.montserrat(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        labelPadding: EdgeInsets.only(right: 32.w, left: 0),
        tabs: const [
          Tab(text: 'Ayat'),
          Tab(text: 'Surah'),
          Tab(text: 'Juz'),
        ],
      ),
    );
  }

  Widget _buildLastReadCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF144D29), // Start green
            Color(0xFF0C331D), // End green
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(
            0xFF22C55E,
          ).withOpacity(0.2), // Subtle Green Border
          width: 1.2.w,
        ),
      ),
      child: Stack(
        children: [
          // Custom Book SVG Icon on the top-right
          Positioned(
            right: 15.w,
            top: 20.h,
            child: Opacity(
              opacity: 0.15,
              child: SvgPicture.asset(
                'assets/icons/Bock_icons.svg',
                width: 80.w,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.flare,
                    color: const Color(
                      0xFF4EEB91,
                    ), // More vibrant green like image
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'LAST READ',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'Al-Baqarah',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Ayah No: 154 • Juz 2',
                style: GoogleFonts.montserrat(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24.h),
              // Pill Button
              Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Continue Reading',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Icon(Icons.arrow_forward, size: 18.sp, color: Colors.black),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSurahList(HomeController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SurahListSkeleton();
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.surahs.length,
        itemBuilder: (context, index) {
          final surah = controller.surahs[index];
          final bool isHighlighted =
              surah.id == 2; // Al-Baqarah is highlighted in the image

          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            width: 408.w,
            height: 82.h, // Specific height from Figma
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: const Color(
                0xFF0A2E15,
              ).withOpacity(0.4), // #0A2E15 40% Fill
              borderRadius: BorderRadius.circular(24.r), // 24px Radius
              border: Border.all(
                color: const Color(
                  0xFF22C55E,
                ).withOpacity(0.2), // #22C55E 20% Border
                width: 1.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFF22C55E,
                  ).withOpacity(0.1), // #22C55E 10% Shadow
                  blurRadius: 15.r,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildSurahBadge(surah.id, true),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center vertically
                    children: [
                      Row(
                        children: [
                          Text(
                            surah.enName,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 16.sp, // Adjusted to fit 82.h
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (isHighlighted) ...[
                            SizedBox(width: 6.w),
                            Icon(
                              Icons.flare,
                              color: const Color(0xFF38FF7E),
                              size: 12.sp,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${surah.type.toUpperCase()} • ${surah.verses} VERSES',
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF7F9285),
                          fontSize: 11.sp, // Adjusted to fit 82.h
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  surah.arName,
                  style: TextStyle(
                    color: const Color(0xFF38FF7E),
                    fontSize: 22.sp, // Adjusted to fit 82.h
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildSurahBadge(int number, bool isHighlighted) {
    return SizedBox(
      width: 42.w,
      height: 42.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/nambar-Icons.svg',
            width: 42.w,
            colorFilter: ColorFilter.mode(
              isHighlighted
                  ? AppColors.primaryGreen
                  : const Color(0xFF7F9285).withOpacity(0.6),
              BlendMode.srcIn,
            ),
          ),
          Text(
            number.toString(),
            style: GoogleFonts.montserrat(
              color: isHighlighted ? AppColors.primaryGreen : Colors.white70,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
