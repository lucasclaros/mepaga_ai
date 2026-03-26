import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:mepaga_ai/common/general_provider.dart';
import 'package:mepaga_ai/common/go_router_config.dart';
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
    logger.e(
      errorType,
      error: error,
      stackTrace: stackTrace,
    );
  }
}

void main() async {
  final errorLogger = Log().logError;

  configureUrl();

  await runZonedGuarded(() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );

    await ScreenUtil.ensureScreenSize();

    runApp(
      GeneralProvider(
        errorLogger: errorLogger,
        child: const MPGApp(),
      ),
    );

    // Adicionado: Remover o splash screen após a primeira renderização do frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

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
        routerConfig: routerConfig, // <--- MUDANÇA PRINCIPAL
        debugShowCheckedModeBanner: false,
        title: 'Me Paga Ai',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
