import 'package:get/get.dart';

class SearchController extends GetxController {
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

  void clearRecentSearches() {
    recentSearches.clear();
  }
}
