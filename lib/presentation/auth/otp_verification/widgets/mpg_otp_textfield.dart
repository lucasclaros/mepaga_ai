import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:pinput/pinput.dart';

class MPGOtpTextField extends StatefulWidget {
  const MPGOtpTextField({super.key});

  @override
  State<MPGOtpTextField> createState() => _MPGOtpTextFieldState();
}

class _MPGOtpTextFieldState extends State<MPGOtpTextField> {
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const _defaulWidth = 56.0;
    const _defaulHeight = 3.0;
    const borderColor = Colors.grey;

    final defaultPinTheme = PinTheme(
      width: _defaulWidth,
      height: _defaulWidth,
      textStyle: MPGTextStyles.of(context).pinputDefaultTheme,
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: _defaulWidth,
          height: _defaulHeight,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: _defaulWidth,
          height: _defaulHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
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
          onClipboardFound: (value) {
            if (isNumeric(value) && value.length == 6) {
              setState(() {
                _otpController.text = value;
              });
            }
          },
        ),
        SizedBox(
          // 6 from pinput length and 40 from (5 gaps * 8 default padding)
          width: 6 * _defaulWidth + 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                child: TextButton(
                  onPressed: () {
                    Clipboard.getData(Clipboard.kTextPlain).then((value) {
                      setState(() {
                        _otpController.text = value?.text ?? '';
                      });
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.assignment,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Colar código',
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
