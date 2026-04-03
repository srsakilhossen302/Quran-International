import 'package:get/get.dart';
import '../Model/bookmark_model.dart';

class BookmarkController extends GetxController {
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Initially load
    refreshData();
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    // No explicit re-loading of list for now, just toggling state
    isLoading.value = false;
  }

  final List<BookmarkAyah> bookmarks = [
    BookmarkAyah(
      id: 1,
      surahName: "Al-Baqarah",
      verseInfo: "Verse 255 (Ayat al-Kursi)",
      arabicText: "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْমٌ...",
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
  ].obs;
}
