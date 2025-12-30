import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';

abstract class PracticeRepo {
  Future<List<CustomPractice>> getAllPractices();
  Future<CustomPractice?> getPracticeById(String id);
  Future<void> savePractice(CustomPractice practice);
  Future<void> deletePractice(String id);
  Future<void> updatePractice(CustomPractice practice);
}
