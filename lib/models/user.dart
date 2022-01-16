class User {
  String name;

  User({this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['title'],
    );
  }
}
