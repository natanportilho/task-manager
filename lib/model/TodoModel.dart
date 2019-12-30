class TodoModel {
  String category;
  String name;
  String description;
  bool done;

  TodoModel(String category, String name, String description,
      {bool done: false}) {
    this.done = done;
    this.category = category;
    this.name = name;
    this.description = description;
  }
}
