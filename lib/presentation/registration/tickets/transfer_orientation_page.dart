import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
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
                    color: const Color(0xFF7B34D7).withOpacity(0.35),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF5815A9),
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
                        '''Para transferir ingressos da sua conta BYMA para sua conta Me Paga Aí é muito simples!\n\nTudo que você precisa fazer é enviar seu ingresso para o e-mail mepagaai@mepagaai.com.\n\nDepois disso, seu ingresso aparecerá aqui. Configure o preço desejado para a venda  e envie o link gerado para a pessoa que irá comprá-lo.\n\nSendo confirmado o pagamento de quem comprou, o valor será depositado diretamente na sua conta.''',
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
                    // TODO(Lucas Claros): Implementar e-mail certo
                    await Clipboard.setData(
                      const ClipboardData(
                        text: 'mepagaai@mepagaai.com',
                      ),
                    ).then(
                      (value) => {
                        showFlushbar(
                          context: context,
                          message: 'E-mail copiado com sucesso!',
                          fontColor: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                      },
                    );
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
