import 'package:flutter/services.dart';
import 'package:mepaga_ai/presentation/common/input_formatters.dart';

final formatters = {
  'CPF': [
    LengthLimitingTextInputFormatter(14),
    FilteringTextInputFormatter.digitsOnly,
    CPFFormatter(),
  ],
  'CNPJ': [
    LengthLimitingTextInputFormatter(18),
    FilteringTextInputFormatter.digitsOnly,
    CNPJFormatter(),
  ],
  'PHONE': [
    LengthLimitingTextInputFormatter(15),
    TelefoneInputFormatter(),
  ],
  'EMAIL': null,
};

TextInputType getInputType(String type) {
  switch (type) {
    case 'CPF':
    case 'CNPJ':
    case 'PHONE':
      return TextInputType.phone;
    case 'EMAIL':
      return TextInputType.emailAddress;
    default:
      return TextInputType.text;
  }
}
