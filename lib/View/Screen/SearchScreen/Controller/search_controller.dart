import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString selectedTag = "".obs;

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

  void onTagSelected(String tag) {
    selectedTag.value = tag;
    searchController.text = tag;
  }

  void clearRecentSearches() {
    recentSearches.clear();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
