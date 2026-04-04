import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
      body: Obx(() {
        if (controller.searchQuery.value.isEmpty) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  _buildSearchBox(controller),
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
          );
        } else if (controller.isLoading.value) {
          return _buildShimmerResults(controller);
        } else {
          return _buildSearchResults(controller);
        }
      }),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
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

  Widget _buildSearchBox(sc.SearchController controller) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0E2515), // Deep green card color
        borderRadius: BorderRadius.circular(35.r),
      ),
      child: TextField(
        controller: controller.searchController,
        cursorColor: AppColors.primaryText,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Mercy',
          hintStyle: GoogleFonts.montserrat(
            color: const Color(0xFF8DA493).withOpacity(0.5),
            fontSize: 15.sp,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: const Color(0xFF8DA493),
            size: 24.sp,
          ),
          suffixIcon: controller.searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: const Color(0xFF8DA493).withOpacity(0.8),
                    size: 24.sp,
                  ),
                  onPressed: () => controller.clearSearch(),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 18.h,
            horizontal: 20.w,
          ),
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

  Widget _buildSectionHeaderWithClear(
    String title,
    sc.SearchController controller,
  ) {
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
        return Obx(() {
          final isSelected = controller.selectedTag.value == item;
          return GestureDetector(
            onTap: () => controller.onTagSelected(item),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF22C55E).withOpacity(0.12)
                    : const Color(0xFF0D2517),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF22C55E).withOpacity(0.5)
                      : Colors.white.withOpacity(0.05),
                  width: 1.w,
                ),
              ),
              child: Text(
                item,
                style: GoogleFonts.montserrat(
                  color: isSelected ? Colors.white : const Color(0xFFB5C1B8),
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),
          );
        });
      }).toList(),
    );
  }

  Widget _buildShimmerResults(sc.SearchController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: _buildSearchBox(controller),
        ),
        SizedBox(height: 30.h),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: const Color(0xFF0E2515),
                highlightColor: const Color(0xFF1F4129),
                period: const Duration(milliseconds: 1500),
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  padding: EdgeInsets.all(22.w),
                  decoration: BoxDecoration(
                    color:
                        Colors.white, // Color doesn't matter much for shimmer
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120.w,
                                height: 16.h,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                width: 80.w,
                                height: 10.h,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Container(
                            width: 26.w,
                            height: 26.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 200.w,
                          height: 22.h,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Container(
                        width: double.infinity,
                        height: 13.h,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 150.w,
                        height: 13.h,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults(sc.SearchController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: _buildSearchBox(controller),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            "${controller.searchResults.length} Results found",
            style: GoogleFonts.montserrat(
              color: const Color(0xFF7F9285),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 15.h),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            itemCount: controller.searchResults.length,
            itemBuilder: (context, index) {
              final result = controller.searchResults[index];
              return _buildResultCard(index, result, controller);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard(
    int index,
    Map<String, dynamic> result,
    sc.SearchController controller,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0E2515), // Matching cards from UI
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.white.withOpacity(0.02), width: 0.5.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result['surah'],
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "SURAH ${result['surahNo']} : AYAH ${result['ayahNo']}",
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF7F9285),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => controller.toggleBookmark(index),
                child: Icon(
                  result['isBookmarked']
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: result['isBookmarked']
                      ? AppColors.primaryText
                      : const Color(0xFF1B5E34),
                  size: 26.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              result['arabic'],
              style: GoogleFonts.amiri(
                // Using Amiri for elegant Arabic
                color: Colors.white,
                fontSize: 22.sp,
                height: 1.8,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(height: 20.h),
          _highlightedText(result['translation'], controller.searchQuery.value),
        ],
      ),
    );
  }

  Widget _highlightedText(String text, String query) {
    if (query.isEmpty || !text.toLowerCase().contains(query.toLowerCase())) {
      return Text(
        text,
        style: GoogleFonts.montserrat(
          color: const Color(0xFF8DA493),
          fontSize: 13.sp,
          height: 1.5,
        ),
      );
    }

    final String lowerText = text.toLowerCase();
    final String lowerQuery = query.toLowerCase();
    final List<TextSpan> spans = [];

    int start = 0;
    while (true) {
      final int index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }

      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      start = index + query.length;
    }

    return RichText(
      text: TextSpan(
        style: GoogleFonts.montserrat(
          color: const Color(0xFF8DA493),
          fontSize: 13.sp,
          height: 1.5,
        ),
        children: spans,
      ),
    );
  }

  Widget _buildRecentSearchList(sc.SearchController controller) {
    return Obx(() {
      if (controller.recentSearches.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            "No recent searches",
            style: GoogleFonts.montserrat(
              color: Colors.white30,
              fontSize: 13.sp,
            ),
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
                  AppIcons.time,
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
                    color: const Color(0xFF8DA493),
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
      decoration: BoxDecoration(
        color: const Color(0xFF0E2515),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: Stack(
          children: [
            // Background icon watermark (As requested with large offsets)
            Positioned(
              right: -35.w,
              bottom: -50.h,
              child: SvgPicture.asset(
                AppIcons.bock,
                width: 145.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF1B5E34), // Subtle highlight green
                  BlendMode.srcIn,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daily Inspiration",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "\"So verily, with every difficulty, there is relief.\"",
                    style: GoogleFonts.montserrat(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14.sp,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 22.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Text(
                      "EXPLORE SURAH AL-INSHIRAH",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
