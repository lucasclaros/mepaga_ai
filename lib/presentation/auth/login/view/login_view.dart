import 'package:domain/use_cases/cache_jwt_uc.dart';
import 'package:domain/use_cases/user_login_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/presentation/auth/login/bloc/login_bloc.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_fade_in.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';

const _demoEmail = 'demo@mepaga.com';
const _demoPassword = 'demo1234';

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
  String? errorMessage;

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _autoDemoTriggered = false;

  void _triggerLogin(BuildContext context) {
    context.read<LoginBloc>().add(
          UserLogin(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  void _fillAndLoginDemo(BuildContext context) {
    setState(() {
      _emailController.text = _demoEmail;
      _passwordController.text = _demoPassword;
      errorMessage = null;
    });
    _triggerLogin(context);
  }

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
            if (state is LoginBlocInvalidCredentials) {
              setState(() {
                errorMessage = state.message;
              });
            } else {
              setState(() {
                isShowingFlushbar = true;
              });
              showFlushbar(
                context: context,
                title: 'Ops... Ocorreu um erro!',
                message: state.message,
                fontColor: Colors.white,
                backgroundColor: errorColor,
                thenFunction: () {
                  setState(() {
                    isShowingFlushbar = false;
                  });
                },
              );
            }
          }

          if (state is LoginBlocSuccess) {
            context.go('/', extra: true);
          }
        },
        builder: (context, state) {
          if (!_autoDemoTriggered) {
            _autoDemoTriggered = true;
            final extra = GoRouterState.of(context).extra;
            if (extra is Map && extra['autoDemo'] == true) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _fillAndLoginDemo(context);
              });
            }
          }
          return MPGScaffold(
            child: MPGFadeIn(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const MPGHeader(title: 'Bem-vindo!'),
                    SizedBox(height: 75.h),
                    MPGTextField(
                      labelText: 'Digite seu email',
                      hintText: 'Email',
                      isPassword: false,
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      errorText: errorMessage,
                    ),
                    SizedBox(height: 43.h),
                    MPGTextField(
                      labelText: 'Digite sua senha',
                      hintText: 'Senha',
                      isPassword: true,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      errorText: errorMessage,
                    ),
                    SizedBox(height: 60.h),
                    MPGButton(
                      gradient: MPGColors.of(context).mpgButtonColoredGradient,
                      onPressed: () => _triggerLogin(context),
                      isLoading: isLoading,
                      child: Text(
                        'Entrar',
                        style: MPGTextStyles.of(context).mpgColoredButton,
                      ),
                    ),
                    SizedBox(height: 70.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
