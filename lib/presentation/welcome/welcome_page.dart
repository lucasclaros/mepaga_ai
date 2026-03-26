import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      backgroundImage: MPGAssetsPaths.of(context).welcomeBackground,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 215.h,
            child: SizedBox(
              width: 249.w,
              child: Column(
                children: [
                  Text(
                    'ME PAGA AÍ',
                    style: MPGTextStyles.of(context).welcomeTitle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Transfira seus ingressos com segurança',
                    style: MPGTextStyles.of(context).welcomeSubtitle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(
              milliseconds: 500,
            ),
            bottom: isLoading ? -55.h : 90.h,
            child: MPGButton(
              child: Text(
                'Começar',
                style: MPGTextStyles.of(context).mpgColoredButton,
              ),
              onPressed: () {
                context.go('/onboarding');
              },
            ),
          ),
        ],
      ),
    );
  }
}
