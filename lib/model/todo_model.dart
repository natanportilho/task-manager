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
      'done': done == true ? 1 : 0
    };
  }

  TodoModel.fromList(List<dynamic> todoInfo) {
    this.id = todoInfo[0].toString();
    this.category = todoInfo[1];
    this.name = todoInfo[2];
    this.description = todoInfo[3];
    this.done = todoInfo[4] == 1 ? true : false;
  }
}
