import 'package:dio/dio.dart';
import 'package:domain/use_cases/get_user_info_uc.dart';
import 'package:domain/use_cases/user_logout_uc.dart';
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
import 'package:mepaga_ai/presentation/home/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.showFlushbar,
  });

  final bool showFlushbar;

  static Widget create({bool showFlushbar = false}) => BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(
          getUserInfoUC: context.read<GetUserInfoUC>(),
          userLogoutUC: context.read<UserLogoutUC>(),
        ),
        child: HomePage(
          showFlushbar: showFlushbar,
        ),
      );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

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
    context.read<HomeBloc>().add(UserInfo());
  }

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          setState(() {
            _isLoading = state is HomeLoading;
          });
        },
        builder: (context, state) {
          return Center(
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                : SingleChildScrollView(
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
                          onPressed: () {
                            context.read<HomeBloc>().add(UserLogout());
                            GoRouter.of(context).pushHomePage();
                          },
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
