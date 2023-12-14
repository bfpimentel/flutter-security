import 'package:flutter/material.dart';
import 'package:flutter_security/screens/home.dart';

void main() {
  runApp(const SecurityClientDemoApp());
}

class SecurityClientDemoApp extends StatelessWidget {
  const SecurityClientDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Security Client Demo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
