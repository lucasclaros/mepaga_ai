import 'package:another_flushbar/flushbar.dart';
import 'package:domain/use_cases/set_cache_value_uc.dart';
import 'package:domain/use_cases/user_login_uc.dart';
import 'package:domain/use_cases/user_logout_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/auth/login/bloc/login_bloc.dart';
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

  static Widget create({bool showFlushbar = false}) => BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          userLoginUC: context.read<UserLoginUC>(),
          userLogoutUC: context.read<UserLogoutUC>(),
          setCacheValueUC: context.read<SetCacheValueUC>(),
        ),
        child: HomePage(
          showFlushbar: showFlushbar,
        ),
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
    return BlocListener<LoginBloc, LoginBlocState>(
      listener: (context, state) {
        if (state is LoginBlocLogout) {
          GoRouter.of(context).pushHomePage();
        }
      },
      child: MPGScaffold(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MPGHeader(
                title: 'Olá, ${UserMM().name}!',
              ),
              const SizedBox(height: 30),
              MPGButton(
                child: Text(
                  'Logout',
                  style: MPGTextStyles.of(context).mpgColoredButton,
                ),
                onPressed: () {
                  context.read<LoginBloc>().add(UserLogout());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
