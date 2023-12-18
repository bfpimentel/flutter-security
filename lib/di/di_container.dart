import 'package:security/security_client.dart';

class DIContainer {
  static DIContainer _instance = throw _DIContainerNotInitializedException();

  static DIContainer get instance => _instance;

  // Components
  final SecurityClient globalSecurityClient;

  DIContainer._({required this.globalSecurityClient});

  static Future<bool> init() async {
    try {
      _instance;
      return true;
    } on _DIContainerNotInitializedException {
      _instance = DIContainer._(
        globalSecurityClient: await SecurityClient.create(
          "global",
          const String.fromEnvironment("GLOBAL_SECURITY_CLIENT_PASSWORD"),
        ),
      );
      return true;
    }
  }
}

class _DIContainerNotInitializedException implements Exception {
  final String message;

  _DIContainerNotInitializedException()
      : message = "DI Container has not been initialized yet. Use DIContainer.init() before.";

  @override
  String toString() {
    return 'DIContainerNotInitializedException: $message';
  }
}
