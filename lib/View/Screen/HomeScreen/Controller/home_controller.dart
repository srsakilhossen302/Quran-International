import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/surah_model.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  // Observable list
  final surahs = <SurahModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the TabController centrally in the controller
    tabController = TabController(length: 3, vsync: this);
    _loadSurahs();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void _loadSurahs() {
    // Populate with dummy model data initially
    surahs.value = [
      SurahModel(
        id: 1,
        enName: "Al-Fatihah",
        arName: "الفاتحة",
        type: "MECCAN",
        verses: 7,
      ),
      SurahModel(
        id: 2,
        enName: "Al-Baqarah",
        arName: "البقرة",
        type: "MEDINAN",
        verses: 286,
      ),
      SurahModel(
        id: 3,
        enName: "Ali 'Imran",
        arName: "آل عمران",
        type: "MEDINAN",
        verses: 200,
      ),
      SurahModel(
        id: 4,
        enName: "An-Nisa",
        arName: "النساء",
        type: "MEDINAN",
        verses: 176,
      ),
      SurahModel(
        id: 5,
        enName: "Al-Ma'idah",
        arName: "المائدة",
        type: "MEDINAN",
        verses: 120,
      ),
    ];
  }
}
