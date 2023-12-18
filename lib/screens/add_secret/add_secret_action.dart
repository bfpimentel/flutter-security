import 'package:meta/meta.dart';

@immutable
abstract class AddSecretAction {
  const AddSecretAction._();
}

@immutable
class AddSecretActionSetName extends AddSecretAction {
  final String name;

  const AddSecretActionSetName(this.name) : super._();
}

@immutable
class AddSecretActionSetValue extends AddSecretAction {
  final String value;

  const AddSecretActionSetValue(this.value) : super._();
}

@immutable
class AddSecretActionSubmit extends AddSecretAction {
  const AddSecretActionSubmit() : super._();
}

@immutable
class AddSecretActionNavigateBack extends AddSecretAction {
  const AddSecretActionNavigateBack() : super._();
}
