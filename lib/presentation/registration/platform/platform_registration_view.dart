import 'package:flutter/material.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';

class PlatformRegistrationView extends StatefulWidget {
  const PlatformRegistrationView({super.key});

  static Widget create() => const PlatformRegistrationView();

  @override
  State<PlatformRegistrationView> createState() =>
      _PlatformRegistrationViewState();
}

class _PlatformRegistrationViewState extends State<PlatformRegistrationView>
    with AutomaticKeepAliveClientMixin<PlatformRegistrationView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const MPGScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            MPGHeader(
              title: 'Cadastro de Plataforma',
              isBackButtonVisible: false,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
