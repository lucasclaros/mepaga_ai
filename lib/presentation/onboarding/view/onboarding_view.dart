import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/config/app_config.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_fade_in.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: MPGFadeIn(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 64.h),
                  Text(
                    'O que é o\nMe Paga Aí?',
                    style: MPGTextStyles.of(context).welcomeTitle,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Tudo que você precisa para transferir\ningressos com segurança.',
                    style: MPGTextStyles.of(context).welcomeSubtitle,
                  ),
                  SizedBox(height: 48.h),
                  const _FeatureCard(
                    icon: Icons.shield_outlined,
                    title: 'Transferência segura',
                    description: 'A gente intermedia. Zero golpes, zero estresse.',
                  ),
                  SizedBox(height: 12.h),
                  const _FeatureCard(
                    icon: Icons.bolt_outlined,
                    title: 'Rápido e sem burocracia',
                    description: 'Compartilhe o link e pronto. Em minutos.',
                  ),
                  SizedBox(height: 12.h),
                  const _FeatureCard(
                    icon: Icons.undo_rounded,
                    title: 'Flexível',
                    description: 'Desistiu? Resgate seu ingresso a qualquer momento.',
                  ),
                ],
              ),
            ),
            const Spacer(),
            MPGButton(
              onPressed: () => context.push('/register-email'),
              child: Text(
                'Criar conta',
                style: MPGTextStyles.of(context).mpgColoredButton,
              ),
            ),
            SizedBox(height: 16.h),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Já possuo uma conta',
                      style: MPGTextStyles.of(context).alreadyHasAccountMessage,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.push('/login'),
                    ),
                  ],
                ),
              ),
            ),
            if (kMockApiCalls) ...[
              SizedBox(height: 20.h),
              TextButton.icon(
                onPressed: () => context.push(
                  '/login',
                  extra: {'autoDemo': true},
                ),
                icon: Icon(
                  Icons.play_circle_outline_rounded,
                  color: brandPrimary,
                  size: 18.w,
                ),
                label: Text(
                  'Explorar Demo',
                  style: GoogleFonts.barlow(
                    color: brandPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: surfaceBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: brandPrimary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: brandPrimary, size: 22.w),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.barlow(
                    color: textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  description,
                  style: GoogleFonts.barlow(
                    color: textSecondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
