class DeleteId {
  int deleteId;
  DeleteId({this.deleteId});
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = deleteId;
    return map;
  }
}
