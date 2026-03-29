import 'dart:async';

import 'package:domain/models/party.dart';
import 'package:domain/models/ticket.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';

class TicketItem extends StatefulWidget {
  const TicketItem({super.key, required this.ticket});

  final Ticket ticket;

  @override
  State<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  Party? get party => widget.ticket.party;
  Ticket get ticket => widget.ticket;

  String _formatDate(String? rawDate) {
    if (rawDate == null) return '';
    try {
      final dt = DateTime.parse(rawDate).toLocal();
      return DateFormat("dd/MM/yyyy 'às' HH'h'mm").format(dt);
    } catch (_) {
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.r);
    return Padding(
      padding: EdgeInsets.only(bottom: 11.h),
      child: Material(
        color: surfaceColor,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          splashColor: brandPrimary.withValues(alpha: 0.08),
          onTap: () async {
            final res = await context.push(
              '/seller-ticket?ticketId=${ticket.id!}',
            );

            if (!mounted) return;
            if (res != null) {
              await Clipboard.setData(
                ClipboardData(
                    text: 'https://mepaga.ai/ticket/${ticket.id}'),
              );
              if (mounted) {
                // ignore: use_build_context_synchronously
                unawaited(showFlushbar(
                  context: context,
                  title: 'Link de venda gerado com sucesso!',
                  message: 'Link copiado para a área de transferência.',
                  fontColor: Colors.white,
                  backgroundColor: successColor,
                ));
              }
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(color: surfaceBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          party?.name ?? 'Festa',
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.barlow(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _formatDate(party?.date),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.barlow(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: textSecondary,
                  size: 22.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
