import 'package:get/get.dart';

class AdhanRecitationsController extends GetxController {
  final RxString selectedAdhan = 'Makkah'.obs;
  final RxString currentlyPlaying = ''.obs;
  final RxBool isPlaying = false.obs;
  final RxDouble progress = 0.4.obs; // Dummy progress

  final List<Map<String, String>> recitations = [
    {
      'name': 'Makkah',
      'subtitle': 'HARAM AL-MAKKI',
      'image': 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?q=80&w=200&auto=format&fit=crop',
    },
    {
      'name': 'Madinah',
      'subtitle': 'HARAM AL-MADANI',
      'image': 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?q=80&w=200&auto=format&fit=crop',
    },
    {
      'name': 'Al-Aqsa',
      'subtitle': 'QUDS',
      'image': 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?q=80&w=200&auto=format&fit=crop',
    },
    {
      'name': 'Egypt',
      'subtitle': 'AL-AZHAR',
      'image': 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?q=80&w=200&auto=format&fit=crop',
    },
    {
      'name': 'Turkey',
      'subtitle': 'BLUE MOSQUE',
      'image': 'https://images.unsplash.com/photo-1591604129939-f1efa4d9f7fa?q=80&w=200&auto=format&fit=crop',
    },
  ];

  void selectAdhan(String name) {
    selectedAdhan.value = name;
  }

  void togglePlayback(String name) {
    if (currentlyPlaying.value == name) {
      isPlaying.value = !isPlaying.value;
    } else {
      currentlyPlaying.value = name;
      isPlaying.value = true;
    }
  }
}
