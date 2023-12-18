import 'package:flutter/material.dart';
import 'package:flutter_security/di/di_container.dart';
import 'package:flutter_security/screens/home_screen.dart';

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
      home: FutureBuilder<void>(
        future: DIContainer.init(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
