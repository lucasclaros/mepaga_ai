// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:styled_text/styled_text.dart';

class PlatformRegistrationView extends StatefulWidget {
  const PlatformRegistrationView({super.key});

  static Widget create() => const PlatformRegistrationView();

  @override
  State<PlatformRegistrationView> createState() =>
      _PlatformRegistrationViewState();
}

class _PlatformRegistrationViewState extends State<PlatformRegistrationView>
    with AutomaticKeepAliveClientMixin<PlatformRegistrationView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MPGScaffold(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 70.h),
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                  size: 100,
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
                      GestureDetector(
                        onTap: () {
                          showMPGBottomSheet(
                            context: context,
                            title: 'Acho que posso te ajudar aqu',
                            description:
                                'Identificamos que o e-mail que você usou no cadastro está associado a uma conta na plataforma BYMA.\n'
                                'Para transferir ingressos da sua conta BYMA para a sua conta Me Paga Aí, clique em:\n'
                                'Associar e-mail de cadastro.\n\n'
                                'Se preferir usar outro e-mail, escolha:\n'
                                '<strong>Associar outro e-mail.</strong>\n\n'
                                'e siga as instruções de validação por código.',
                            buttonText: 'Associar e-mail de cadastro',
                          );
                        },
                        child: SvgPicture.asset(
                          MPGAssetsPaths.of(context).doubtButton,
                        ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
