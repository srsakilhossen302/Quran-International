import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Utils/AppColors/app_colors.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../LanguageScreen/language_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..forward();

    // Example: Navigate to next screen after animation
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAll(() => const LanguageScreen());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false, // Prevents keyboard from pushing content
      body: Stack(
        children: [
          // Background Decorative Dots exactly matching reference image
          Positioned(
            top: size.height * 0.20,
            left: size.width * 0.20,
            child: _buildDot(
              3,
              const Color(0xFF5AB678).withOpacity(0.6),
            ), // Top-left small green dot
          ),
          Positioned(
            top: size.height * 0.30,
            right: size.width * 0.25,
            child: _buildDot(
              5,
              const Color(0xFF5AB678).withOpacity(0.4),
            ), // Top-right glowing green dot
          ),
          Positioned(
            top: size.height * 0.65,
            right: size.width * 0.30,
            child: _buildDot(
              3,
              AppColors.primaryText.withOpacity(0.8),
            ), // Mid-right sharp yellow dot
          ),
          Positioned(
            top: size.height * 0.75,
            left: size.width * 0.20,
            child: _buildDot(
              2.5,
              const Color(0xFF5AB678).withOpacity(0.5),
            ), // Mid-left green dot
          ),
          Positioned(
            bottom: size.height * 0.20,
            left: size.width * 0.15,
            child: _buildStar(
              10,
              const Color(0xFF5AB678).withOpacity(0.5),
            ), // Bottom-left star/sparkle
          ),
          Positioned(
            bottom: size.height * 0.17,
            right: size.width * 0.45,
            child: _buildDot(
              3.5,
              const Color(0xFF5AB678).withOpacity(0.7),
            ), // Bottom-mid green dot
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: size.height - (MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom),
                child: Column(
                  children: [
                    const Spacer(flex: 3),
    
                    // Central PNG image containing logo, text, dots, glows, and shadows
                    Center(
                      child: Image.asset(
                        AppIcons.mainContentWrapperPng,
                        // Automatically scales while maintaining proportions
                        fit: BoxFit.contain,
                      ),
                    ),
    
                    const Spacer(flex: 2),
    
                    // Progress Bar and Loading Text
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 30.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'LOADING...',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Text(
                                    '${(_controller.value * 100).toInt()}%',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryText,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          // Custom Linear Progress
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Stack(
                                children: [
                                  Container(
                                    height: 4.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.progressBackground,
                                      borderRadius: BorderRadius.circular(2.r),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: _controller.value,
                                    child: Container(
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryText,
                                        borderRadius: BorderRadius.circular(2.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primaryText
                                                .withOpacity(0.5),
                                            blurRadius: 4.r,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(double size, Color color) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.8),
            blurRadius: size.r,
            spreadRadius: (size / 2).r,
          ),
        ],
      ),
    );
  }

  Widget _buildStar(double size, Color color) {
    return SizedBox(
      width: size.w,
      height: size.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: size.w, height: 1.5.h, color: color),
          Container(width: 1.5.w, height: size.h, color: color),
          Transform.rotate(
            angle: 0.785, // ~45 degrees
            child: Container(width: size.w * 0.7, height: 1.5.h, color: color),
          ),
          Transform.rotate(
            angle: 0.785,
            child: Container(width: 1.5.w, height: size.h * 0.7, color: color),
          ),
        ],
      ),
    );
  }
}
