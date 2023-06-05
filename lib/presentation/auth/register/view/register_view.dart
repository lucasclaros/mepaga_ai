import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static Widget create() => const RegisterView();

  @override
  State<RegisterView> createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: Text('oi'),
    );
  }
}
