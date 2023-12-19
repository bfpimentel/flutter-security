import 'package:meta/meta.dart';

@immutable
class AddSecretState {
  final String name;
  final String value;
  final bool isSubmitEnabled;

  const AddSecretState({
    required this.name,
    required this.value,
    required this.isSubmitEnabled,
  });

  factory AddSecretState.initialState() => const AddSecretState(
        name: "",
        value: "",
        isSubmitEnabled: false,
      );

  AddSecretState copyWith({
    final String? name,
    final String? value,
    final bool? isSubmitEnabled,
    final bool? isPasswordInvalid,
  }) {
    return AddSecretState(
      name: name ?? this.name,
      value: value ?? this.value,
      isSubmitEnabled: isSubmitEnabled ?? this.isSubmitEnabled,
    );
  }
}
