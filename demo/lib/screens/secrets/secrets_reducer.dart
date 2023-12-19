import 'package:flutter_security/screens/secrets/secrets_action.dart';
import 'package:flutter_security/screens/secrets/secrets_state.dart';
import 'package:redux/redux.dart';

class SecretsReducer extends ReducerClass<SecretsState> {
  @override
  SecretsState call(final SecretsState state, final action) {
    if (action is SecretsActionSetSecrets) {
      return state.copyWith(secrets: action.secrets);
    }

    return state;
  }
}
