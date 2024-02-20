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

class PriceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (oldValue.text == r'R$ 0.0') {
      return TextEditingValue.empty;
    }

    final numericRegex = RegExp(r'[\d]');
    final newValueDigits =
        newValue.text.split('').where(numericRegex.hasMatch).join();
    final numValue = int.tryParse(newValueDigits) ?? 0;

    final newText = _formatCurrency(numValue);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _formatCurrency(int value) {
    final stringValue = value.toString();
    final length = stringValue.length;

    if (length <= 2) {
      return 'R\$ 0.$stringValue'.padLeft(6, '0');
    } else {
      final integralPart = stringValue.substring(0, length - 2);
      final fractionalPart = stringValue.substring(length - 2);
      return 'R\$ $integralPart.$fractionalPart'.replaceAllMapped(
        RegExp(r'^(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]}.',
      );
    }
  }
}
