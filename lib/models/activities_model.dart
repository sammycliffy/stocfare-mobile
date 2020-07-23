class ActivitiesModel {
  List<ActivitiesModel> activities;

  ActivitiesModel({this.activities});

  ActivitiesModel.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = new List<ActivitiesModel>();
      json['activities'].forEach((v) {
        activities.add(new ActivitiesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activities != null) {
      data['activities'] = this.activities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
