sealed class ToDoViewModel {}

class LoadingToDoViewModel extends ToDoViewModel {}

class LoadedToDoViewModel extends ToDoViewModel {
  final String addTodo;
  final String editTodo;
  final String enterTodoTitle;
  final String enterTodoDescription;
  final String cancel;
  final String save;
  final String delete;
  final String complete;
  final String taskListTitle;

  LoadedToDoViewModel({
    required this.addTodo,
    required this.editTodo,
    required this.enterTodoTitle,
    required this.enterTodoDescription,
    required this.cancel,
    required this.save,
    required this.delete,
    required this.complete,
    required this.taskListTitle,
  });
}
