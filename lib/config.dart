import 'dart:io';

class ApplicationConfig {
  ApplicationConfig({
    this.apiEndpoint,
  });

  final String apiEndpoint;
}

// TODO: サーバーの接続先はflavor等で対応予定
// See: https://github.com/team-e-org/mobile/issues/183
final debugConfig = ApplicationConfig(
  apiEndpoint:
      Platform.isAndroid ? 'http://10.0.2.2:5000' : 'http://localhost:5000',
  // Platform.isAndroid ? 'http://10.0.2.2:3100' : 'http://localhost:3100',
);

ApplicationConfig readConfig() {
  return debugConfig;
}
