import 'package:flutter/material.dart';
import 'package:smart_spent_story/app.dart';
import 'package:smart_spent_story/core/dependency_injection/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const SmartSpentApp());
}
