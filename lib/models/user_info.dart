class UserInfo {
  final String username;
  final String name;
  final String age;

  UserInfo({required this.username, required this.name, required this.age});

  UserInfo.fromJson(final Map<String, dynamic> json)
      : username = json["username"]!,
        name = json["name"]!,
        age = json["age"]!;

  Map<String, String> toJson() => {
        "username": username,
        "name": name,
        "age": age,
      };
}
