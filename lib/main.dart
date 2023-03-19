import 'package:flutter/material.dart';
import 'package:mepaga_ai/common/general_provider.dart';
import 'package:mepaga_ai/common/routing.dart';

void main() {
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
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
      title: 'Me Paga Ai',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
