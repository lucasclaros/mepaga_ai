class UrlBuilder {
  static const _hmlApi = 'https://api.mepaga.ai';

  static const _userRegistration = '/user/register';

  static const _otpValidation = '/user/validate-code';

  static const _userLogin = '/user/login';

  static const _userInfo = '/user';

  static String get endpointUserRegistration => _hmlApi + _userRegistration;

  static String get endpointOtpValidation => _hmlApi + _otpValidation;

  static String get endpointUserLogin => _hmlApi + _userLogin;

  static String get endpointUserInfo => _hmlApi + _userInfo;

  static String get endpointUserTickets => '$_hmlApi$_userInfo/tickets';

  static String get endpointUserPlatforms => '$_hmlApi$_userInfo/platforms';
}
