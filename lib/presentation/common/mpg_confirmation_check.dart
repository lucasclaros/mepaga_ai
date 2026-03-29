import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mepaga_ai/presentation/common/mpg_checkbox.dart';

class MPGConfirmationCheck extends StatefulWidget {
  const MPGConfirmationCheck({
    super.key,
    required this.content,
    this.onTap,
    this.isSelected = false,
  });

  final Function()? onTap;
  final bool isSelected;
  final Widget content;

  @override
  State<MPGConfirmationCheck> createState() => _MPGConfirmationCheckState();
}

class _MPGConfirmationCheckState extends State<MPGConfirmationCheck> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(300.w, 400),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 25,
      ),
      child: Row(
        children: [
          MPGCheckbox(
            onTap: widget.onTap,
            isSelected: widget.isSelected,
          ),
          const SizedBox(width: 8),
          Expanded(child: widget.content),
        ],
      ),
    );
  }
}
