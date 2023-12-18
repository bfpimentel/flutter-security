import 'package:flutter_security/screens/login/login_reducer.dart';
import 'package:flutter_security/screens/login/login_side_effects.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:security/security_client.dart';

import '../screens/login/login_state.dart';

class DIContainer {
  // constants
  static const String _globalSecurityClientPasswordEnvVariable = "GLOBAL_SECURITY_CLIENT_PASSWORD";

  // instance
  static DIContainer _instance = throw _DIContainerNotInitializedException(
      message: "DIContainer has not been initialized yet. Use DIContainer.init() before.");

  static DIContainer get instance => _instance;

  // components
  final SecurityClient globalSecurityClient;

  DIContainer._({required this.globalSecurityClient});

  static Future<bool> init() async {
    // if (!const bool.hasEnvironment(_globalSecurityClientPasswordEnvVariable)) {
    //   throw _DIContainerNotInitializedException(
    //       message: "Environment variable called $_globalSecurityClientPasswordEnvVariable has not been found.");
    // }

    const String globalClientPassword = String.fromEnvironment(_globalSecurityClientPasswordEnvVariable);

    try {
      _instance;
      return true;
    } on _DIContainerNotInitializedException {
      _instance = DIContainer._(globalSecurityClient: await SecurityClient.create("global", globalClientPassword));
      return true;
    }
  }

  Store<LoginState> provideLoginStore(final Middleware<LoginState> viewSideEffects) {
    return Store<LoginState>(
      LoginReducer(),
      middleware: [thunkMiddleware, LoginSideEffects(), viewSideEffects],
      initialState: LoginState.initialState(),
    );
  }
}

class _DIContainerNotInitializedException implements Exception {
  final String message;

  _DIContainerNotInitializedException({required this.message});

  @override
  String toString() {
    return 'DIContainerNotInitializedException: $message';
  }
}
