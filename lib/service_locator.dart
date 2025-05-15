import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator.config.dart';

GetIt serviceLocator = GetIt.instance;

@InjectableInit(asExtension: false)
Future<void> serviceLocatorSetup() async {
  init(serviceLocator);
}
