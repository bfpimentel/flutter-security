import 'package:flutter_security/models/secret.dart';
import 'package:flutter_security/screens/secrets/secrets_action.dart';
import 'package:flutter_security/screens/secrets/secrets_state.dart';
import 'package:redux/redux.dart';
import 'package:security/security_client.dart';

class SecretsSideEffects extends MiddlewareClass<SecretsState> {
  final SecurityClient userSecurityClient;

  SecretsSideEffects({required this.userSecurityClient});

  @override
  call(final Store<SecretsState> store, final action, final next) async {
    if (action is SecretsActionLoad) {
      final secrets = await getSecrets(currentState: store.state, isRefreshing: false);
      next(SecretsActionSetSecrets(secrets));
      return;
    }

    next(action);
  }

  Future<List<Secret>> getSecrets({
    required final SecretsState currentState,
    required final bool isRefreshing,
  }) async {
    return (await userSecurityClient.getAll())
        .entries
        .map((element) => Secret(key: element.key, value: element.value))
        .toList();
  }
}
