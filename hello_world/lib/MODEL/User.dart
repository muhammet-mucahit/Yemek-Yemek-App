class User {
  final String name;
  final String mail;
  String password;

  User(this.name, this.mail, this.password);

  User.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        mail = json["mail"],
        password = json["password"];

  Map<String, String> toJson() => {
        "name": name,
        "mail": mail,
        "password": password,
      };
}
