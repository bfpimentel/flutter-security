import 'package:flutter_security/screens/login/login_action.dart';
import 'package:flutter_security/screens/login/login_state.dart';
import 'package:redux/redux.dart';
import 'package:security_client/security_client.dart';

class LoginSideEffects extends MiddlewareClass<LoginState> {
  @override
  call(final Store<LoginState> store, final action, final NextDispatcher next) async {
    if (action is LoginActionSubmit) {
      try {
        final SecurityClient userSecurityClient = await SecurityClient.create(
          store.state.username,
          store.state.password,
        );

        next(
          LoginActionNavigateToSecrets(
            userSecurityClient: userSecurityClient,
            username: store.state.username,
          ),
        );
      } catch (exception) {
        next(LoginActionSetPasswordIsInvalid(store.state.username));
      }
      return;
    }

    next(action);
  }
}
