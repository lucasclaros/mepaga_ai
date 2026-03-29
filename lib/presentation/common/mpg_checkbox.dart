import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';

class MPGCheckbox extends StatefulWidget {
  const MPGCheckbox({
    super.key,
    required this.onTap,
    this.buttonColor,
    this.checkColor,
    this.isSelected = false,
  });

  final Function()? onTap;
  final bool isSelected;
  final Color? buttonColor;
  final Color? checkColor;

  @override
  State<MPGCheckbox> createState() => _MPGCheckboxState();
}

class _MPGCheckboxState extends State<MPGCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: min(25.w, 25),
        height: min(25.h, 25),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: widget.isSelected ? widget.buttonColor ?? Colors.white : null,
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.buttonColor ?? Colors.white,
            width: 2,
          ),
        ),
        child: widget.isSelected
            ? Center(
                child: SvgPicture.asset(MPGAssetsPaths.of(context).checkButton),
              )
            : null,
      ),
    );
  }
}
