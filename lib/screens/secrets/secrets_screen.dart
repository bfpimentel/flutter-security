import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_security/di/di_container.dart';
import 'package:flutter_security/models/secret.dart';
import 'package:flutter_security/screens/add_secret/add_secret_screen.dart';
import 'package:flutter_security/screens/secrets/secrets_action.dart';
import 'package:flutter_security/screens/secrets/secrets_state.dart';
import 'package:redux/redux.dart';
import 'package:security/security_client.dart';

class SecretsScreen extends StatefulWidget {
  final String username;
  final SecurityClient userSecurityClient;

  const SecretsScreen({
    super.key,
    required this.username,
    required this.userSecurityClient,
  });

  @override
  State<SecretsScreen> createState() => _SecretsScreenState();
}

class _SecretsViewModel {
  final SecretsState state;
  final Function(SecretsAction) dispatch;

  _SecretsViewModel._({
    required this.state,
    required this.dispatch,
  });

  factory _SecretsViewModel.fromStore(final Store<SecretsState> store) {
    return _SecretsViewModel._(state: store.state, dispatch: store.dispatch);
  }
}

class _SecretsScreenState extends State<SecretsScreen> {
  addSecret(final BuildContext context, final Function() refresh) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSecretScreen(userSecurityClient: widget.userSecurityClient)),
    ).then((_) => refresh());
  }

  @override
  Widget build(final BuildContext context) {
    return StoreProvider(
      store: DIContainer.instance.provideSecretsStore(widget.userSecurityClient),
      child: StoreConnector<SecretsState, _SecretsViewModel>(
        converter: _SecretsViewModel.fromStore,
        onInit: (store) => store.dispatch(const SecretsActionLoad()),
        builder: (final BuildContext context, final _SecretsViewModel viewModel) {
          final secrets = viewModel.state.secrets;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text("Secrets for ${widget.username}"),
            ),
            body: ListView.builder(
              itemCount: secrets.length,
              itemBuilder: (context, index) {
                final Secret user = secrets[index];
                return secretItem(context, user);
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => addSecret(context, () => viewModel.dispatch(const SecretsActionLoad())),
              tooltip: "Add",
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget secretItem(final BuildContext context, final Secret secret) {
    return InkWell(
      onTap: () => print(secret.key),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Name: ${secret.key}",
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),
            ),
            Text(
              "Value: ${secret.value}",
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
