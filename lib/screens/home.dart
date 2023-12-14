import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_security/models/user_config.dart';
import 'package:security/security_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _isInitializedKey = "isInitialized";
  static const String _usersKey = "users";

  SecurityClient? _securityClient;

  List<UserConfig> users = [];

  void _initSecurityClient() async {
    _securityClient = await SecurityClient.create("sopinha", "4322");

    if (await _securityClient?.get(_isInitializedKey) == null) {
      _initUsers();
    }

    final encodedConfigs = await _securityClient?.get(_usersKey);
    if (encodedConfigs != null) {
      final List<dynamic> decodedList = jsonDecode(encodedConfigs);
      final List<UserConfig> mappedList = decodedList.map((e) => UserConfig.fromJson(e)).toList();

      setState(() {
        users = mappedList;
      });
    }
  }

  void _initUsers() async {
    final List<UserConfig> configs = [
      UserConfig(username: "jon", password: "01234"),
      UserConfig(username: "anne", password: "56789"),
    ];

    final encodedConfigs = jsonEncode(configs);

    await _securityClient?.add(_usersKey, encodedConfigs);
    await _securityClient?.add(_isInitializedKey, "1");
  }

  @override
  Widget build(final BuildContext context) {
    if (_securityClient == null) _initSecurityClient();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Users"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final UserConfig user = users[index];
            return userConfigItem(context, user);
          },
        ),
      ),
    );
  }

  Widget userConfigItem(final BuildContext context, final UserConfig userConfig) {
    return InkWell(
      onTap: () => print(userConfig.username),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Username: ${userConfig.username}",
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "Password: ${userConfig.password}",
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
