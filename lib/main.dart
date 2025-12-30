import 'package:flutter/material.dart';
import 'package:yoga_coach/app/app.dart';
import 'package:yoga_coach/core/di/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const YogaCoachApp());
}
