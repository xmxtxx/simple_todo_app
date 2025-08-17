class Todo {
  String id;
  String title;
  String description;
  bool completed;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      this.completed = false});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'] ?? false,
    );
  }
}
