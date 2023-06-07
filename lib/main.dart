import 'package:flutter/material.dart';

import 'database/database.dart';

void main() async {
  
 WidgetsFlutterBinding.ensureInitialized(); // Asegurar la inicialización del framework de Flutter

  final databaseHelper = DatabaseHelper();

  try {
    final database = await databaseHelper.initDatabase();
    runApp(const MyApp());
    // Resto de tu código
  } catch (e) {
    
  }



  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}