import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:quran_international/service/connectivity_service.dart';
import 'package:quran_international/service/database_helper.dart';

class HighlightModel {
  final int id;
  final String surahName;
  final String reference;
  final String date;
  final String text;
  final Color highlightColor;
  final String colorName;

  HighlightModel({
    required this.id,
    required this.surahName,
    required this.reference,
    required this.date,
    required this.text,
    required this.highlightColor,
    required this.colorName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'surahName': surahName,
      'reference': reference,
      'date': date,
      'text': text,
      'colorValue': highlightColor.value,
      'colorName': colorName,
    };
  }

  factory HighlightModel.fromMap(Map<String, dynamic> map) {
    return HighlightModel(
      id: map['id'],
      surahName: map['surahName'] ?? '',
      reference: map['reference'] ?? '',
      date: map['date'] ?? '',
      text: map['text'] ?? '',
      highlightColor: Color(map['colorValue'] ?? 0xFFFFD700),
      colorName: map['colorName'] ?? 'Yellow',
    );
  }
}

class HighlightController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxString selectedFilter = "All".obs;
  final RxList<HighlightModel> highlights = <HighlightModel>[].obs;

  // Filtered List Getter
  List<HighlightModel> get filteredHighlights {
    if (selectedFilter.value == "All") {
      return highlights;
    } else {
      // Precise case-sensitive comparison
      return highlights.where((h) => h.colorName == selectedFilter.value).toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  final List<HighlightModel> _staticHighlights = [
    HighlightModel(
      id: 1,
      surahName: "Al-Baqarah",
      reference: "2:255",
      date: "Oct 12, 2023",
      text: "\"Allah! There is no god but He, the Living, the Self-subsisting, Eternal. No slumber can seize Him nor sleep...\"",
      highlightColor: const Color(0xFFFFD700), // Yellow
      colorName: "Yellow",
    ),
    HighlightModel(
      id: 2,
      surahName: "Al-Imran",
      reference: "3:103",
      date: "Oct 10, 2023",
      text: "\"And hold fast, all together, by the rope which Allah (stretches out for you), and be not divided among yourselves...\"",
      highlightColor: const Color(0xFF22C55E), // Green
      colorName: "Green",
    ),
    HighlightModel(
      id: 3,
      surahName: "Ad-Duha",
      reference: "93:3",
      date: "Oct 05, 2023",
      text: "\"Your Lord has not forsaken you, [O Muhammad], nor has He detested [you].\"",
      highlightColor: const Color(0xFFFF5252), // Red
      colorName: "Red",
    ),
    HighlightModel(
      id: 4,
      surahName: "Al-Fatihah",
      reference: "1:6",
      date: "Sep 28, 2023",
      text: "\"Guide us to the straight path.\"",
      highlightColor: const Color(0xFF00B0FF), // Blue
      colorName: "Blue",
    ),
  ];

  Future<void> _initializeData() async {
    try {
      final dbHighlights = await DatabaseHelper.instance.getHighlights();
      
      // If we have data but colorName is missing (legacy data) or list is empty
      if (dbHighlights.isNotEmpty && dbHighlights.first.containsKey('colorName') && dbHighlights.first['colorName'] != null) {
        highlights.assignAll(dbHighlights.map((map) => HighlightModel.fromMap(map)).toList());
        isLoading.value = false;
      } else {
        // Force refresh table/data to ensure colorName is present
        highlights.assignAll(_staticHighlights);
        for (var item in _staticHighlights) {
          await DatabaseHelper.instance.insertHighlight(item.toMap());
        }
        isLoading.value = false;
      }
    } catch (e) {
      highlights.assignAll(_staticHighlights);
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    final bool hasInternet = await Get.find<ConnectivityService>().isConnected();
    if (!hasInternet) {
      Get.find<ConnectivityService>().updateConnectionStatus([ConnectivityResult.none]);
      return;
    }

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      final List<HighlightModel> latestData = _staticHighlights; 

      for (var item in latestData) {
        await DatabaseHelper.instance.insertHighlight(item.toMap());
      }

      highlights.assignAll(latestData);
    } catch (e) {
      // Keep existing data
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }
}
