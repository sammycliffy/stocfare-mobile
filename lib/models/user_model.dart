class User {
  String branchId;
  String firebaseId;
  String fullname;
  String phone;
  String email;

  User({this.branchId, this.fullname, this.phone, this.email, this.firebaseId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      branchId: json['business'][0]['branch'][0]['id'],
      firebaseId: json['business'][0]['branch'][0]['firebase_inventory_id'],
      fullname: json['user']['full_name'] ?? '',
      email: json['user']['email'] ?? '',
      phone: json['user']['phone'],
    );
  }
}
