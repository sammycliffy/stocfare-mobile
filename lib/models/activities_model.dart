class ActivitiesModel {
  List<Activities> activities;

  ActivitiesModel({this.activities});

  ActivitiesModel.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = new List<Activities>();
      json['activities'].forEach((v) {
        activities.add(new Activities.fromJson(v));
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

class Activities {
  String description;
  String activityBy;
  String dateCreated;

  Activities({this.description, this.activityBy, this.dateCreated});

  Activities.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    activityBy = json['activity_by'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['activity_by'] = this.activityBy;
    data['date_created'] = this.dateCreated;
    return data;
  }
}
