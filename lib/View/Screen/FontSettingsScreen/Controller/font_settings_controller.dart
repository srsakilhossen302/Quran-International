import 'package:get/get.dart';

class FontSettingsController extends GetxController {
  final RxString selectedScript = 'Uthmani'.obs;
  final RxDouble arabicFontSize = 22.0.obs;
  final RxDouble translationFontSize = 14.0.obs;

  void setScript(String script) {
    selectedScript.value = script;
  }

  void updateArabicSize(double size) {
    arabicFontSize.value = size;
  }

  void updateTranslationSize(double size) {
    translationFontSize.value = size;
  }

  void reset() {
    selectedScript.value = 'Uthmani';
    arabicFontSize.value = 22.0;
    translationFontSize.value = 14.0;
  }
}
