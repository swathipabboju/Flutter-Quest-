
class GetDepartmentRequest {
  String? userid;
  String? password;
  String? typeId;

  GetDepartmentRequest({this.userid, this.password, this.typeId});

  GetDepartmentRequest.fromJson(Map<String, dynamic> json) {
    if(json["userid"] is String) {
      userid = json["userid"];
    }
    if(json["password"] is String) {
      password = json["password"];
    }
    if(json["Type_id"] is String) {
      typeId = json["Type_id"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userid"] = userid;
    data["password"] = password;
    data["Type_id"] = typeId;
    return data;
  }
}