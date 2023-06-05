// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';

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

  @override
  State<MPGTextField> createState() => _MPGTextFieldState();
}

class _MPGTextFieldState extends State<MPGTextField> {
  bool _hidePassword = true;

  String getPrefixIcon() {
    if (widget.isPassword) {
      return _hidePassword
          ? MPGAssetsPaths.of(context).passwordIconLocked
          : MPGAssetsPaths.of(context).passwordIconUnlocked;
    } else {
      return MPGAssetsPaths.of(context).emailIcon;
    }
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
                color: Colors.white.withOpacity(0.8),
                fontSize: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextFormField(
            scrollPadding: const EdgeInsets.only(bottom: 50),
            cursorColor: Colors.white,
            onChanged: (text) => {
              setState(() {
                if (widget.onChanged != null) {
                  // ignore: prefer_null_aware_method_calls
                  widget.onChanged!(text);
                }
              })
            },
            validator: widget.validator,
            onEditingComplete: widget.onEditingComplete,
            onTap: widget.onTap,
            obscureText: widget.isPassword && _hidePassword,
            focusNode: widget.focusNode,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black.withOpacity(0.5),
              prefixIcon: IconButton(
                splashRadius: 0.01,
                icon: SvgPicture.asset(
                  getPrefixIcon(),
                  color:
                      widget.errorText == null ? null : const Color(0xffd30000),
                ),
                onPressed: null,
                color:
                    widget.errorText == null ? null : const Color(0xffd30000),
              ),
              suffixIcon: widget.isPassword && !_isFieldEmpty
                  ? IconButton(
                      splashRadius: 0.01,
                      icon: SvgPicture.asset(
                        _hidePassword
                            ? MPGAssetsPaths.of(context).passwordEyeNotVisible
                            : MPGAssetsPaths.of(context).passwordEyeVisible,
                        color: widget.errorText == null
                            ? null
                            : const Color(0xffd30000),
                      ),
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                    )
                  : null,
              errorText: widget.errorText,
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffd30000),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 15,
              ),
              hintText: widget.hintText,
              hintStyle: GoogleFonts.barlow(
                color: Colors.grey,
                fontSize: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xff9c9c9c),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ResponsiveLayout.isDesktop(context)
                      ? Colors.black
                      : const Color(0xFF7401FF),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xffd30000),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            style: GoogleFonts.barlow(
              color: ResponsiveLayout.isDesktop(context)
                  ? Colors.black
                  : Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
