import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/flavors.dart';

class ApplicationConfig {
  const ApplicationConfig({
    this.apiEndpoint,
  });

  final String apiEndpoint;
}

Future<void> loadDotEnv() async {
  final envPathMap = {
    Flavor.DEV: '.env/dev',
    Flavor.STAGING: './env/staging',
    Flavor.PRODUCTION: './env/production',
  };

  final envPath = envPathMap[F.appFlavor];
  await DotEnv().load(envPath);
}

Future<ApplicationConfig> readConfig() async {
  await loadDotEnv();
  final apiEndpoint = DotEnv().env['API_ENDPOINT'];
  if (apiEndpoint == null || apiEndpoint.isEmpty) {
    throw Exception('API_ENDPOINT is missing');
  }

  return ApplicationConfig(
    apiEndpoint: apiEndpoint,
  );
}
