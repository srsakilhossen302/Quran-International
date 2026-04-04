import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString selectedTag = "".obs;
  final RxString searchQuery = "".obs;

  final RxList<String> quickSearchItems = [
    "Guidance",
    "Forgiveness",
    "Faith",
    "Patience",
    "Charity",
    "History"
  ].obs;

  final RxList<String> recentSearches = [
    "Mercy",
    "Surah Ar-Rahman",
    "Patience",
    "Ayatul Kursi"
  ].obs;

  final RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[
    {
      "surah": "Al-Fatihah",
      "surahNo": 1,
      "ayahNo": 1,
      "arabic": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
      "translation": "In the name of Allah, the Entirely Mercy, the Especially Merciful.",
      "isBookmarked": false,
    },
    {
      "surah": "Al-A'raf",
      "surahNo": 7,
      "ayahNo": 156,
      "arabic": "وَرَحْمَتِي وَسِعَتْ كُلَّ شَيْءٍ",
      "translation": "...but My mercy encompasses all things.",
      "isBookmarked": false,
    },
    {
      "surah": "Az-Zumar",
      "surahNo": 39,
      "ayahNo": 53,
      "arabic": "لَا تَقْنَطُوا مِنْ رَحْمَةِ اللَّهِ",
      "translation": "Do not despair of the mercy of Allah. Indeed, Allah forgives all sins...",
      "isBookmarked": true,
    },
    {
      "surah": "Al-An'am",
      "surahNo": 6,
      "ayahNo": 12,
      "arabic": "كَتَبَ عَلَىٰ نَفْسِهِ الرَّحْمَةَ",
      "translation": "He has prescribed for Himself mercy.",
      "isBookmarked": false,
    },
  ].obs;

  final RxBool isLoading = false.obs;
  Worker? _debounceWorker;

  @override
  void onInit() {
    super.onInit();
    // Check for initial query from navigation arguments
    final String? initialQuery = Get.arguments?['query'];
    if (initialQuery != null && initialQuery.isNotEmpty) {
      searchController.text = initialQuery;
      searchQuery.value = initialQuery;
    }

    // Debounce search query to simulate network request and show shimmer
    _debounceWorker = debounce(
      searchQuery,
      (query) {
        if (query.isNotEmpty) {
          _simulateLoading();
        }
      },
      time: const Duration(milliseconds: 500),
    );

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
  }

  void _simulateLoading() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // 1 second for better feel
    isLoading.value = false;
  }

  void onTagSelected(String tag) {
    selectedTag.value = tag;
    searchController.text = tag;
    searchQuery.value = tag;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = "";
    selectedTag.value = "";
  }

  void clearRecentSearches() {
    recentSearches.clear();
  }

  void toggleBookmark(int index) {
    searchResults[index]['isBookmarked'] = !searchResults[index]['isBookmarked'];
    searchResults.refresh();
  }

  @override
  void onClose() {
    _debounceWorker?.dispose();
    searchController.dispose();
    super.onClose();
  }
}
