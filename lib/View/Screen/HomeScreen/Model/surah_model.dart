class SurahModel {
  final int id;
  final String enName;
  final String arName;
  final String type;
  final int verses;

  SurahModel({
    required this.id,
    required this.enName,
    required this.arName,
    required this.type,
    required this.verses,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'enName': enName,
      'arName': arName,
      'type': type,
      'verses': verses,
    };
  }

  factory SurahModel.fromMap(Map<String, dynamic> map) {
    return SurahModel(
      id: map['id'],
      enName: map['enName'] ?? '',
      arName: map['arName'] ?? '',
      type: map['type'] ?? '',
      verses: map['verses'] ?? 0,
    );
  }
}
