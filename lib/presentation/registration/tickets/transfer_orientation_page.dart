import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';

class TransferOrientationPage extends StatefulWidget {
  const TransferOrientationPage({super.key, required this.platform});

  final String platform;

  @override
  State<TransferOrientationPage> createState() =>
      TransferOrientationPageState();
}

class TransferOrientationPageState extends State<TransferOrientationPage> {
  final _controller = ScrollController();
  final _tranfsEmail = 'transferencia@mepaga.ai';

  String _instructions(String platform) {
    switch (platform.toLowerCase()) {
      case 'sympla':
        return 'Para transferir ingressos da sua conta Sympla para o Me Paga Aí é muito simples!\n\n'
            '1. Acesse sympla.com.br e faça login.\n'
            '2. Vá em "Meus ingressos" e localize o evento desejado.\n'
            '3. Clique em "Transferir ingresso" e insira o e-mail abaixo.\n\n'
            'Após a transferência, seu ingresso aparecerá aqui automaticamente. '
            'Configure o preço desejado e compartilhe o link de venda.\n\n'
            'Confirmado o pagamento, o valor é depositado direto na sua conta.';
      case 'eventim':
        return 'Para transferir ingressos da sua conta Eventim para o Me Paga Aí:\n\n'
            '1. Acesse eventim.com.br e faça login.\n'
            '2. Vá em "Meus pedidos" e selecione o ingresso.\n'
            '3. Escolha "Transferir" e informe o e-mail abaixo.\n\n'
            'Após a transferência, seu ingresso aparecerá aqui automaticamente. '
            'Configure o preço e envie o link ao comprador.\n\n'
            'Confirmado o pagamento, o valor é depositado direto na sua conta.';
      case 'ticket360':
        return 'Para transferir ingressos da sua conta Ticket360 para o Me Paga Aí:\n\n'
            '1. Acesse ticket360.com.br e faça login.\n'
            '2. Em "Meus ingressos", selecione o evento desejado.\n'
            '3. Toque em "Transferir" e insira o e-mail abaixo.\n\n'
            'Após a transferência, seu ingresso aparecerá aqui automaticamente. '
            'Defina o preço de venda e compartilhe o link.\n\n'
            'Confirmado o pagamento, o valor é depositado direto na sua conta.';
      default:
        return 'Transfira seu ingresso para o e-mail abaixo na plataforma de origem.\n\n'
            'Após a transferência, seu ingresso aparecerá aqui. '
            'Configure o preço e envie o link ao comprador.\n\n'
            'Confirmado o pagamento, o valor é depositado direto na sua conta.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: Column(
        children: [
          MPGHeader(
            title: 'Orientações para ${widget.platform.toUpperCase()}',
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Container(
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: brandPrimary.withValues(alpha: 0.4),
                      width: 3,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 12.h,
                  ),
                  height: max(420, 420.h),
                  child: Scrollbar(
                    controller: _controller,
                    thickness: 2,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _controller,
                      child: Text(
                        _instructions(widget.platform),
                        style: GoogleFonts.barlow(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFE9E9E9),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                MPGButton(
                  width: double.infinity,
                  child: Text(
                    'Copiar e-mail de transferência',
                    style: MPGTextStyles.of(context).mpgColoredButton,
                  ),
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(
                        text: _tranfsEmail,
                      ),
                    );
                    if (!mounted) return;
                    // ignore: use_build_context_synchronously
                    unawaited(showFlushbar(
                      context: context,
                      message: 'E-mail copiado com sucesso!',
                      fontColor: Colors.white,
                      backgroundColor: Colors.green,
                    ));
                  },
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
