import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_security/di/di_container.dart';
import 'package:flutter_security/screens/login/login_action.dart';
import 'package:flutter_security/screens/login/login_state.dart';
import 'package:redux/redux.dart';

import '../secrets_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginViewModel {
  final LoginState state;
  final Function(LoginAction) dispatch;

  _LoginViewModel._({
    required this.state,
    required this.dispatch,
  });

  factory _LoginViewModel.fromStore(final Store<LoginState> store) {
    return _LoginViewModel._(state: store.state, dispatch: store.dispatch);
  }
}

class _LoginScreenState extends State<LoginScreen> {
  Middleware<LoginState> provideViewSideEffects(final BuildContext context) {
    return (final Store<LoginState> store, action, next) {
      if (action is LoginActionNavigateToSecrets) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SecretsScreen(
              username: action.username,
              userSecurityClient: action.userSecurityClient,
            ),
          ),
        );
        return;
      }

      if (action is LoginActionSetPasswordIsInvalid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid password for user ${action.username}.")),
        );
        return;
      }

      next(action);
    };
  }

  @override
  Widget build(final BuildContext context) {
    return StoreProvider(
      store: DIContainer.instance.provideLoginStore(provideViewSideEffects(context)),
      child: StoreConnector<LoginState, _LoginViewModel>(
        converter: _LoginViewModel.fromStore,
        distinct: false,
        builder: (final BuildContext context, final _LoginViewModel viewModel) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text("Login"),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
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
                    onChanged: (value) => viewModel.dispatch(LoginActionSetUsername(value)),
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
                    onChanged: (value) => viewModel.dispatch(LoginActionSetPassword(value)),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: viewModel.state.isSubmitEnabled ? () => viewModel.dispatch(const LoginActionSubmit()) : null,
              backgroundColor: viewModel.state.isSubmitEnabled ? Colors.redAccent : Colors.grey,
              tooltip: "Submit",
              child: const Icon(Icons.arrow_right_alt_rounded),
            ),
          );
        },
      ),
    );
  }
}
