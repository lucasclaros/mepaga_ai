class UrlBuilder {
  static const _hmlApi = 'https://api.mepaga.ai';

  static const _userRegistration = '/user/register';

  static const _otpValidation = '/user/validate-code';

  static const _userLogin = '/user/login';

  static String get endpointUserRegistration => _hmlApi + _userRegistration;

  static String get endpointOtpValidation => _hmlApi + _otpValidation;

  static String get endpointUserLogin => _hmlApi + _userLogin;
}
