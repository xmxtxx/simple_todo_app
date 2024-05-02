import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app/logic/ConfigDTO.dart';

mixin ConfigProvider {
  static final configProvider = FutureProvider<ConfigDTO>((ref) async {
    var language = ref.watch(languageProvider).name;

    final config = await ConfigDTO.parse(language);
    return config;
  });
  static final languageProvider = StateProvider((ref) {
    var language = const String.fromEnvironment('LANGUAGE', defaultValue: 'en');
    return Language.values
        .firstWhere((l) => l.name == language, orElse: () => Language.en);
  });
}

enum Language {
  de,
  en,
}
