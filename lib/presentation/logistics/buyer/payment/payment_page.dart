// ignore_for_file: lines_longer_than_80_chars, use_decorated_box

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/models/payment_charge.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:mepaga_ai/presentation/logistics/buyer/payment/components/step_widget.dart';

@RoutePage()
class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.paymentCharge,
    required this.platform,
  });

  final PaymentCharge paymentCharge;
  final String platform;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool showQR = false;

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const MPGHeader(title: 'Quase lá!'),
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 300.h,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      child: showQR
                          ? Container(
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF160132),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  await Clipboard.setData(
                                    ClipboardData(
                                      text: widget.paymentCharge.brCode,
                                    ),
                                  ).then(
                                    (_) => {
                                      SchedulerBinding.instance
                                          .addPostFrameCallback(
                                        (_) {
                                          showFlushbar(
                                            context: context,
                                            message:
                                                'QR Code copiado com sucesso!',
                                            fontColor: Colors.white,
                                            backgroundColor: Colors.green,
                                          );
                                        },
                                      ),
                                    },
                                  );
                                },
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl: widget.paymentCharge.qrImage,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                    imageBuilder: (context, imageProvider) =>
                                        Image(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const StepWidget(
                                  step: '1',
                                  stepText: 'Abra o aplicativo do seu banco',
                                ),
                                const StepWidget(
                                  step: '2',
                                  stepText: 'Vá para opção de pagamento Pix',
                                ),
                                const StepWidget(
                                  step: '3',
                                  stepText: 'Cole o código abaixo:',
                                ),
                                MPGTextField(
                                  width: double.infinity,
                                  isPassword: false,
                                  prefixIcon:
                                      MPGAssetsPaths.of(context).logoPix,
                                  suffixIcon: MPGAssetsPaths.of(context)
                                      .copyClipboardIcon,
                                  hintText: 'transferencia@mepaga.ai',
                                  readOnly: true,
                                  onSuffixIconPressed: () async {
                                    await Clipboard.setData(
                                      const ClipboardData(
                                        text: 'transferencia@mepaga.ai',
                                      ),
                                    ).then(
                                      (_) => {
                                        SchedulerBinding.instance
                                            .addPostFrameCallback(
                                          (_) {
                                            showFlushbar(
                                              context: context,
                                              message:
                                                  'Chave PIX copiada com sucesso!',
                                              fontColor: Colors.white,
                                              backgroundColor: Colors.green,
                                            );
                                          },
                                        ),
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Abrir ',
                          style: GoogleFonts.barlow(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        TextSpan(
                          text: showQR ? 'Chave PIX' : 'QR Code',
                          style: GoogleFonts.barlow(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFF5800),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                showQR = !showQR;
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  CountdownTimer(
                    textStyle: GoogleFonts.barlow(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    endTime: DateTime.now()
                        .add(const Duration(minutes: 30))
                        .millisecondsSinceEpoch,
                    widgetBuilder: (_, time) {
                      if (time == null) {
                        return const SizedBox();
                      }

                      return AutoSizeText(
                        'Expira em: ${time.min.toString().padLeft(2, '0')}:${time.sec.toString().padLeft(2, '0')}',
                        style: GoogleFonts.barlow(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 1,
                      );
                    },
                  ),
                  SizedBox(height: 42.h),
                  AutoSizeText(
                    'Após o pagamento, este ingresso estará disponível em sua conta ${widget.platform.toUpperCase()}.',
                    style: GoogleFonts.barlow(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
