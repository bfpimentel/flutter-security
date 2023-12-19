import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_security/di/di_container.dart';
import 'package:flutter_security/screens/add_secret/add_secret_action.dart';
import 'package:flutter_security/screens/add_secret/add_secret_state.dart';
import 'package:redux/redux.dart';
import 'package:security_client/security_client.dart';

class AddSecretScreen extends StatefulWidget {
  final SecurityClient userSecurityClient;

  const AddSecretScreen({super.key, required this.userSecurityClient});

  @override
  State<AddSecretScreen> createState() => _AddSecretScreenState();
}

class _AddSecretViewModel {
  final AddSecretState state;
  final Function(AddSecretAction) dispatch;

  _AddSecretViewModel._({required this.state, required this.dispatch});

  factory _AddSecretViewModel.fromStore(final Store<AddSecretState> store) {
    return _AddSecretViewModel._(state: store.state, dispatch: store.dispatch);
  }
}

class _AddSecretScreenState extends State<AddSecretScreen> {
  Middleware<AddSecretState> provideViewEffects(final BuildContext context) {
    return (final Store<AddSecretState> store, final action, final next) {
      if (action is AddSecretActionNavigateBack) {
        Navigator.pop(context);
        return;
      }

      next(action);
    };
  }

  @override
  Widget build(final BuildContext context) {
    return StoreProvider(
      store: DIContainer.instance.provideAddSecretStore(
        viewSideEffects: provideViewEffects(context),
        userSecurityClient: widget.userSecurityClient,
      ),
      child: StoreConnector(
        converter: _AddSecretViewModel.fromStore,
        builder: (final BuildContext context, final _AddSecretViewModel viewModel) {
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
                    onChanged: (name) => viewModel.dispatch(AddSecretActionSetName(name)),
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
                    onChanged: (value) => viewModel.dispatch(AddSecretActionSetValue(value)),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed:
                  viewModel.state.isSubmitEnabled ? () => viewModel.dispatch(const AddSecretActionSubmit()) : null,
              backgroundColor: viewModel.state.isSubmitEnabled ? Colors.redAccent : Colors.grey,
              tooltip: "Submit",
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
