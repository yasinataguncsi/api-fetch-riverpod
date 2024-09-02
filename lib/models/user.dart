class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  User.fromJson(Map<String, dynamic> data) {
    id = data["id"];
    email = data["email"];
    firstName = data["first_name"];
    lastName = data["last_name"];
    avatar = data["avatar"];
  }
}
