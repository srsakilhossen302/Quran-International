import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_international/Utils/AppIcons/app_icons.dart';
import 'package:quran_international/View/Widget/CustomBottomNavBar/custom_bottom_nav_bar.dart';
import 'package:quran_international/View/Widget/Skeleton/skeleton_loader.dart';

import '../../../Utils/AppColors/app_colors.dart';
import 'Controller/bookmark_controller.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookmarkController controller = Get.put(BookmarkController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Bookmarks',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const BookmarkSkeleton();
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          itemCount: controller.bookmarks.length,
          itemBuilder: (context, index) {
            final bookmark = controller.bookmarks[index];
            return _buildBookmarkCard(bookmark);
          },
        );
      }),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2, // Bookmarks index
        onTap: (index) {
          // Handle navigation later
        },
      ),
    );
  }

  Widget _buildBookmarkCard(dynamic bookmark) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular icon background
              Container(
                width: 48.w,
                height: 48.w,
                padding: EdgeInsets.all(12.w),
                decoration: const BoxDecoration(
                  color: Color(0xFF0D1D13), // Deep green circle
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppIcons.book, // Matches Book_icons.svg
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
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
                      bookmark.surahName,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      bookmark.verseInfo,
                      style: GoogleFonts.montserrat(
                        color: AppColors.textSecondary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                AppIcons.save, // Matches Save-Icons.svg
                width: 18.w,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Arabic Text - Right aligned
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              bookmark.arabicText,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          // English Translation
          Text(
            bookmark.englishTranslation,
            style: GoogleFonts.montserrat(
              color: const Color(0xFFB5C1B8), // Muted greyish white for translation
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          SizedBox(height: 15.h),
          // Read Ayah Link
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Read Ayah >',
              style: GoogleFonts.montserrat(
                color: const Color(0xFF1B5E34), // Darker green link color
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
