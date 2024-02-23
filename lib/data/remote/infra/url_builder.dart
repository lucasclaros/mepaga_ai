class UrlBuilder {
  static const _hmlApi = 'https://api.mepaga.ai';

  static const _userRegistration = '/user/register';

  static const _otpValidation = '/user/validate-code';

  static const _userLogin = '/user/login';

  static const _userInfo = '/user';

  static String get endpointUserRegistration => _hmlApi + _userRegistration;

  static String get endpointOtpRegisterEmailValidation =>
      _hmlApi + _otpValidation;

  static String get endpointUserLogin => _hmlApi + _userLogin;

  static String get endpointUserInfo => _hmlApi + _userInfo;

  static String get endpointUserTickets => '$_hmlApi$_userInfo/tickets';

  static String get endpointUserPlatforms => '$_hmlApi$_userInfo/platforms';

  static String get endpointPlatformRegister =>
      '$_hmlApi$_userInfo/platform/add';

  static String endpointPlatformCheck(String platform) =>
      '$_hmlApi$_userInfo/platform/$platform';

  static String get endpointPlatformEmailValidation =>
      '$_hmlApi$_userInfo/platform/validate';

  static String get endpointRegisterPixKey => '$_hmlApi$_userInfo/pix-key';

  static String endpointTicketInfo({
    required String ticketId,
    bool isBuy = false,
  }) =>
      isBuy
          ? '$_hmlApi/ticket/$ticketId'
          : '$_hmlApi$_userInfo/ticket/$ticketId';

  static String endpointTicketPrice(String ticketId) =>
      '$_hmlApi/tickets/$ticketId';

  static String get endpointBymaEmail => '$_hmlApi/byma/validate';
}
