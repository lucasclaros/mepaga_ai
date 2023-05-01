import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/responsive_layout.dart';

class MPGTextField extends StatefulWidget {
  const MPGTextField({
    super.key,
    this.hintText,
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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        scrollPadding: const EdgeInsets.only(bottom: 50),
        textAlign: ResponsiveLayout.isDesktop(context)
            ? TextAlign.center
            : TextAlign.start,
        cursorColor:
            ResponsiveLayout.isDesktop(context) ? Colors.black38 : Colors.grey,
        cursorWidth: 1,
        onChanged: widget.onChanged,
        validator: widget.validator,
        onEditingComplete: widget.onEditingComplete,
        onTap: widget.onTap,
        obscureText: widget.isPassword,
        focusNode: widget.focusNode,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail_outline_outlined,
            color: widget.errorText == null ? Colors.grey : Colors.red,
          ),
          errorText: widget.errorText,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
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
              color: Color(0xff2a2a2a),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ResponsiveLayout.isDesktop(context)
                  ? Colors.black
                  : Colors.white,
              width: ResponsiveLayout.isDesktop(context) ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: GoogleFonts.barlow(
          color:
              ResponsiveLayout.isDesktop(context) ? Colors.black : Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
