import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Timer(const Duration(seconds: 3), () {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/party.jpg',
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
          Positioned(
            bottom: context.responsiveHeight(215),
            child: SizedBox(
              width: context.responsiveWidth(249),
              child: Column(
                children: [
                  Text(
                    'ME PAGA AÍ',
                    style: GoogleFonts.barlow(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Transfira seus ingressos com segurança',
                    style: GoogleFonts.barlow(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          // if (isLoading)
          //   Positioned(
          //     bottom: context.responsiveHeight(10),
          //     child: Lottie.asset(
          //       'assets/loading.json',
          //       frameRate: FrameRate(60),
          //       width: 250,
          //       height: 250,
          //       repeat: false,
          //     ),
          //   )
          // else
          AnimatedPositioned(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(
              seconds: 1,
            ),
            bottom: isLoading ? -150 : context.responsiveHeight(90),
            child: MPGButton(
              text: 'Começar',
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                Timer(
                    const Duration(
                      seconds: 1,
                    ), () {
                  setState(() {
                    isLoading = false;
                  });
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
