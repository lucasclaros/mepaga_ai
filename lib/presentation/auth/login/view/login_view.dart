import 'package:domain/use_cases/user_login_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/presentation/auth/login/bloc/login_bloc.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static Widget create() => BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          userLoginUC: context.read<UserLoginUC>(),
        ),
        child: const LoginView(),
      );

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginBlocState>(
      listener: (context, state) {
        if (state is LoginBlocError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }

        if (state is LoginBlocSuccess) {
          GoRouter.of(context).pushStartPage();
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
                SizedBox(
                  height: context.responsiveHeight(90),
                ),
                MPGTextField(
                  labelText: 'Digite seu email',
                  hintText: 'Email',
                  isPassword: false,
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                ),
                SizedBox(
                  height: context.responsiveHeight(43),
                ),
                MPGTextField(
                  labelText: 'Digite sua senha',
                  hintText: 'Senha',
                  isPassword: true,
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                ),
                SizedBox(
                  height: context.responsiveHeight(190),
                ),
                MPGButton(
                  gradient:
                      MPGColors.of(context).mpgButtonColoredGradientDisabled,
                  child: Text(
                    'Login',
                    style: MPGTextStyles.of(context).mpgColoredButtonDisabled,
                  ),
                  onPressed: () {
                    context.read<LoginBloc>().add(
                          UserLogin(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
