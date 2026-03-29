// ignore_for_file: lines_longer_than_80_chars

import 'package:domain/use_cases/check_platform_uc.dart';
import 'package:domain/use_cases/get_user_platforms_uc.dart';
import 'package:domain/use_cases/platform_register_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/empty_states/generic_error_empty_state.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mepaga_ai/presentation/registration/components/platform_list_item.dart';
import 'package:mepaga_ai/presentation/registration/platform/bloc/platform_registration_bloc.dart';
import 'package:mepaga_ai/presentation/registration/platform/components/transfer_ticket_view.dart';
import 'package:mepaga_ai/presentation/registration/platform/components/utils.dart';

class PlatformRegistrationView extends StatefulWidget {
  const PlatformRegistrationView({super.key});

  @override
  State<PlatformRegistrationView> createState() =>
      _PlatformRegistrationViewState();
}

class _PlatformRegistrationViewState extends State<PlatformRegistrationView> {
  // Tracks the platform the user tapped — needed for states that don't carry
  // platform info (CheckUserPlatformSuccessNoAccount / EmailExists).
  String _selectedPlatform = '';

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
          child: BlocConsumer<PlatformRegistrationBloc,
              PlatformRegistrationState>(
            listener: (context, state) {
              if (state is CheckUserPlatformSuccessNoAssociation) {
                final bloc = context.read<PlatformRegistrationBloc>();
                showPlatformEmailAssociationModal(
                  context: context,
                  onAssociateSameEmail: () {
                    bloc.add(RegisterPlatform(platform: state.platform));
                  },
                  onAssociateDifferentEmail: () {
                    context.push(
                      '/add-email-platform',
                      extra: {
                        'platform': state.platform,
                        'onSuccess': () => bloc.add(ListUserPlatforms()),
                      },
                    );
                  },
                ).then((_) => bloc.add(ListUserPlatforms()));
              }

              if (state is CheckUserPlatformSuccessNoAccount ||
                  state is CheckUserPlatformSuccessEmailExists) {
                final bloc = context.read<PlatformRegistrationBloc>();
                context
                    .push(
                  '/add-email-platform',
                  extra: {
                    'platform': _selectedPlatform,
                    'onSuccess': () => bloc.add(ListUserPlatforms()),
                  },
                )
                    .then((_) => bloc.add(ListUserPlatforms()));
              }
            },
            builder: (context, state) {
              if (state is ListPlatformsLoading ||
                  state is CheckUserPlatformLoading) {
                return const _PlatformListSkeleton();
              }

              if (state is ListPlatformsError) {
                return GenericErrorEmptyState(
                  onRetry: () {
                    context
                        .read<PlatformRegistrationBloc>()
                        .add(ListUserPlatforms());
                  },
                );
              }

              if (state is ListPlatformsSuccess) {
                final platforms = state.platforms;
                final associated =
                    platforms.where((p) => p.associated).toList();

                if (associated.isNotEmpty) {
                  return TransferTicketView(platforms: associated);
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
                      'Vincule um e-mail relacionado a uma das plataformas abaixo.',
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
                          final p = platforms[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: PlatformListItem(
                              logo: MPGAssetsPaths.of(context)
                                  .logoForPlatform(p.platform),
                              isLinked: p.associated,
                              platformName: p.platform,
                              onTap: () {
                                setState(
                                    () => _selectedPlatform = p.platform);
                                context
                                    .read<PlatformRegistrationBloc>()
                                    .add(CheckUserPlatform(
                                        platform: p.platform));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              return const _PlatformListSkeleton();
            },
          ),
        ),
      ),
    );
  }
}

class _PlatformListSkeleton extends StatelessWidget {
  const _PlatformListSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2A2A2A),
      highlightColor: const Color(0xFF3A3A3A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 70.h),
          // Title skeleton
          Container(
            width: 220.w,
            height: 26.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(height: 20.h),
          // Subtitle skeleton
          Container(
            width: 280.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(height: 56.h),
          // "Vincular e-mail a:" label skeleton
          Container(
            width: 150.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(height: 30.h),
          // 3 platform item skeletons
          for (int i = 0; i < 3; i++) ...[
            Container(
              height: 84.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFF333333)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo placeholder
                    Container(
                      width: 90.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A3A),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    // Status text placeholder
                    Container(
                      width: 80.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A3A),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ],
      ),
    );
  }
}
