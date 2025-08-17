import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class ConfigDTO {
  static const String _appConfig = 'appConfig';

  final String addTodo;
  final String editTodo;
  final String enterTodoTitle;
  final String enterTodoDescription;
  final String cancel;
  final String save;
  final String delete;
  final String complete;
  final String taskListTitle;

  ConfigDTO({
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

  static Future<ConfigDTO> parse(String language) async {
    final String configString;
    String? configSecretString;

    final languageString = await rootBundle
        .loadString('assets/languages/${language}_properties.json');

    configString = await rootBundle.loadString('assets/config.json');

    final jsonConfig = jsonDecode(configString);
    final jsonLanguage = jsonDecode(languageString);

    if (!jsonConfig.containsKey(_appConfig)) {
      throw Exception('The required config is not found.');
    }

    var languageJson = jsonLanguage;
    var configJson = {}..addAll(languageJson);

    return ConfigDTO(
      addTodo: configJson['addTodo'],
      editTodo: configJson['editTodo'],
      enterTodoTitle: configJson['enterTodoTitle'],
      enterTodoDescription: configJson['enterTodoDescription'],
      cancel: configJson['cancel'],
      save: configJson['save'],
      delete: configJson['delete'],
      complete: configJson['complete'],
      taskListTitle: configJson['taskListTitle'],
    );
  }
}
