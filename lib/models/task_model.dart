class Task {
  int id;
  String category;
  String name;
  String description;
  bool done;

  Task({this.id, this.category, this.name, this.description, this.done});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
    description = json['description'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['name'] = this.name;
    data['description'] = this.description;
    data['done'] = this.done;
    return data;
  }
}
