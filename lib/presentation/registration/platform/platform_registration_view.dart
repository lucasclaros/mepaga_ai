// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:domain/use_cases/get_user_platforms_uc.dart';
import 'package:domain/use_cases/platform_register_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:mepaga_ai/presentation/home/components/shimmer_ticket_list.dart';
import 'package:mepaga_ai/presentation/registration/platform/bloc/platform_registration_bloc.dart';
import 'package:mepaga_ai/presentation/registration/platform/components/platform_email_info_modal.dart';
import 'package:mepaga_ai/presentation/registration/platform/components/platform_list_item.dart';
import 'package:styled_text/styled_text.dart';

class PlatformRegistrationView extends StatefulWidget {
  const PlatformRegistrationView({super.key});

  static Widget create() => BlocProvider(
        create: (context) => PlatformRegistrationBloc(
          getUserPlatformsUC: context.read<GetUserPlatformsUC>(),
          platformRegisterUC: context.read<PlatformRegisterUC>(),
        ),
        child: const PlatformRegistrationView(),
      );

  @override
  State<PlatformRegistrationView> createState() =>
      _PlatformRegistrationViewState();
}

class _PlatformRegistrationViewState extends State<PlatformRegistrationView>
    with AutomaticKeepAliveClientMixin<PlatformRegistrationView> {
  // List<PlatformListItem> _buildPlatforms() => [
  //       PlatformListItem(
  //         logo: MPGAssetsPaths.of(context).logoByma,
  //         isLinked: false,
  //         platformName: 'byma',
  //         onTap: () {},
  //       ),
  //     ];

  @override
  void initState() {
    super.initState();
    // platforms = _buildPlatforms();
    context.read<PlatformRegistrationBloc>().add(ListUserPlatforms());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MPGScaffold(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
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
                  const PlatformEmailInfoModal(),
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
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<PlatformRegistrationBloc>()
                      .add(ListUserPlatforms());
                },
                child: BlocConsumer<PlatformRegistrationBloc,
                    PlatformRegistrationState>(
                  listener: (context, state) {
                    if (state is RegisterPlatformError) {
                      showFlushbar(
                        context: context,
                        title: 'Ops... Ocorreu um erro!',
                        message: state.message,
                        fontColor: Colors.white,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ListPlatformsLoading) {
                      return const ShimmerTicketList();
                    }

                    if (state is ListPlatformsError ||
                        state is RegisterPlatformError) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<PlatformRegistrationBloc>()
                                .add(ListUserPlatforms());
                          },
                          child: const Text('Tentar'),
                        ),
                      );
                    }

                    if (state is ListPlatformsSuccess) {
                      final platforms = state.platforms;

                      return ListView.builder(
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
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
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
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
