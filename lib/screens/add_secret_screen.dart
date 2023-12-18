import 'package:flutter/material.dart';
import 'package:flutter_security/di/di_container.dart';
import 'package:flutter_security/models/secret.dart';
import 'package:security/security_client.dart';

class AddSecretScreen extends StatefulWidget {
  final SecurityClient userSecurityClient;

  const AddSecretScreen({super.key, required this.userSecurityClient});

  @override
  State<AddSecretScreen> createState() => _AddSecretScreenState();
}

class _AddSecretScreenState extends State<AddSecretScreen> {

  // data
  String name = "";
  String secret = "";

  // state
  bool isSubmitting = false;
  bool isSubmitEnabled = false;

  List<Secret> users = [];

  setName(final String value) {
    name = value;
    validateInputs();
  }

  setSecret(final String value) {
    secret = value;
    validateInputs();
  }

  validateInputs() {
    final isSubmitEnabled = name.isNotEmpty && secret.isNotEmpty;
    setState(() => this.isSubmitEnabled = isSubmitEnabled);
  }

  submit(final BuildContext context) async {
    await widget.userSecurityClient.add(name, secret);

    // todo
    Navigator.pop(context);
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
              key: const Key("secret"),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Secret Name",
              ),
              onChanged: setName,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0),
            child: TextField(
              key: const Key("value"),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Secret Value",
              ),
              onChanged: setSecret,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isSubmitEnabled ? () => submit(context) : null,
        tooltip: "Submit",
        child: const Icon(Icons.add),
      ),
    );
  }
}
