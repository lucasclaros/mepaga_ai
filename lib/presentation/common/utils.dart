// ignore_for_file: use_decorated_box

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';

bool isNumeric(String string) {
// Null or empty string is not a number
  if (string.isEmpty) {
    return false;
  }

  final number = num.tryParse(string);

  if (number == null) {
    return false;
  }

  return true;
}

Future<void> showFlushbar({
  required BuildContext context,
  required String message,
  required Color backgroundColor,
  required Color fontColor,
  String? title,
  Duration? duration,
  EdgeInsets? margin,
  BorderRadius? borderRadius,
  List<BoxShadow>? boxShadows,
  FlushbarPosition? flushbarPosition,
  Widget? mainButton,
  VoidCallback? thenFunction,
}) async {
  late Flushbar flush;

  flush = Flushbar(
    duration: duration ?? const Duration(seconds: 3),
    title: title,
    message: message,
    titleColor: fontColor,
    messageColor: fontColor,
    backgroundColor: backgroundColor,
    margin: margin ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
    borderRadius: borderRadius ?? BorderRadius.circular(10),
    boxShadows: boxShadows ??
        [
          BoxShadow(
            color: backgroundColor.withOpacity(0.6),
            offset: const Offset(0, 2),
            blurRadius: 3,
          ),
        ],
    flushbarPosition: flushbarPosition ?? FlushbarPosition.TOP,
    mainButton: mainButton ??
        Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            icon: const Icon(
              Icons.close,
              size: 20,
            ),
            color: fontColor,
            onPressed: () => flush.dismiss(context),
          ),
        ),
  );

  await flush.show(context).then((_) {
    if (thenFunction != null) {
      thenFunction();
    }
  });
}

Future<void> showMPGBottomSheet({
  required BuildContext context,
  required String title,
  required String buttonText,
  Function()? onPressed,
  String? description,
  Color? backgroundColor,
  double? height,
}) async {
  await showModalBottomSheet<dynamic>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        color: Color(0xff7401FF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (
          OverscrollIndicatorNotification overscroll,
        ) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SizedBox(
          width: 380.w,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.barlow(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15.h),
                    if (description != null)
                      Text(
                        description,
                        style: GoogleFonts.barlow(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: MPGButton(
                    child: Text(
                      buttonText,
                      style: MPGTextStyles.of(context).mpgColoredButton,
                    ),
                    onPressed: () {
                      onPressed?.call();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
