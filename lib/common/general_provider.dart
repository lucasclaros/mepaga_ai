import 'package:dio/dio.dart';
import 'package:domain/logger.dart';
import 'package:domain/use_cases/cache_jwt_uc.dart';
import 'package:domain/use_cases/check_platform_uc.dart';
import 'package:domain/use_cases/get_jwt_uc.dart';
import 'package:domain/use_cases/get_user_info_uc.dart';
import 'package:domain/use_cases/get_user_platforms_uc.dart';
import 'package:domain/use_cases/get_user_tickets.dart';
import 'package:domain/use_cases/otp_verification_uc.dart';
import 'package:domain/use_cases/pix_register_uc.dart';
import 'package:domain/use_cases/platform_register_uc.dart';
import 'package:domain/use_cases/user_login_uc.dart';
import 'package:domain/use_cases/user_logout_uc.dart';
import 'package:domain/use_cases/user_register_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';
import 'package:mepaga_ai/data/remote/data_source/auth_data_source.dart';
import 'package:mepaga_ai/data/remote/data_source/user_data_source.dart';
import 'package:mepaga_ai/data/remote/infra/auth_interceptor.dart';
import 'package:mepaga_ai/data/repositories/data_repository.dart';
import 'package:mepaga_ai/data/repositories/user_repository.dart';
import 'package:mepaga_ai/presentation/common/themes/app_theme_interface.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class GeneralProvider extends StatefulWidget {
  const GeneralProvider({
    super.key,
    required this.child,
    required this.errorLogger,
  });

  final ErrorLogger errorLogger;
  final Widget child;

  @override
  State<GeneralProvider> createState() => _GeneralProviderState();
}

class _GeneralProviderState extends State<GeneralProvider> {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          _buildDependenciesProvider(),
          _buildErrorLoggerProvider(),
          _buildThemeProvider(),
          ..._buildCDSProvider(),
          _buildDioProvider(),
          ..._buildRDSProvider(),
          ..._buildRepositoriesProvider(),
          ..._buildUseCasesProvider(),
        ],
        child: widget.child,
      );

  SingleChildWidget _buildDependenciesProvider() =>
      Provider<FlutterSecureStorage>(
        create: (_) => const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        ),
      );

  SingleChildWidget _buildThemeProvider() => Provider<AppThemeInterface>(
        create: (_) => MPGAppTheme(),
      );

  SingleChildWidget _buildErrorLoggerProvider() => Provider<ErrorLogger>(
        create: (_) => widget.errorLogger,
      );

  SingleChildWidget _buildDioProvider() => ProxyProvider<OnlineCDS, Dio>(
        update: (_, cds, __) {
          final dio = Dio()
            ..interceptors.add(
              AuthInterceptor(onlineCDS: cds),
            );
          return dio;
        },
      );

  List<SingleChildWidget> _buildCDSProvider() => [
        ProxyProvider<FlutterSecureStorage, OnlineCDS>(
          update: (_, secure, __) => OnlineCDS(secureStorage: secure),
        ),
      ];

  List<SingleChildWidget> _buildRDSProvider() => [
        ProxyProvider<Dio, AuthRDS>(
          update: (_, dio, __) => AuthRDS(dio: dio),
        ),
        ProxyProvider<Dio, UserRDS>(
          update: (_, dio, __) => UserRDS(dio: dio),
        ),
      ];

  List<SingleChildWidget> _buildRepositoriesProvider() => [
        ProxyProvider2<AuthRDS, OnlineCDS, AuthRepository>(
          update: (_, rds, cds, __) => AuthRepository(
            rds: rds,
            cds: cds,
          ),
        ),
        ProxyProvider<UserRDS, UserRepository>(
          update: (_, rds, __) => UserRepository(rds: rds),
        ),
      ];

  List<SingleChildWidget> _buildUseCasesProvider() => [
        ProxyProvider2<ErrorLogger, AuthRepository, UserLoginUC>(
          update: (_, logger, repository, __) => UserLoginUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, AuthRepository, UserLogoutUC>(
          update: (_, logger, repository, __) => UserLogoutUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, AuthRepository, GetJwtUC>(
          update: (_, logger, repository, __) => GetJwtUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, AuthRepository, CacheJwtUC>(
          update: (_, logger, repository, __) => CacheJwtUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, AuthRepository, UserRegisterUC>(
          update: (_, logger, repository, __) => UserRegisterUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, AuthRepository, OTPVerificationUC>(
          update: (_, logger, repository, __) => OTPVerificationUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, UserRepository, GetUserInfoUC>(
          update: (_, logger, repository, __) => GetUserInfoUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, UserRepository, GetUserTicketsUC>(
          update: (_, logger, repository, __) => GetUserTicketsUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, UserRepository, GetUserPlatformsUC>(
          update: (_, logger, repository, __) => GetUserPlatformsUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, UserRepository, PlatformRegisterUC>(
          update: (_, logger, repository, __) => PlatformRegisterUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, UserRepository, CheckPlatformUC>(
          update: (_, logger, repository, __) => CheckPlatformUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, UserRepository, PixRegisterUC>(
          update: (_, logger, repository, __) => PixRegisterUC(
            logger: logger,
            repository: repository,
          ),
        ),
      ];
}
