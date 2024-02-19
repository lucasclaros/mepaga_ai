import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
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

String? validateInput(String type, String value) {
  switch (type) {
    case 'CPF':
      return validateCPF(value);
    case 'CNPJ':
      return validateCNPJ(value);
    case 'PHONE':
      return validatePhone(value);
    case 'EMAIL':
      return validateEmail(value);
    default:
      return null;
  }
}

String? validateCPF(String cpf) {
  return CPFValidator.isValid(cpf) ? null : 'CPF inválido';
}

String? validateCNPJ(String cnpj) {
  return CNPJValidator.isValid(cnpj) ? null : 'CNPJ inválido';
}

String? validatePhone(String phone) {
  return phone.length == 15 ? null : 'Telefone inválido';
}

String? validateEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)
      ? null
      : 'Email inválido';
}
