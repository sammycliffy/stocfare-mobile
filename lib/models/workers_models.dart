class WorkersList {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  WorkersList({this.count, this.next, this.previous, this.results});

  WorkersList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String id;
  String branchName;
  String branchId;
  String branchAddress;
  String email;
  String userId;
  String fullName;
  String phoneNumber;
  bool userStatus;
  List<String> roles;

  Results(
      {this.id,
      this.branchName,
      this.branchId,
      this.branchAddress,
      this.email,
      this.userId,
      this.fullName,
      this.phoneNumber,
      this.userStatus,
      this.roles});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branch_name'];
    branchId = json['branch_id'];
    branchAddress = json['branch_address'];
    email = json['email'];
    userId = json['user_id'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    userStatus = json['user_status'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_name'] = this.branchName;
    data['branch_id'] = this.branchId;
    data['branch_address'] = this.branchAddress;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    data['user_status'] = this.userStatus;
    data['roles'] = this.roles;
    return data;
  }
}
