import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app/logic/providers/config_provider.dart';
import 'package:simple_todo_app/view_model/todo_view_model.dart';

mixin TodoViewProvider {
  static final welcomeViewProvider = Provider<ToDoViewModel>((ref) {
    var config = ref.watch(ConfigProvider.configProvider);
    return config.maybeWhen(
        data: (value) =>
            LoadedToDoViewModel(logoImagePath: value.logoImagePath),
        orElse: LoadingToDoViewModel.new);
  });
}
