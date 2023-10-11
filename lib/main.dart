import 'dart:io';
import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';
import 'locator.dart';
import 'push_notification_utils/alarm_manager_function.dart';
import 'routs/app_router.dart';
import 'services/navigation_service.dart';
import 'package:mohamed_mekhemar/app/home_vistore/dio_helper.dart';

import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await AndroidAlarmManager.initialize();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      startLocale: const Locale('en'),
      saveLocale: true,
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const App(),
    ),
  );
  
  dioHelper.int();
  const int helloAlarmID = 0;
  DateTime now = DateTime.now();
  DateTime nextClockHead = DateTime(
    now.year,
    now.month,
    now.day,
    now.hour + 1,
  );

  await AndroidAlarmManager.periodic(
    const Duration(minutes: 2),
    helloAlarmID,
    alarmMAngerFunction,
    allowWhileIdle: true,
    startAt: DateTime.now(),
    exact: true,
    wakeup: true,
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  void checkPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied) {
      status = await Permission.notification.request();
      if (status.isGranted) {}
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    checkPermission();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'El-Monorail',
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
