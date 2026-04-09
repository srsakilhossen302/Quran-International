import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_international/Utils/AppColors/app_colors.dart';
import 'package:quran_international/View/Widget/CustomBottomNavBar/custom_bottom_nav_bar.dart';
import 'Controller/adhan_recitations_controller.dart';

class AdhanRecitationsScreen extends StatelessWidget {
  const AdhanRecitationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdhanRecitationsController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Adhan\nRecitations',
                  style: GoogleFonts.amiri(
                    color: const Color(0xFF22C55E),
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Choose a voice that resonates with your soul. The call to prayer is the heartbeat of the believer\'s day.',
                  style: GoogleFonts.montserrat(
                    color: const Color(0xFF8DA493),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 32.h),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 150.h), // Space for player
                    itemCount: controller.recitations.length,
                    itemBuilder: (context, index) {
                      final item = controller.recitations[index];
                      return _buildRecitationItem(context, item, controller);
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: _buildBottomPlayer(controller),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 4),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Color(0xFF22C55E)),
        onPressed: () {},
      ),
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
          ),
          child: Icon(
            Icons.notifications_none,
            color: const Color(0xFF22C55E),
            size: 24.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildRecitationItem(BuildContext context, Map<String, String> item, AdhanRecitationsController controller) {
    return Obx(() {
      final isSelected = controller.selectedAdhan.value == item['name'];
      final isPlaying = controller.currentlyPlaying.value == item['name'] && controller.isPlaying.value;

      return Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1D13).withOpacity(0.6),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF22C55E).withOpacity(0.3) : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Image.network(
                item['image']!,
                width: 56.w,
                height: 56.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name']!,
                    style: GoogleFonts.montserrat(
                      color: isSelected ? const Color(0xFF22C55E) : Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    item['subtitle']!,
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF8DA493),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => controller.togglePlayback(item['name']!),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: isPlaying ? const Color(0xFF22C55E).withOpacity(0.1) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0D3D22)),
                ),
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 20.sp,
                  color: const Color(0xFF22C55E),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: () => controller.selectAdhan(item['name']!),
              child: Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF22C55E) : const Color(0xFF0D3D22),
                    width: isSelected ? 6.w : 2.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBottomPlayer(AdhanRecitationsController controller) {
    return Obx(() {
      if (controller.currentlyPlaying.isEmpty) return const SizedBox.shrink();

      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1D13),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D2517),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.graphic_eq, color: const Color(0xFF22C55E), size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Previewing: ${controller.currentlyPlaying.value}',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'NOW PLAYING',
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFF22C55E),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.isPlaying.toggle(),
                  child: Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                    color: const Color(0xFF22C55E),
                    size: 32.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            LinearProgressIndicator(
              value: controller.progress.value,
              backgroundColor: Colors.white.withOpacity(0.05),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF22C55E)),
              minHeight: 4.h,
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1:24', style: GoogleFonts.montserrat(color: const Color(0xFF8DA493), fontSize: 10.sp)),
                Text('3:10', style: GoogleFonts.montserrat(color: const Color(0xFF8DA493), fontSize: 10.sp)),
              ],
            ),
          ],
        ),
      );
    });
  }
}
