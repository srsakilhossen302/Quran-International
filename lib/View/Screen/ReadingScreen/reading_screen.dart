import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran_international/Utils/AppColors/app_colors.dart';
import 'Controller/reading_controller.dart';

class ReadingScreen extends GetView<ReadingController> {
  const ReadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(height: 40.h),
                _buildBismillah(),
                SizedBox(height: 20.h),
                _buildDivider(),
                SizedBox(height: 30.h),
                Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.ayahs.length,
                      itemBuilder: (context, index) {
                        final ayah = controller.ayahs[index];
                        return _buildAyahTile(ayah, index == 0);
                      },
                    )),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Surah ${controller.surah.enName}',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${controller.surah.type} • ${controller.surah.verses} VERSES',
            style: GoogleFonts.montserrat(
              color: const Color(0xFF38FF7E),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white, size: 24.sp),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.settings_outlined, color: Colors.white, size: 24.sp),
          onPressed: () {},
        ),
        SizedBox(width: 10.w),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'READING PROGRESS',
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF38FF7E),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              Obx(() => Text(
                    '${controller.currentAyah.value} / ${controller.surah.verses}',
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF38FF7E),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: controller.currentAyah.value / controller.surah.verses,
              backgroundColor: const Color(0xFF162A1E),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF38FF7E)),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBismillah() {
    return Column(
      children: [
        Text(
          'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            'In the name of Allah, the Entirely Merciful, the Especially Merciful',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: const Color(0xFF38FF7E),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFF162A1E), thickness: 1)),
        Container(
          width: 8.w,
          height: 8.w,
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: const BoxDecoration(
            color: Color(0xFF38FF7E),
            shape: BoxShape.circle,
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFF162A1E), thickness: 1)),
      ],
    );
  }

  Widget _buildAyahTile(Map<String, String> ayah, bool isActive) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ayah['number']!,
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF38FF7E),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  _actionIcon('assets/icons/Save-Icons.svg'),
                  SizedBox(width: 20.w),
                  _actionIcon('assets/icons/Edit-Icons.svg'),
                  SizedBox(width: 20.w),
                  _actionIcon('assets/icons/copy-icons.svg'),
                  SizedBox(width: 20.w),
                  Icon(Icons.share_outlined, color: const Color(0xFF7F9285), size: 22.sp),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            ayah['arabic']!,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              height: 1.8,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              if (isActive)
                Container(
                  width: 3.w,
                  height: 60.h,
                  margin: EdgeInsets.only(right: 15.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF38FF7E),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              Expanded(
                child: Text(
                  ayah['english']!,
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFFB6CDBD),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionIcon(String asset) {
    return SvgPicture.asset(
      asset,
      width: 22.w,
      height: 22.w,
      colorFilter: const ColorFilter.mode(Color(0xFF7F9285), BlendMode.srcIn),
    );
  }
}
