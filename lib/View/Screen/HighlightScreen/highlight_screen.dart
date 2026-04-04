import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_international/Utils/AppColors/app_colors.dart';
import 'package:quran_international/Utils/AppIcons/app_icons.dart';
import 'package:quran_international/View/Widget/CustomBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:quran_international/View/Widget/Skeleton/skeleton_loader.dart';
import 'Controller/highlight_controller.dart';

class HighlightScreen extends StatelessWidget {
  const HighlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HighlightController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          _buildFilterRow(controller),
          SizedBox(height: 15.h),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.refreshData(),
              color: const Color(0xFF22C55E),
              backgroundColor: const Color(0xFF0D1E15),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const HighlightSkeleton();
                }
                final list = controller.filteredHighlights;
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      "No highlights found in this category",
                      style: GoogleFonts.montserrat(color: Colors.white70),
                    ),
                  );
                }
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final highlight = list[index];
                    return _buildHighlightCard(highlight);
                  },
                );
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 3),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white70),
        onPressed: () {},
      ),
      title: Text(
        'Highlights',
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white70),
          onPressed: () => Get.toNamed('/search'),
        ),
        SizedBox(width: 10.w),
      ],
    );
  }

  Widget _buildFilterRow(HighlightController controller) {
    final filters = [
      {"label": "All", "color": const Color(0xFF22C55E)},
      {"label": "Yellow", "color": const Color(0xFFFFD700)},
      {"label": "Green", "color": const Color(0xFF22C55E)},
      {"label": "Blue", "color": const Color(0xFF00B0FF)},
      {"label": "Red", "color": const Color(0xFFFF5252)},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: filters.map((filter) {
          return Obx(() {
            final isSelected =
                controller.selectedFilter.value == filter['label'];
            final filterColor = filter['color'] as Color;
            return GestureDetector(
              onTap: () => controller.setFilter(filter['label'] as String),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? filterColor.withOpacity(0.12)
                      : AppColors.cardBackground.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color: isSelected
                        ? filterColor.withOpacity(0.6)
                        : Colors.white.withOpacity(0.06),
                    width: 1.w,
                  ),
                ),
                child: Row(
                  children: [
                    if (filter['label'] != "All")
                      Container(
                        width: 10.w,
                        height: 10.w,
                        margin: EdgeInsets.only(right: 8.w),
                        decoration: BoxDecoration(
                          color: filterColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Text(
                      filter['label'] as String,
                      style: GoogleFonts.montserrat(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontSize: 14.sp,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }).toList(),
      ),
    );
  }

  Widget _buildHighlightCard(HighlightModel highlight) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(
          0xFF16251A,
        ).withOpacity(0.8), // Darker green card background
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular icon container
              Container(
                width: 48.w,
                height: 48.w,
                padding: EdgeInsets.all(12.w),
                decoration: const BoxDecoration(
                  color: Color(0xFF0D1D13), // Deep green background
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppIcons.book,
                  colorFilter: ColorFilter.mode(
                    highlight.highlightColor, // Icon matches highlight color
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${highlight.surahName} ${highlight.reference}',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      highlight.date,
                      style: GoogleFonts.montserrat(
                        color: AppColors.textSecondary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Color Dot on the right
              Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  color: highlight.highlightColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: highlight.highlightColor.withOpacity(0.3),
                      blurRadius: 4.r,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              const Icon(Icons.more_vert, color: Colors.white60),
            ],
          ),
          SizedBox(height: 22.h),
          // Content Container
          Container(
            padding: EdgeInsets.only(left: 14.w),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: highlight.highlightColor, width: 3.5.w),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1D13), // Exact dark green from image
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Text(
                highlight.text,
                style: GoogleFonts.montserrat(
                  color: const Color(0xFFB5C1B8), // Muted greyish text
                  fontSize: 14.sp,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          // Footer Link
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'View in Quran →',
              style: GoogleFonts.montserrat(
                color: const Color(0xFF22C55E), // Exact green link
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
