import 'package:flutter/material.dart';
import 'package:flutter_security/models/user_info.dart';
import 'package:security/security_client.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key})

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  SecurityClient? _securityClient;

  UserInfo? userInfo;

  @override
  Widget build(final BuildContext context) {
    return Column(


    );
  }
}
