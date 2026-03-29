import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:mepaga_ai/common/general_provider.dart';
import 'package:mepaga_ai/common/go_router_config.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';
import 'package:provider/provider.dart';
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

  }, (error, stack) {
    errorLogger(
      'Zone Guarded Error',
      error,
      stack,
    );
  });
}

class MPGApp extends StatefulWidget {
  const MPGApp({super.key});

  @override
  State<MPGApp> createState() => _MPGAppState();
}

class _MPGAppState extends State<MPGApp> {
  @override
  void initState() {
    super.initState();
    // Pre-warm the JWT cache while the native splash is still visible.
    // Once loaded, the router redirect becomes synchronous → animations work.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final jwt = await context.read<OnlineCDS>().getJWT();
      if (mounted) {
        FlutterNativeSplash.remove();
        if (jwt != null) {
          routerConfig.go('/');
        }
      }
    });
  }

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
        routerConfig: routerConfig,
        debugShowCheckedModeBanner: false,
        title: 'Me Paga Ai',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
