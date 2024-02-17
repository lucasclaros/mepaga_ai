import 'package:flutter/services.dart';
import 'package:mepaga_ai/presentation/common/input_formatters.dart';

final formatters = {
  'cpf': [
    LengthLimitingTextInputFormatter(14),
    FilteringTextInputFormatter.digitsOnly,
    CPFFormatter(),
  ],
  'cnpj': [
    LengthLimitingTextInputFormatter(18),
    FilteringTextInputFormatter.digitsOnly,
    CNPJFormatter(),
  ],
  'phone': [
    LengthLimitingTextInputFormatter(15),
    TelefoneInputFormatter(),
  ],
  'email': null,
  'random': null,
};

TextInputType getInputType(String type) {
  switch (type) {
    case 'cpf':
    case 'cnpj':
    case 'phone':
      return TextInputType.phone;
    case 'email':
      return TextInputType.emailAddress;
    default:
      return TextInputType.text;
  }
}
