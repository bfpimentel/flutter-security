import "package:meta/meta.dart";

@immutable
class LoginState {
  final String username;
  final String password;
  final bool isSubmitEnabled;
  final bool isPasswordInvalid;

  const LoginState({
    required this.username,
    required this.password,
    required this.isSubmitEnabled,
    required this.isPasswordInvalid,
  });

  factory LoginState.initialState() => const LoginState(
        username: "",
        password: "",
        isSubmitEnabled: false,
        isPasswordInvalid: false,
      );

  LoginState copyWith({
    final String? username,
    final String? password,
    final bool? isSubmitEnabled,
    final bool? isPasswordInvalid,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isSubmitEnabled: isSubmitEnabled ?? this.isSubmitEnabled,
      isPasswordInvalid: isPasswordInvalid ?? this.isPasswordInvalid,
    );
  }
}
