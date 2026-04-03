import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:quran_international/service/connectivity_service.dart';
import 'package:quran_international/service/database_helper.dart';
import '../Model/bookmark_model.dart';

class BookmarkController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<BookmarkAyah> bookmarks = <BookmarkAyah>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  // Predefined Static Data (Fallback & Initial View)
  final List<BookmarkAyah> _staticBookmarks = [
    BookmarkAyah(
      id: 1,
      surahName: "Al-Baqarah",
      verseInfo: "Verse 255 (Ayat al-Kursi)",
      arabicText: "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ...",
      englishTranslation: "“Allah! There is no god but He, the Living, the Ever-Sustaining...”",
    ),
    BookmarkAyah(
      id: 2,
      surahName: "Al-Fatihah",
      verseInfo: "Verse 1",
      arabicText: "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
      englishTranslation: "“In the name of Allah, the Entirely Merciful, the Especially Merciful.”",
    ),
    BookmarkAyah(
      id: 3,
      surahName: "Ash-Sharh",
      verseInfo: "Verse 5-6",
      arabicText: "فَإِنَّ مَعَ الْعُسْرِ يُسْرًا • إِنَّ مَعَ الْعُسْرِ يُسْرًا",
      englishTranslation: "“For indeed, with hardship [will be] ease. Indeed, with hardship [will be] ease.”",
    ),
  ];

  Future<void> _initializeData() async {
    try {
      // 1. Try to load from database first
      final dbBookmarks = await DatabaseHelper.instance.getBookmarks();
      if (dbBookmarks.isNotEmpty) {
        bookmarks.assignAll(dbBookmarks.map((map) => BookmarkAyah.fromMap(map)).toList());
        isLoading.value = false;
      } else {
        // 2. If DB is empty, use static data and trigger background refresh
        bookmarks.assignAll(_staticBookmarks);
        await refreshData();
      }
    } catch (e) {
      // Fallback
      bookmarks.assignAll(_staticBookmarks);
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
      // Simulation of Delay
      await Future.delayed(const Duration(seconds: 2));
      
      final List<BookmarkAyah> latestData = _staticBookmarks; 

      // Save to database
      for (var bookmark in latestData) {
        await DatabaseHelper.instance.insertBookmark(bookmark.toMap());
      }

      bookmarks.assignAll(latestData);
    } catch (e) {
      // Keep existing data on error
    } finally {
      isLoading.value = false;
    }
  }
}
