import 'package:flutter_security/screens/add_secret/add_secret_action.dart';
import 'package:flutter_security/screens/add_secret/add_secret_state.dart';
import 'package:redux/redux.dart';
import 'package:security/security_client.dart';

class AddSecretSideEffects extends MiddlewareClass<AddSecretState> {
  final SecurityClient userSecurityClient;

  AddSecretSideEffects({required this.userSecurityClient});

  @override
  call(final Store<AddSecretState> store, final action, final next) async {
    if (action is AddSecretActionSubmit) {
      await userSecurityClient.add(store.state.name, store.state.value);
      next(const AddSecretActionNavigateBack());
      return;
    }

    next(action);
  }
}
