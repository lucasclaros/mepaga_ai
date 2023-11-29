import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.showFlushbar,
  });

  final bool showFlushbar;

  static Widget create({bool showFlushbar = false}) => HomePage(
        showFlushbar: showFlushbar,
      );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    if (widget.showFlushbar) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showFlushbar(
          context: context,
          message: 'Login realizado com sucesso!',
          fontColor: Colors.white,
          backgroundColor: Colors.green,
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            MPGHeader(
              title: 'Olá, ${UserMM().name}!',
              isBackButtonVisible: false,
            ),
            const SizedBox(height: 30),
            MPGButton(
              child: Text(
                'Logout',
                style: MPGTextStyles.of(context).mpgColoredButton,
              ),
              onPressed: () async {
                // await context.read<OnlineCDS>().logout();
                // GoRouter.of(context).pushHomePage();
                // final dio = context.read<Dio>();
                // final response = await dio.get(
                //   'https://api.mepaga.ai/user',
                // );
                // print('TESTE ${response}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
