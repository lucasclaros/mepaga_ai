class UrlBuilder {
  static const _hmlApi = 'http://api.mepaga.ai';

  static const _emailValidation = '/byma/validate-email';

  static const _otpValidation = '/users/validate-code';

  static String get endpointEmailValidation => _hmlApi + _emailValidation;

  static String get endpointOtpValidation => _hmlApi + _otpValidation;
}
