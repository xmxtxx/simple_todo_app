import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class ConfigDTO {
  static const String _appConfig = 'appConfig';

  final String logoImagePath;

  ConfigDTO({required this.logoImagePath});

  static Future<ConfigDTO> parse(String language) async {
    final String configString;
    final String configSecretString;

    final languageString = await rootBundle
        .loadString('assets/languages/${language}_properties.json');

    configString = await rootBundle.loadString('assets/config.json');
    configSecretString =
        await rootBundle.loadString('assets/config_secrets.json');

    final jsonConfig = jsonDecode(configString);
    final jsonConfigSecret = jsonDecode(configSecretString);
    final jsonLanguage = jsonDecode(languageString);
    if (!jsonConfig.containsKey(_appConfig) &&
        jsonConfigSecret.containsKey(_appConfig)) {
      throw Exception('The required config is not found.');
    }

    var languageJson = jsonLanguage;
    var appJsonConfig = jsonConfig[_appConfig];
    var appJsonConfigSecret = jsonConfigSecret[_appConfig];
    var configJson = {}
      ..addAll(appJsonConfig)
      ..addAll(languageJson)
      ..addAll(appJsonConfigSecret);

    return ConfigDTO(logoImagePath: configJson['logoImagePath']);
  }
}
