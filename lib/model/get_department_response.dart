
class GetDepartmentResponse {
  String? deptCatId;
  String? depCatName;
  String? status;
  dynamic popupMessage;

  GetDepartmentResponse({this.deptCatId, this.depCatName, this.status, this.popupMessage});

  GetDepartmentResponse.fromJson(Map<String, dynamic> json) {
    if(json["dept_cat_id"] is String) {
      deptCatId = json["dept_cat_id"];
    }
    if(json["dep_cat_name"] is String) {
      depCatName = json["dep_cat_name"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    popupMessage = json["POPUP_MESSAGE"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["dept_cat_id"] = deptCatId;
    data["dep_cat_name"] = depCatName;
    data["status"] = status;
    data["POPUP_MESSAGE"] = popupMessage;
    return data;
  }
}