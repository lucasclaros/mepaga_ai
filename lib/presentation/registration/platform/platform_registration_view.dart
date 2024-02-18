// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_route/auto_route.dart';
import 'package:domain/use_cases/check_platform_uc.dart';
import 'package:domain/use_cases/get_user_platforms_uc.dart';
import 'package:domain/use_cases/platform_register_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/common/app_router.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/registration/components/platform_list_item.dart';
import 'package:mepaga_ai/presentation/registration/platform/bloc/platform_registration_bloc.dart';
import 'package:mepaga_ai/presentation/registration/platform/components/transfer_ticket_view.dart';
import 'package:mepaga_ai/presentation/registration/platform/components/utils.dart';

@RoutePage()
class PlatformRegistrationView extends StatefulWidget {
  const PlatformRegistrationView({super.key});

  @override
  State<PlatformRegistrationView> createState() =>
      _PlatformRegistrationViewState();
}

class _PlatformRegistrationViewState extends State<PlatformRegistrationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlatformRegistrationBloc(
        getUserPlatformsUC: context.read<GetUserPlatformsUC>(),
        platformRegisterUC: context.read<PlatformRegisterUC>(),
        checkPlatformUC: context.read<CheckPlatformUC>(),
      ),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          final tabsRouter = AutoTabsRouter.of(context);
          if (tabsRouter.activeIndex != 0) {
            tabsRouter.navigate(HomeRoute());
          }
        },
        child: MPGScaffold(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: BlocConsumer<PlatformRegistrationBloc,
                PlatformRegistrationState>(
              listener: (context, state) {
                if (state is CheckUserPlatformSuccessNoAssociation) {
                  showPlatformEmailAssociationModal(
                    context: context,
                    onAssociateSameEmail: () {
                      context.read<PlatformRegistrationBloc>().add(
                            RegisterPlatform(
                              platform: state.platform,
                            ),
                          );
                    },
                    onAssociateDifferentEmail: () {
                      context.router.push(
                        AddEmailPlatformRoute(
                          platform: 'byma',
                          onSuccess: () {
                            context.read<PlatformRegistrationBloc>().add(
                                  ListUserPlatforms(),
                                );
                          },
                        ),
                      );
                    },
                  ).then((_) {
                    context.read<PlatformRegistrationBloc>().add(
                          ListUserPlatforms(),
                        );
                  });
                }

                if (state is CheckUserPlatformSuccessNoAccount ||
                    state is CheckUserPlatformSuccessEmailExists) {
                  context.router
                      .push(
                    AddEmailPlatformRoute(
                      platform: 'byma',
                      onSuccess: () async {
                        context.read<PlatformRegistrationBloc>().add(
                              ListUserPlatforms(),
                            );
                      },
                    ),
                  )
                      .then((_) {
                    context.read<PlatformRegistrationBloc>().add(
                          ListUserPlatforms(),
                        );
                  });
                }
              },
              builder: (context, state) {
                if (state is ListPlatformsLoading &&
                    state is CheckUserPlatformLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white.withOpacity(0.8),
                      strokeWidth: 2.w,
                    ),
                  );
                }

                if (state is ListPlatformsError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ops... Ocorreu um erro!',
                        style: GoogleFonts.barlow(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE9E9E9),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      MPGButton(
                        gradient: MPGColors.of(context).mpgButtonWhitedGradient,
                        onPressed: () {
                          context.router.push(
                            TransferOrientationRoute(
                              platform: 'byma',
                            ),
                          );
                        },
                        child: Text(
                          'Tentar novamente',
                          style: MPGTextStyles.of(context).mpgWhitedButton,
                        ),
                      ),
                    ],
                  );
                }

                if (state is ListPlatformsSuccess) {
                  final platforms = state.platforms;

                  if (platforms.first.associated) {
                    return const TransferTicketView();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70.h),
                      const Center(
                        child: Icon(
                          Icons.warning_rounded,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Nenhuma conta sincronizada',
                          style: GoogleFonts.barlow(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFE9E9E9),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Vincule um e-mail que esteja relacionado a plataforma abaixo.',
                        style: GoogleFonts.barlow(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFE9E9E9),
                        ),
                      ),
                      SizedBox(height: 36.h),
                      Text(
                        'Vincular e-mail a:',
                        style: GoogleFonts.barlow(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFE9E9E9),
                        ),
                      ),
                      SizedBox(height: 56.h),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: platforms.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: PlatformListItem(
                                logo: MPGAssetsPaths.of(context).logoByma,
                                isLinked: platforms[index].associated,
                                platformName: platforms[index].platform,
                                onTap: () {
                                  context.read<PlatformRegistrationBloc>().add(
                                        CheckUserPlatform(
                                          platform: platforms[index].platform,
                                        ),
                                      );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      Center(
                        child: Text(
                          'Mais plataformas em breve...',
                          style: GoogleFonts.barlow(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                      // const Spacer(),
                      // SizedBox(height: 55.h),
                    ],
                  );
                }

                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.8),
                    strokeWidth: 2.w,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
