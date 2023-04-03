import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mepaga_ai/common/general_provider.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/url_strategy/nonweb_url_strategy.dart'
    if (dart.library.html) 'package:mepaga_ai/url_strategy/web_url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureUrl();

  runApp(
    const GeneralProvider(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    );
  }
}
