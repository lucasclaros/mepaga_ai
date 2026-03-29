// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';

class MPGTextField extends StatefulWidget {
  const MPGTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    required this.isPassword,
    this.textInputAction,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.onTap,
    this.keyboardType,
    this.width,
    this.height,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled,
    this.inputFormatters,
    this.scrollPadding,
    this.initialValue,
    this.readOnly = false,
    this.onSuffixIconPressed,
  });

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final double? width;
  final double? height;
  final String? errorText;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? scrollPadding;
  final String? initialValue;
  final bool readOnly;
  final VoidCallback? onSuffixIconPressed;

  @override
  State<MPGTextField> createState() => _MPGTextFieldState();
}

class _MPGTextFieldState extends State<MPGTextField> {
  bool _hidePassword = true;

  String getPrefixIcon() {
    if (widget.prefixIcon != null) {
      return widget.prefixIcon!;
    }

    if (widget.isPassword) {
      return _hidePassword
          ? MPGAssetsPaths.of(context).passwordIconLocked
          : MPGAssetsPaths.of(context).passwordIconUnlocked;
    } else {
      return MPGAssetsPaths.of(context).emailIcon;
    }
  }

  String getSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon!;
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    final _isFieldEmpty = widget.controller?.text.isEmpty ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.labelText != null,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
              left: 4,
            ),
            child: Text(
              widget.labelText ?? '',
              style: GoogleFonts.barlow(
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 20.sp,
              ),
            ),
          ),
        ),
        SizedBox(
          width: widget.width ?? 295.w,
          child: TextFormField(
            scrollPadding: widget.scrollPadding ??
                EdgeInsets.only(
                  bottom: 50.h,
                ),
            cursorColor: Colors.white,
            onChanged: (text) => {
              setState(() {
                if (widget.onChanged != null) {
                  // ignore: prefer_null_aware_method_calls
                  widget.onChanged!(text);
                }
              }),
            },
            initialValue: widget.initialValue,
            readOnly: widget.readOnly,
            validator: widget.validator,
            onEditingComplete: widget.onEditingComplete,
            onTap: widget.onTap,
            obscureText: widget.isPassword && _hidePassword,
            focusNode: widget.focusNode,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            enabled: widget.enabled,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              filled: true,
              fillColor: surfaceColor,
              prefixIcon: IconButton(
                icon: SvgPicture.asset(
                  getPrefixIcon(),
                  color:
                      widget.errorText == null ? null : errorColor,
                ),
                onPressed: null,
                color:
                    widget.errorText == null ? null : errorColor,
              ),
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      icon: SvgPicture.asset(
                        widget.suffixIcon!,
                      ),
                      onPressed: widget.onSuffixIconPressed,
                    )
                  : widget.isPassword && !_isFieldEmpty
                      ? IconButton(
                          splashRadius: 0.01,
                          icon: SvgPicture.asset(
                            _hidePassword
                                ? MPGAssetsPaths.of(context)
                                    .passwordEyeNotVisible
                                : MPGAssetsPaths.of(context).passwordEyeVisible,
                            color: widget.errorText == null
                                ? null
                                : errorColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        )
                      : null,
              errorText: widget.errorText,
              errorStyle: GoogleFonts.barlow(
                color: errorColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: errorColor,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 17.h,
                horizontal: 10.w,
              ),
              hintText: widget.hintText,
              hintStyle: GoogleFonts.barlow(
                color: textSecondary,
                fontSize: 20.sp,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: surfaceBorder,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ResponsiveLayout.isDesktop(context)
                      ? surfaceBorder
                      : brandPrimary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: errorColor,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            style: GoogleFonts.barlow(
              color: Colors.white,
              fontSize: 20.sp,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
