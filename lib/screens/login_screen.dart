import 'package:flutter/material.dart';
import 'package:flutter_security/di/di_container.dart';
import 'package:flutter_security/models/secret.dart';
import 'package:flutter_security/screens/secrets_screen.dart';
import 'package:security/security_client.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SecurityClient get securityClient => DIContainer.instance.globalSecurityClient;

  // data
  String username = "";
  String password = "";

  // state
  bool isSubmitting = false;
  bool isSubmitEnabled = false;

  List<Secret> users = [];

  setUsername(final String value) {
    username = value;
    validateInputs();
  }

  setPassword(final String value) {
    password = value;
    validateInputs();
  }

  validateInputs() {
    final isSubmitEnabled = username.isNotEmpty && password.isNotEmpty;
    setState(() => this.isSubmitEnabled = isSubmitEnabled);
  }

  submit(final BuildContext context) async {
    final SecurityClient userSecurityClient = await SecurityClient.create(username, password);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SecretsScreen(
          username: username,
          securityClient: userSecurityClient,
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Users"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
            child: TextField(
              key: const Key("username"),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Username",
              ),
              onChanged: setUsername,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0),
            child: TextField(
              key: const Key("password"),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Password",
              ),
              onChanged: setPassword,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isSubmitEnabled ? () => submit(context) : null,
        tooltip: "Submit",
        child: const Icon(Icons.arrow_right_alt_rounded),
      ),
    );
  }
}
