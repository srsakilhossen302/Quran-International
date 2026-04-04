import 'package:get/get.dart';

class PrayerTimesController extends GetxController {
  final RxMap<String, bool> prayerStates = {
    'Fajr': true,
    'Dhuhr': true,
    'Asr': true,
    'Maghrib': true,
    'Isha': false,
  }.obs;

  void togglePrayer(String prayer) {
    if (prayerStates.containsKey(prayer)) {
      prayerStates[prayer] = !(prayerStates[prayer] ?? false);
    }
  }

  // Sample static data
  final List<Map<String, dynamic>> prayers = [
    {'name': 'Fajr', 'time': '05:24 AM'},
    {'name': 'Dhuhr', 'time': '12:15 PM'},
    {'name': 'Asr', 'time': '03:42 PM'},
    {'name': 'Maghrib', 'time': '05:38 PM'},
    {'name': 'Isha', 'time': '06:58 PM'},
  ];
}
