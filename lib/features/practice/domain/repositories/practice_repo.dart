import 'package:yoga_coach/features/practice/domain/entities/practice.dart';

abstract class PracticeRepo {
  Future<List<Practice>> getAllPractices();
  Future<Practice?> getPracticeById(String id);
  Future<void> savePractice(Practice practice);
  Future<void> deletePractice(String id);
  Future<void> updatePractice(Practice practice);
}
