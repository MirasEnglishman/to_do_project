
import 'package:to_do_project/app.dart';
import 'package:to_do_project/firebase_options.dart';
import 'package:to_do_project/service_locator.dart';
import 'package:to_do_project/utlis/shared_preference.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();

  await sharedPreference.init();
  await serviceLocatorSetup();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ru'), Locale('kk')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MyApp()),
  );
}
