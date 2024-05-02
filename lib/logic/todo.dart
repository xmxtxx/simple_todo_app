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
}
