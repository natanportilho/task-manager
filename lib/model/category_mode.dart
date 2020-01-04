class CategoryModel {
  String id;
  String name;
  String imageUrl;

  CategoryModel(this.name, this.imageUrl);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  CategoryModel.fromList(List<dynamic> categoryInfo) {
    this.id = categoryInfo[0].toString();
    this.name = categoryInfo[2];
    this.imageUrl = categoryInfo[2];
  }
}
