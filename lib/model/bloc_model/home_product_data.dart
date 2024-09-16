class ProductDataModel {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  double? price;

  ProductDataModel(
      {this.id, this.name, this.description, this.imageUrl, this.price});

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['image_url'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['price'] = this.price;
    return data;
  }
}
