import 'package:flutter/cupertino.dart';
import 'package:flutter_security/models/secret.dart';

@immutable
abstract class SecretsAction {
  const SecretsAction._();
}

@immutable
class SecretsActionLoad extends SecretsAction {
  const SecretsActionLoad() : super._();
}

@immutable
class SecretsActionSetSecrets extends SecretsAction {
  final List<Secret> secrets;

  const SecretsActionSetSecrets(this.secrets) : super._();
}
