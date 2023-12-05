import 'dart:io';

import 'package:flutter/material.dart';
import 'package:security/security_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SecurityClient? _securityClient;

  String _value = "";

  void _initSecurityClient() async {
    _securityClient = await SecurityClient.create("bruno", "12345");
  }

  void _setValue() async {
    if (_securityClient != null) {
      await _securityClient!.add("test_key", "bruno");
      String key = await _securityClient!.get("test_key").then((value) => value);
      setState(() { _value = key; });
    }
  }

  @override
  Widget build(BuildContext context) {
    _initSecurityClient();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Value:'),
            Text(
              _value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setValue,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
