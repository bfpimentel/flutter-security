import 'package:flutter/cupertino.dart';
import 'package:security_client/security_client.dart';

@immutable
abstract class LoginAction {
  const LoginAction._();
}

@immutable
class LoginActionSetUsername extends LoginAction {
  final String username;

  const LoginActionSetUsername(this.username) : super._();
}

@immutable
class LoginActionSetPassword extends LoginAction {
  final String password;

  const LoginActionSetPassword(this.password) : super._();
}

@immutable
class LoginActionSubmit extends LoginAction {
  const LoginActionSubmit() : super._();
}

@immutable
class LoginActionNavigateToSecrets extends LoginAction {
  final SecurityClient userSecurityClient;
  final String username;

  const LoginActionNavigateToSecrets({
    required this.userSecurityClient,
    required this.username,
  }) : super._();
}

@immutable
class LoginActionSetPasswordIsInvalid extends LoginAction {
  final String username;

  const LoginActionSetPasswordIsInvalid(this.username) : super._();
}
