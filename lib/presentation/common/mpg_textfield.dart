import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/responsivity.dart';

class MPGTextField extends StatefulWidget {
  const MPGTextField({
    super.key,
    this.hintText,
    this.controller,
    required this.isPassword,
    this.textInputAction,
    this.onChanged,
    this.focusNode,
    this.onEditingComplete,
    this.keyboardType,
  });

  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;

  @override
  State<MPGTextField> createState() => _MPGTextFieldState();
}

class _MPGTextFieldState extends State<MPGTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.grey,
      cursorWidth: 1,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      obscureText: widget.isPassword,
      focusNode: widget.focusNode,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.responsiveWidth(22),
          vertical: context.responsiveHeight(20),
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
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: GoogleFonts.barlow(
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }
}
