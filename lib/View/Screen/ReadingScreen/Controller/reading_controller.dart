import 'package:get/get.dart';
import '../../HomeScreen/Model/surah_model.dart';

class ReadingController extends GetxController {
  final SurahModel surah = Get.arguments as SurahModel;
  
  // Reading progress (dummy values for now)
  final RxInt currentAyah = 15.obs;
  
  // Dummy Ayahs list
  final RxList<Map<String, String>> ayahs = <Map<String, String>>[
    {
      "number": "1",
      "arabic": "ٱلْحَمْدُ لِلَّهِ ٱلَّذِىٓ أَنزَلَ عَلَىٰ عَبْدِهِ ٱلْكِتَٰبَ وَلَمْ يَجْعَل لَّهُۥ عِوَجَا",
      "english": "[All] praise is [due] to Allah, who has sent down upon His Servant the Book and has not made therein any deviance."
    },
    {
      "number": "2",
      "arabic": "قَيِّمًا لِّيُنذِرَ بَأْسًا شَدِيدًا مِّن لَّدُنْهُ وَيُبَشِّرَ ٱلْمُؤْمِنِينَ ٱلَّذِينَ يَعْمَلُونَ ٱلصَّٰلِحَٰتِ أَنَّ لَهُمْ أَجْرًا حَسَنًا",
      "english": "[He has made it] straight, to warn of severe punishment from Him and to give good tidings to the believers who do righteous deeds that they will have a good reward."
    },
    {
      "number": "3",
      "arabic": "مَّٰكِثِينَ فِيهِ أَبَدًا",
      "english": "In which they will remain forever."
    }
  ].obs;

  // Highlighter state
  final RxInt selectedHighlighterIndex = (-1).obs;

  void toggleHighlighter(int index) {
    if (selectedHighlighterIndex.value == index) {
      selectedHighlighterIndex.value = -1;
    } else {
      selectedHighlighterIndex.value = index;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // In a real app, you would fetch ayahs from API/DB here
  }
}
