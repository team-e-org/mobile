import 'dart:io';

class ApplicationConfig {
  ApplicationConfig({
    this.apiEndpoint,
  });

  final String apiEndpoint;
}

final debugConfig = ApplicationConfig(
  apiEndpoint:
      Platform.isAndroid ? 'http://10.0.2.2:3100' : 'http://localhost:3100',
);

ApplicationConfig readConfig() {
  // TODO: 本番環境用のconfigを入れる
  return debugConfig;
}
