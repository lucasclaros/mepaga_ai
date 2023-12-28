import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:mepaga_ai/common/general_provider.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/url_strategy/nonweb_url_strategy.dart'
    if (dart.library.html) 'package:mepaga_ai/url_strategy/web_url_strategy.dart';

class Log {
  final Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<void> logError(
    String errorType,
    dynamic error, [
    StackTrace? stackTrace,
  ]) async {
    logger.e(errorType, error, stackTrace);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final errorLogger = Log().logError;

  configureUrl();

  runZonedGuarded(() async {
    runApp(
      GeneralProvider(
        errorLogger: errorLogger,
        child: const MPGApp(),
      ),
    );
  }, (error, stack) {
    errorLogger(
      'Zone Guarded Error',
      error,
      stack,
    );
  });
}

class MPGApp extends StatelessWidget {
  const MPGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp.router(
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.stylus,
            PointerDeviceKind.invertedStylus,
          },
        ),
        routerConfig: routes,
        debugShowCheckedModeBanner: false,
        title: 'Me Paga Ai',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
