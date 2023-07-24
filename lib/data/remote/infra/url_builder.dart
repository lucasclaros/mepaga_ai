class UrlBuilder {
  static const _hmlApi = 'https://api.mepaga.ai';

  static const _userRegistration = '/users/create';

  static const _otpValidation = '/users/validate-code';

  static const _userLogin = '/users/login';

  static String get endpointUserRegistration => _hmlApi + _userRegistration;

  static String get endpointOtpValidation => _hmlApi + _otpValidation;

  static String get endpointUserLogin => _hmlApi + _userLogin;
}
