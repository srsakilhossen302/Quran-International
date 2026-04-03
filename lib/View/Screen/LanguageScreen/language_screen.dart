import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Utils/AppColors/app_colors.dart';
import '../../../../Utils/Constants/app_languages.dart';

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
            fontSize: 18,
            fontWeight: FontWeight.w400, // Medium to light weight
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              // Globe Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.language,
                  color: Colors.greenAccent,
                  size: 30,
                ),
              ),
              const SizedBox(height: 20),
              
              // Instruction Text
              Text(
                'Choose your preferred language for the\nQuran translation and app interface.',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 30),
              
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  style: GoogleFonts.montserrat(color: Colors.white),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search languages',
                    hintStyle: GoogleFonts.montserrat(color: AppColors.textSecondary),
                    prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
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
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: isSelected ? AppColors.primaryGreen : AppColors.cardBackground,
                            width: 1.5,
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
                                    fontSize: 15,
                                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  lang['nativeName']!,
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            // Radio indicator
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? AppColors.primaryGreen : AppColors.cardBorder,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
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
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Save language and go next
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 16,
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
