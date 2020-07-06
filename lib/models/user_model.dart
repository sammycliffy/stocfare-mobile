class User {
  String fullname;
  String phone;
  String email;

  User({this.fullname, this.phone, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullname: json['full_name'] ?? '',
      email: json['email'],
      phone: json['phone'],
    );
  }
}
