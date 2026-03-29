import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  // true  = animating in (button hidden below screen)
  // false = idle (button visible)
  // null  = animating out (button hidden below screen again)
  bool? _buttonState = true;

  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnim = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
      setState(() => _buttonState = false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onStartPressed() async {
    // Slide button back down first, then navigate
    setState(() => _buttonState = null);
    await Future.delayed(const Duration(milliseconds: 320));
    if (mounted) unawaited(context.push('/onboarding'));
  }

  @override
  Widget build(BuildContext context) {
    // Button position: off-screen below when entering (true) or exiting (null),
    // visible at rest (false).
    final buttonBottom = _buttonState == false ? 90.h : -55.h;

    return MPGScaffold(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 215.h,
            child: SizedBox(
              width: 249.w,
              child: Column(
                children: [
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: ScaleTransition(
                      scale: _scaleAnim,
                      child: Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: brandPrimary.withValues(alpha: 0.45),
                              blurRadius: 32,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/mpg_icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Text(
                      'ME PAGA AÍ',
                      style: MPGTextStyles.of(context).welcomeTitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Text(
                      'Transfira seus ingressos com segurança',
                      style: MPGTextStyles.of(context).welcomeSubtitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 450),
            bottom: buttonBottom,
            child: MPGButton(
              onPressed: _buttonState == false ? _onStartPressed : null,
              child: Text(
                'Começar',
                style: MPGTextStyles.of(context).mpgColoredButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
