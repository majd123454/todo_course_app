import 'package:course_level_one/boarding.dart';
import 'package:course_level_one/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getIsOpen();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: isOpen ? HomeScreen() : Boarding());
  }
}

Future<void> getIsOpen() async {
  SharedPreferences sh = await SharedPreferences.getInstance();
  isOpen = sh.getBool("boardingComplete") ?? false;
}
