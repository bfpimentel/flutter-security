import 'package:flutter_security/models/secret.dart';
import 'package:meta/meta.dart';

@immutable
class SecretsState {
  final List<Secret> secrets;

  const SecretsState({required this.secrets});

  factory SecretsState.initialState() => const SecretsState(secrets: []);

  SecretsState copyWith({final List<Secret>? secrets}) {
    return SecretsState(secrets: secrets ?? this.secrets);
  }
}
