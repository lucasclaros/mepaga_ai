import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';

Future<void> showPlatformEmailAssociationModal({
  required BuildContext context,
  Function()? onAssociateSameEmail,
  Function()? onAssociateDifferentEmail,
}) {
  return showMPGBottomSheet(
    context: context,
    title: 'Acho que posso te ajudar aqui',
    descriptionWidget: RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: GoogleFonts.barlow(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        children: [
          const TextSpan(
            text:
                '''Identificamos que o e-mail que você usou no cadastro está associado a uma conta na plataforma BYMA. Para transferir ingressos da sua conta BYMA para a sua conta Me Paga Aí, clique em: ''',
          ),
          TextSpan(
            text: '''Associar e-mail de cadastro.\n\n''',
            style: GoogleFonts.barlow(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const TextSpan(
            text: '''Se preferir usar outro e-mail, escolha: ''',
          ),
          TextSpan(
            text: '''Associar outro e-mail ''',
            style: GoogleFonts.barlow(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const TextSpan(
            text: '''e siga as instruções de validação por código.\n''',
          ),
        ],
      ),
    ),
    buttonText: 'Associar e-mail de cadastro',
    onPressed: onAssociateSameEmail,
    children: TextButton(
      onPressed: onAssociateDifferentEmail,
      child: Text(
        'Associar outro e-mail',
        style: GoogleFonts.barlow(
          fontSize: 21.sp,
          shadows: [
            const Shadow(
              color: Color(0xFFE3E3E3),
              offset: Offset(0, -2),
            ),
          ],
          fontWeight: FontWeight.w700,
          color: Colors.transparent,
          decoration: TextDecoration.underline,
          decorationColor: const Color(0xFFE3E3E3),
        ),
      ),
    ),
  );
}
