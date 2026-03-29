// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:pinput/pinput.dart';

class MPGOtpTextField extends StatefulWidget {
  const MPGOtpTextField({
    required this.textController,
    required this.focusNode,
    required this.onValidate,
    this.errorMessage,
    super.key,
  });

  final TextEditingController textController;
  final FocusNode focusNode;
  final String? errorMessage;
  final Function() onValidate;

  @override
  State<MPGOtpTextField> createState() => _MPGOtpTextFieldState();
}

class _MPGOtpTextFieldState extends State<MPGOtpTextField> {
  @override
  Widget build(BuildContext context) {
    final _otpController = widget.textController;
    final _otpFocusNode = widget.focusNode;
    final defaulWidth = 56.w;
    final defaulHeight = 3.h;
    final borderColor = MPGColors.of(context).textSecondary;

    final defaultPinTheme = PinTheme(
      width: defaulWidth,
      height: defaulWidth,
      textStyle: MPGTextStyles.of(context).pinputDefaultTheme,
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: defaulWidth,
          height: defaulHeight,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ],
    );

    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: defaulWidth,
          height: defaulHeight,
          decoration: BoxDecoration(
            color: MPGColors.of(context).textPrimary,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ],
    );

    return Column(
      children: [
        Pinput(
          length: 6,
          onChanged: (value) => setState(() {
            _otpController.text = value;
          }),
          scrollPadding: const EdgeInsets.only(bottom: 100),
          pinAnimationType: PinAnimationType.fade,
          controller: _otpController,
          focusNode: _otpFocusNode,
          defaultPinTheme: defaultPinTheme,
          cursor: cursor,
          preFilledWidget: preFilledWidget,
          animationCurve: Curves.easeInOut,
          errorText: widget.errorMessage,
          onClipboardFound: (value) {
            if (isNumeric(value) && value.length == 6) {
              showMPGConfirmationModal(
                c: context,
                title: 'Colar código OTP',
                message:
                    '''Identificamos um código em sua área de transferência. Certifique-se de que o código é o mesmo que você recebeu por e-mail!\n\nDeseja o colar no campo de verificação?''',
                confirmButtonText: 'Colar',
                cancelButtonText: 'Cancelar',
                onConfirm: () {
                  setState(() {
                    _otpController.text = value;
                  });
                  Clipboard.setData(const ClipboardData(text: ''));
                  widget.onValidate();
                },
              );
            }
          },
        ),
        SizedBox(
          // 6 from pinput length and 40 from (5 gaps * 8 default padding)
          width: 6 * defaulWidth + 40.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _otpController.text = '';
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Limpar código',
                        style: MPGTextStyles.of(context).otpPasteIndicator,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
