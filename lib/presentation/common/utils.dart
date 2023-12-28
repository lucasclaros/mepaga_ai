import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

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
