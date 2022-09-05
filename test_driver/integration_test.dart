import 'package:integration_test/integration_test_driver.dart';

/// Set integration test in chrome or web driver but need to provide
/// chrome driver and run chromedriver --port=4444
/// https://chromedriver.chromium.org/downloads
///
/// To run test
/// flutter drive --driver=test_driver/integration_test.dart \
///  --target=integration_test/app_test.dart -d web-server
Future<void> main() => integrationDriver();
