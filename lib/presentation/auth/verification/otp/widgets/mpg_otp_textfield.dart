import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
    const borderColor = Colors.grey;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.barlow(
        fontSize: 42,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      decoration: const BoxDecoration(),
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
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
          width: 56,
          height: 3,
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
          pinAnimationType: PinAnimationType.fade,
          controller: _otpController,
          focusNode: _otpFocusNode,
          defaultPinTheme: defaultPinTheme,
          cursor: cursor,
          preFilledWidget: preFilledWidget,
        ),
        Row(
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
                      style: GoogleFonts.barlow(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
