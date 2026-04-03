import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:quran_international/service/connectivity_service.dart';
import 'package:quran_international/service/database_helper.dart';
import '../Model/surah_model.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final RxBool isLoading = true.obs;
  final RxList<SurahModel> surahs = <SurahModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    _initializeData();
  }

  // Predefined Static Data (Fallback & Initial View)
  final List<SurahModel> _staticSurahs = [
    SurahModel(id: 1, enName: "Al-Fatihah", arName: "الفاتحة", type: "MECCAN", verses: 7),
    SurahModel(id: 2, enName: "Al-Baqarah", arName: "البقرة", type: "MEDINAN", verses: 286),
    SurahModel(id: 3, enName: "Ali 'Imran", arName: "آل عمران", type: "MEDINAN", verses: 200),
    SurahModel(id: 4, enName: "An-Nisa", arName: "النساء", type: "MEDINAN", verses: 176),
    SurahModel(id: 5, enName: "Al-Ma'idah", arName: "المائدة", type: "MEDINAN", verses: 120),
    SurahModel(id: 6, enName: "Al-An'am", arName: "الأنعام", type: "MECCAN", verses: 165),
    SurahModel(id: 7, enName: "Al-A'raf", arName: "الأعراف", type: "MECCAN", verses: 206),
    SurahModel(id: 8, enName: "Al-Anfal", arName: "الأنفال", type: "MEDINAN", verses: 75),
    SurahModel(id: 9, enName: "At-Tawbah", arName: "التوبة", type: "MEDINAN", verses: 129),
    SurahModel(id: 10, enName: "Yunus", arName: "يونس", type: "MECCAN", verses: 109),
  ];

  Future<void> _initializeData() async {
    try {
      final dbSurahs = await DatabaseHelper.instance.getSurahs();
      if (dbSurahs.isNotEmpty) {
        surahs.assignAll(dbSurahs.map((map) => SurahModel.fromMap(map)).toList());
        isLoading.value = false;
      } else {
        surahs.assignAll(_staticSurahs);
        await refreshData();
      }
    } catch (e) {
      surahs.assignAll(_staticSurahs);
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    // Check connection first
    final bool hasInternet = await Get.find<ConnectivityService>().isConnected();
    if (!hasInternet) {
      Get.find<ConnectivityService>().updateConnectionStatus([ConnectivityResult.none]); // Force alert
      return;
    }

    isLoading.value = true;
    
    try {
      await Future.delayed(const Duration(seconds: 2));
      final List<SurahModel> latestData = _staticSurahs; 

      for (var surah in latestData) {
        await DatabaseHelper.instance.insertSurah(surah.toMap());
      }

      surahs.assignAll(latestData);
    } catch (e) {
      // Keep existing
    } finally {
      isLoading.value = false;
    }
  }
}
