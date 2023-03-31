import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';

class MPGCheckbox extends StatefulWidget {
  const MPGCheckbox({
    super.key,
    required this.onTap,
    this.buttonColor,
    this.checkColor,
  });

  final Function(bool) onTap;
  final Color? buttonColor;
  final Color? checkColor;

  @override
  State<MPGCheckbox> createState() => _MPGCheckboxState();
}

class _MPGCheckboxState extends State<MPGCheckbox> {
  bool _isButtonTermsSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _isButtonTermsSelected = !_isButtonTermsSelected;
        widget.onTap(_isButtonTermsSelected);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: ResponsiveLayout.isDesktop(context)
            ? context.responsiveWidth(24)
            : 24,
        height: ResponsiveLayout.isDesktop(context)
            ? context.responsiveHeight(24)
            : 24,
        decoration: BoxDecoration(
          color: _isButtonTermsSelected
              ? widget.buttonColor ?? Colors.white
              : null,
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.buttonColor ?? Colors.white,
            width: 3,
          ),
        ),
        child: _isButtonTermsSelected
            ? Center(
                child: SvgPicture.asset(
                  MPGAssetsPaths.of(context).checkButton,
                  width: ResponsiveLayout.isDesktop(context)
                      ? context.responsiveWidth(12)
                      : 12,
                  height: ResponsiveLayout.isDesktop(context)
                      ? context.responsiveHeight(10)
                      : 10,
                  color: widget.checkColor ?? Colors.black,
                ),
              )
            : null,
      ),
    );
  }
}
