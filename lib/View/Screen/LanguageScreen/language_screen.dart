import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_international/Utils/AppColors/app_colors.dart';
import 'package:quran_international/Utils/Constants/app_languages.dart';
import '../HomeScreen/home_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _searchQuery = '';
  String _selectedLanguageCode = 'en';

  @override
  Widget build(BuildContext context) {
    final filteredLanguages = AppLanguages.languageList.where((lang) {
      final name = lang['name']!.toLowerCase();
      final nativeName = lang['nativeName']!.toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || nativeName.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigator.pop(context); // Handle back action
          },
        ),
        title: Text(
          'Select Language',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400, // Medium to light weight
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              
              // Globe Icon
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.language,
                  color: Colors.greenAccent,
                  size: 30.sp,
                ),
              ),
              SizedBox(height: 20.h),
              
              // Instruction Text
              Text(
                'Choose your preferred language for the\nQuran translation and app interface.',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: AppColors.textSecondary,
                  fontSize: 13.sp,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 30.h),
              
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: TextField(
                  style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14.sp),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search languages',
                    hintStyle: GoogleFonts.montserrat(color: AppColors.textSecondary, fontSize: 14.sp),
                    prefixIcon: Icon(Icons.search, color: AppColors.textSecondary, size: 20.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              
              // Languages List
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLanguages.length,
                  itemBuilder: (context, index) {
                    final lang = filteredLanguages[index];
                    final isSelected = lang['code'] == _selectedLanguageCode;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLanguageCode = lang['code']!;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            color: isSelected ? AppColors.primaryGreen : AppColors.cardBackground,
                            width: 1.5.w,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lang['name']!,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  lang['nativeName']!,
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.textSecondary,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            // Radio indicator
                            Container(
                              width: 22.w,
                              height: 22.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? AppColors.primaryGreen : AppColors.cardBorder,
                                  width: 2.w,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 10.w,
                                        height: 10.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Continue Button
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => const HomeScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
