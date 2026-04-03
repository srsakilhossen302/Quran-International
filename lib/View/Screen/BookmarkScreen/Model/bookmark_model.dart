class BookmarkAyah {
  final int id;
  final String surahName;
  final String verseInfo;
  final String arabicText;
  final String englishTranslation;

  BookmarkAyah({
    required this.id,
    required this.surahName,
    required this.verseInfo,
    required this.arabicText,
    required this.englishTranslation,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'surahName': surahName,
      'verseInfo': verseInfo,
      'arabicText': arabicText,
      'englishTranslation': englishTranslation,
    };
  }

  factory BookmarkAyah.fromMap(Map<String, dynamic> map) {
    return BookmarkAyah(
      id: map['id'],
      surahName: map['surahName'] ?? '',
      verseInfo: map['verseInfo'] ?? '',
      arabicText: map['arabicText'] ?? '',
      englishTranslation: map['englishTranslation'] ?? '',
    );
  }
}
