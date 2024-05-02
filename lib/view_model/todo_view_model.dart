sealed class ToDoViewModel {}

class LoadingToDoViewModel extends ToDoViewModel {}

class LoadedToDoViewModel extends ToDoViewModel {
  final String logoImagePath;

  LoadedToDoViewModel({required this.logoImagePath});
}
