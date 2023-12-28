import 'package:domain/use_cases/get_user_info_uc.dart';
import 'package:domain/use_cases/user_logout_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
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
            _isLoading = state is HomeLoading || state is LogoutLoading;
          });

          if (state is LogoutSuccess) {
            GoRouter.of(context).pushLoginPage();
          }
        },
        builder: (context, state) {
          return _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.w,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 39.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Olá,',
                                  style: GoogleFonts.barlow(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                Text(
                                  UserMM().name,
                                  style: GoogleFonts.barlow(
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                showFlushbar(
                                  context: context,
                                  message: 'Login realizado com sucesso!',
                                  fontColor: Colors.white,
                                  backgroundColor: Colors.green,
                                );
                              },
                              icon: const Icon(
                                Icons.notifications_none_outlined,
                                size: 36,
                              ),
                              color: const Color(0xFFCEC2DA),
                            ),
                          ],
                        ),
                        SizedBox(height: 39.h),
                        Text(
                          'Acompanhe seus ingressos.',
                          style: GoogleFonts.barlow(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: 60.h),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                child: SvgPicture.asset(
                                  MPGAssetsPaths.of(context).emptyTickets,
                                ),
                              ),
                              SizedBox(height: 60.h),
                              Text(
                                'Você ainda não possui ingressos.',
                                style: GoogleFonts.barlow(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 100.h),
                        MPGButton(
                          child: Text(
                            'Logout',
                            style: MPGTextStyles.of(context).mpgColoredButton,
                          ),
                          onPressed: () {
                            context.read<HomeBloc>().add(UserLogout());
                          },
                        ),
                        SizedBox(height: 45.h),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
