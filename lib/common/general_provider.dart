import 'package:dio/dio.dart';
import 'package:domain/logger.dart';
import 'package:domain/use_cases/get_cache_value_uc.dart';
import 'package:domain/use_cases/set_cache_value_uc.dart';
import 'package:domain/use_cases/user_login_uc.dart';
import 'package:domain/use_cases/user_logout_uc.dart';
import 'package:flutter/material.dart';
import 'package:mepaga_ai/data/remote/data_source/auth_data_source.dart';
import 'package:mepaga_ai/data/remote/infra/auth_interceptor.dart';
import 'package:mepaga_ai/data/repositories/data_repository.dart';
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
          _buildErrorLoggerProvider(),
          _buildThemeProvider(),
          _buildDioProvider(),
          ..._buildRDSProvider(),
          ..._buildRepositoriesProvider(),
          ..._buildUseCasesProvider(),
        ],
        child: widget.child,
      );

  SingleChildWidget _buildThemeProvider() => Provider<AppThemeInterface>(
        create: (_) => MPGAppTheme(),
      );

  SingleChildWidget _buildErrorLoggerProvider() => Provider<ErrorLogger>(
        create: (_) => widget.errorLogger,
      );

  SingleChildWidget _buildDioProvider() => Provider<Dio>(
        create: (context) {
          final dio = Dio()
            ..interceptors.add(
              AuthInterceptor(),
            );
          return dio;
        },
      );

  List<SingleChildWidget> _buildRDSProvider() => [
        ProxyProvider<Dio, AuthRDS>(
          update: (_, dio, __) => AuthRDS(dio: dio),
        )
      ];

  List<SingleChildWidget> _buildRepositoriesProvider() => [
        ProxyProvider<AuthRDS, AuthRepository>(
          update: (_, rds, __) => AuthRepository(rds: rds),
        )
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
        ProxyProvider2<ErrorLogger, AuthRepository, GetCacheValueUC>(
          update: (_, logger, repository, __) => GetCacheValueUC(
            logger: logger,
            repository: repository,
          ),
        ),
        ProxyProvider2<ErrorLogger, AuthRepository, SetCacheValueUC>(
          update: (_, logger, repository, __) => SetCacheValueUC(
            logger: logger,
            repository: repository,
          ),
        ),
      ];
}
