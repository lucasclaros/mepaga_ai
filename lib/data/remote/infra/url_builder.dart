class UrlBuilder {
  static const _hmlApi = 'http://api.mepaga.ai:5000';

  static const _emailValidation = '/validate/user';

  static const _otpValidation = '/validate/code';

  static String get endpointEmailValidation => _hmlApi + _emailValidation;

  static String get endpointOtpValidation => _hmlApi + _otpValidation;
}
