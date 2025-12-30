import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';

class CustomPracticeStorage {
  static final CustomPracticeStorage _instance =
      CustomPracticeStorage._internal();

  final List<CustomPractice> _customPractices = [];

  CustomPracticeStorage._internal();

  factory CustomPracticeStorage() {
    return _instance;
  }

  List<CustomPractice> get customPractices =>
      List.unmodifiable(_customPractices);

  void addPractice(CustomPractice practice) {
    _customPractices.add(practice);
  }

  void removePractice(String id) {
    _customPractices.removeWhere((p) => p.id == id);
  }

  CustomPractice? getPractice(String id) {
    try {
      return _customPractices.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
