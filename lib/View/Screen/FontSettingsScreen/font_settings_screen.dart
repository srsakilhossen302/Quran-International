import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_international/Utils/AppColors/app_colors.dart';
import 'Controller/font_settings_controller.dart';

class FontSettingsScreen extends StatelessWidget {
  const FontSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FontSettingsController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Font Settings',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => controller.reset(),
            child: Text(
              'Reset',
              style: GoogleFonts.montserrat(
                color: const Color(0xFF22C55E),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            _buildSectionHeader("LIVE PREVIEW"),
            SizedBox(height: 15.h),
            _buildLivePreviewCard(controller),
            SizedBox(height: 35.h),
            _buildSectionHeader("ARABIC SCRIPT STYLE"),
            SizedBox(height: 15.h),
            _buildScriptStyleSelector(controller),
            SizedBox(height: 35.h),
            _buildSectionLabelRow("ARABIC FONT SIZE", "Large"),
            SizedBox(height: 15.h),
            _buildArabicSizeSlider(controller),
            SizedBox(height: 35.h),
            _buildSectionLabelRow("TRANSLATION SIZE", "Normal"),
            SizedBox(height: 15.h),
            _buildTranslationSizeSlider(controller),
            SizedBox(height: 40.h),
            _buildSaveButton(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        color: const Color(0xFF328A44),
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSectionLabelRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSectionHeader(title),
        Text(
          value,
          style: GoogleFonts.montserrat(
            color: const Color(0xFF328A44),
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLivePreviewCard(FontSettingsController controller) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0D1D13),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/Image+Overlay.png',
                  width: double.infinity,
                  height: 160.h,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xFF0D1D13).withOpacity(0.8),
                          const Color(0xFF0D1D13),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 30.h),
            child: Column(
              children: [
                Text(
                  "SURAH AL-FATIHAH • VERSE 1",
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF328A44),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 20.h),
                Obx(() => Text(
                  "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.amiri(
                    color: Colors.white,
                    fontSize: controller.arabicFontSize.value.sp,
                    height: 1.6,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                SizedBox(height: 20.h),
                Obx(() => Text(
                  "\"In the name of Allah, the Entirely Merciful, the Especially Merciful.\"",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFFB5C1B8),
                    fontSize: controller.translationFontSize.value.sp,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScriptStyleSelector(FontSettingsController controller) {
    final styles = ["Uthmani", "Indo-Pak", "Madani"];
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1D13).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: styles.map((style) {
          return Expanded(
            child: Obx(() {
              final isSelected = controller.selectedScript.value == style;
              return GestureDetector(
                onTap: () => controller.setScript(style),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF328A44) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      style,
                      style: GoogleFonts.montserrat(
                        color: isSelected ? Colors.white : const Color(0xFFB5C1B8),
                        fontSize: 13.sp,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildArabicSizeSlider(FontSettingsController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("A-", style: GoogleFonts.montserrat(color: const Color(0xFF8DA493), fontSize: 13.sp, fontWeight: FontWeight.bold)),
            Expanded(
              child: Obx(() => SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4.h,
                  activeTrackColor: const Color(0xFF324A3B),
                  inactiveTrackColor: const Color(0xFF324A3B),
                  thumbColor: const Color(0xFF22C55E),
                  overlayColor: const Color(0xFF22C55E).withOpacity(0.1),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.r), // Hidden thumb
                  trackShape: const RectangularSliderTrackShape(),
                ),
                child: Slider(
                  value: controller.arabicFontSize.value,
                  min: 18.0,
                  max: 30.0,
                  divisions: 3,
                  onChanged: (val) => controller.updateArabicSize(val),
                ),
              )),
            ),
            Text("A++", style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
          ],
        ),
        // Custom Dots for slider
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              return Obx(() {
                final double val = 18.0 + (index * 4.0);
                final bool isSelected = controller.arabicFontSize.value == val;
                return Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF22C55E) : const Color(0xFF324A3B),
                    shape: BoxShape.circle,
                  ),
                );
              });
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildTranslationSizeSlider(FontSettingsController controller) {
    return Row(
      children: [
        Icon(Icons.text_fields, color: const Color(0xFF8DA493), size: 18.sp),
        Expanded(
          child: Obx(() => SliderTheme(
            data: SliderThemeData(
              trackHeight: 4.h,
              activeTrackColor: const Color(0xFF324A3B),
              inactiveTrackColor: const Color(0xFF324A3B),
              thumbColor: const Color(0xFF22C55E),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.r), // Hidden thumb
            ),
            child: Slider(
              value: controller.translationFontSize.value,
              min: 12.0,
              max: 20.0,
              onChanged: (val) => controller.updateTranslationSize(val),
            ),
          )),
        ),
        Icon(Icons.text_fields, color: Colors.white, size: 24.sp),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF328A44),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 0,
        ),
        child: Text(
          "Save Changes",
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
