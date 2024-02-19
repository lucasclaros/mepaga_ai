import 'package:flutter/services.dart';

class CPFFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(
      RegExp(r'\D'),
      '',
    ); // Remove todos os caracteres não numéricos

    if (text.length > 3) {
      text = '${text.substring(0, 3)}.${text.substring(3)}';
    }
    if (text.length > 7) {
      text = '${text.substring(0, 7)}.${text.substring(7)}';
    }
    if (text.length > 11) {
      text = '${text.substring(0, 11)}-${text.substring(11)}';
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class CNPJFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(
      RegExp(r'\D'),
      '',
    ); // Remove todos os caracteres não numéricos

    if (text.length > 2) {
      text = '${text.substring(0, 2)}.${text.substring(2)}';
    }
    if (text.length > 6) {
      text = '${text.substring(0, 6)}.${text.substring(6)}';
    }
    if (text.length > 10) {
      text = '${text.substring(0, 10)}/${text.substring(10)}';
    }
    if (text.length > 15) {
      text = '${text.substring(0, 15)}-${text.substring(15)}';
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class TelefoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(
      RegExp(r'\D'),
      '',
    ); // Remove todos os caracteres não numéricos
    if (text.isEmpty) {
      return TextEditingValue.empty;
    }

    if (text.length <= 2) {
      return TextEditingValue(text: '($text');
    } else if (text.length <= 6) {
      return TextEditingValue(
        text: '(${text.substring(0, 2)}) ${text.substring(2)}',
      );
    } else if (text.length <= 10) {
      return TextEditingValue(
        text:
            '(${text.substring(0, 2)}) ${text.substring(2, 6)}-${text.substring(6)}',
      );
    } else {
      return TextEditingValue(
        text:
            '(${text.substring(0, 2)}) ${text.substring(2, 7)}-${text.substring(7, 11)}',
      );
    }
  }
}
