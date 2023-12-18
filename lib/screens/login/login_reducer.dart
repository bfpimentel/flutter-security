import 'package:flutter_security/screens/login/login_action.dart';
import 'package:flutter_security/screens/login/login_state.dart';
import 'package:redux/redux.dart';

class LoginReducer extends ReducerClass<LoginState> {
  @override
  LoginState call(final LoginState state, final action) {
    if (action is LoginActionSetUsername) {
      return state.copyWith(
        username: action.username,
        isSubmitEnabled: _areInputsValid(username: action.username, password: state.password),
        isPasswordInvalid: false,
      );
    }

    if (action is LoginActionSetPassword) {
      return state.copyWith(
        password: action.password,
        isSubmitEnabled: _areInputsValid(username: state.username, password: action.password),
        isPasswordInvalid: false,
      );
    }

    return state;
  }

  bool _areInputsValid({
    required final String username,
    required final String password,
  }) =>
      username.isNotEmpty && password.isNotEmpty;
}
