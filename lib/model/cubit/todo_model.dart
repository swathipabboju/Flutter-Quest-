
class TodoModel {
  String? name;
  String? createdAt;

  TodoModel({this.name, this.createdAt});

  
  TodoModel.fromJson(Map<String, dynamic> json) {
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["createdAt"] = createdAt;
    return _data;
  }
}