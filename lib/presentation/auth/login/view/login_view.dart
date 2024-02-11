import 'package:auto_route/auto_route.dart';
import 'package:domain/use_cases/cache_jwt_uc.dart';
import 'package:domain/use_cases/user_login_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mepaga_ai/common/app_router.dart';
import 'package:mepaga_ai/presentation/auth/login/bloc/login_bloc.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  bool isShowingFlushbar = false;

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        userLoginUC: context.read<UserLoginUC>(),
        cacheJwtUC: context.read<CacheJwtUC>(),
      ),
      child: BlocConsumer<LoginBloc, LoginBlocState>(
        listener: (context, state) {
          setState(() {
            isLoading = state is LoginBlocLoading;
          });

          if (state is LoginBlocError && !isShowingFlushbar) {
            setState(() {
              isShowingFlushbar = true;
            });
            showFlushbar(
              context: context,
              title: 'Ops... Ocorreu um erro!',
              message: state.message,
              fontColor: Colors.white,
              backgroundColor: Colors.red,
              thenFunction: () {
                setState(() {
                  isShowingFlushbar = false;
                });
              },
            );
          }

          if (state is LoginBlocSuccess) {
            context.router.replaceAll([BottomNavbarRoute(showFlushbar: true)]);
          }
        },
        builder: (context, state) {
          return MPGScaffold(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const MPGHeader(
                    title: 'Bem-vindo!',
                  ),
                  SizedBox(height: 75.h),
                  MPGTextField(
                    labelText: 'Digite seu email',
                    hintText: 'Email',
                    isPassword: false,
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                  ),
                  SizedBox(height: 43.h),
                  MPGTextField(
                    labelText: 'Digite sua senha',
                    hintText: 'Senha',
                    isPassword: true,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                  ),
                  SizedBox(height: 195.h),
                  MPGButton(
                    gradient: MPGColors.of(context).mpgButtonColoredGradient,
                    onPressed: () {
                      context.read<LoginBloc>().add(
                            UserLogin(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                    },
                    isLoading: isLoading,
                    child: Text(
                      'Login',
                      style: MPGTextStyles.of(context).mpgColoredButton,
                    ),
                  ),
                  SizedBox(height: 70.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
