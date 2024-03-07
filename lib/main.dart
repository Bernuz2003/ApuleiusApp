import 'package:flutter/material.dart';
import 'helper/db_helper.dart';
import 'screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeData();

  runApp(MyApp());
}

Future<void> initializeData() async {
  await DatabaseHelper.instance.getTabella(); // Carica la lista iniziale
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
