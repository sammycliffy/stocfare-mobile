class User {
  String branchId;
  String firebaseId;
  String firebaseNotificationId;
  String businessId;
  String fullname;
  String phone;
  String email;
  int userId;

  User(
      {this.branchId,
      this.fullname,
      this.phone,
      this.email,
      this.firebaseId,
      this.userId,
      this.firebaseNotificationId,
      this.businessId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      branchId: json['business'][0]['branch'][0]['id'],
      firebaseId: json['business'][0]['branch'][0]['firebase_inventory_id'],
      firebaseNotificationId: json['business'][0]['branch'][0]
          ['firebase_notification_id'],
      businessId: json['business'][0]["id"],
      fullname: json['user']['full_name'] ?? '',
      email: json['user']['email'] ?? '',
      phone: json['user']['phone'],
      userId: json['user']['user_id'],
    );
  }
}
