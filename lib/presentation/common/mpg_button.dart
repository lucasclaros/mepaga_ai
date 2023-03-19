import 'package:flutter/material.dart';

class MPGButton extends StatelessWidget {
  const MPGButton({
    super.key,
    this.width,
    this.height,
    this.elevation,
    this.shape,
    this.onPressed,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
  });

  final double? width;
  final double? height;
  final double? elevation;
  final OutlinedBorder? shape;
  final VoidCallback? onPressed;
  final String text;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(
              Size(
                width ?? double.infinity,
                height ?? 60,
              ),
            ),
            elevation: MaterialStateProperty.all(
              elevation,
            ),
            shape: MaterialStateProperty.all(
              shape ??
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
            ),
            backgroundColor: MaterialStateProperty.all(
              backgroundColor,
            ),
          ),
          child: Text(
            text,
          ),
        ),
      );
}
