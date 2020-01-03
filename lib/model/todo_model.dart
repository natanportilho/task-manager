class TodoModel {
  String id;
  String category;
  String name;
  String description;
  bool done;

  TodoModel(String category, String name, String description,
      {bool done: false}) {
    this.id = category.hashCode.toString() + name.hashCode.toString();
    this.done = done;
    this.category = category;
    this.name = name;
    this.description = description;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'description': description,
    };
  }

  TodoModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.done = false;
    this.category = map['category'];
    this.name = map['name'];
    this.description = map['description'];
  }
}
