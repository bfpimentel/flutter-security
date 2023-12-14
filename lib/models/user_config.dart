class UserConfig {
  final String username;
  final String password;

  UserConfig({required this.username, required this.password});

  UserConfig.fromJson(final Map<String, dynamic> json)
      : username = json["username"]!,
        password = json["password"]!;

  Map<String, String> toJson() => {
        "username": username,
        "password": password,
      };
}
