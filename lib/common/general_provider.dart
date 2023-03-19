import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/themes/app_theme_interface.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class GeneralProvider extends StatefulWidget {
  const GeneralProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GeneralProvider> createState() => _GeneralProviderState();
}

class _GeneralProviderState extends State<GeneralProvider> {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          _buildThemeProvider(),
        ],
        child: widget.child,
      );

  SingleChildWidget _buildThemeProvider() => Provider<AppThemeInterface>(
        create: (_) => MPGAppTheme(),
      );
}
