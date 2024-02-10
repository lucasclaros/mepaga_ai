// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:domain/use_cases/check_platform_uc.dart';
import 'package:domain/use_cases/get_user_platforms_uc.dart';
import 'package:domain/use_cases/platform_register_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/common/app_router.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/home/components/shimmer_ticket_list.dart';
import 'package:mepaga_ai/presentation/registration/components/platform_list_item.dart';
import 'package:mepaga_ai/presentation/registration/platform/bloc/platform_registration_bloc.dart';
import 'package:mepaga_ai/presentation/registration/platform/components/platform_email_info_modal.dart';
import 'package:mepaga_ai/presentation/registration/platform/components/transfer_ticket_view.dart';
import 'package:mepaga_ai/presentation/registration/platform/components/utils.dart';
import 'package:styled_text/styled_text.dart';

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
      child: MPGScaffold(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child:
              BlocConsumer<PlatformRegistrationBloc, PlatformRegistrationState>(
            listener: (context, state) {
              if (state is RegisterPlatformError) {
                context.router.push(
                  AddEmailPlatformRoute(
                    platform: 'byma',
                    onSuccess: (email) {
                      context.router.push(
                        OTPPlatformVerificationRoute(
                          platform: 'byma',
                          email: email,
                        ),
                      );
                    },
                  ),
                );
              }

              if (state is CheckUserPlatformSuccessNoAssociation) {
                showPlatformEmailAssociationModal(
                  context: context,
                  onAssociateSameEmail: () {},
                  onAssociateDifferentEmail: () {},
                );
              }
            },
            builder: (context, state) {
              if (state is ListPlatformsLoading) {
                return const ShimmerTicketList();
              }

              if (state is CheckUserPlatformLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.8),
                    strokeWidth: 2.w,
                  ),
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
                    Text(
                      'Nenhuma conta sincronizada',
                      style: GoogleFonts.barlow(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFE9E9E9),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    StyledText(
                      text:
                          'Vincule um e-mail que esteja relacionado a plataforma abaixo. <doubt/>',
                      tags: {
                        'doubt': StyledTextWidgetTag(
                          PlatformEmailInfoModal(
                            onAssociateSameEmail: () {
                              context.read<PlatformRegistrationBloc>().add(
                                    RegisterPlatform(
                                      platform: 'byma',
                                      email: UserMM().email,
                                    ),
                                  );
                            },
                            onAssociateDifferentEmail: () {},
                          ),
                          size: Size.square(min(25.w, 25)),
                        ),
                      },
                      style: GoogleFonts.barlow(
                        fontSize: 16.sp,
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
                                      RegisterPlatform(
                                        platform: platforms[index].platform,
                                      ),
                                    );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 60.h),
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
    );
  }
}
