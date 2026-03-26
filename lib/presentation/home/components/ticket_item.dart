import 'package:domain/models/party.dart';
import 'package:domain/models/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:simple_shadow/simple_shadow.dart';

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
    return Container(
      margin: EdgeInsets.only(bottom: 11.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: InkWell(
        onTap: () async {
          final res = await context.push(
            '/seller-ticket?ticketId=${ticket.id!}',
          );

          if (!mounted) return;
          if (res != null) {
            await Clipboard.setData(
              ClipboardData(text: 'https://mepaga.ai/ticket/${ticket.id}'),
            );
            if (!mounted) return;
            showFlushbar(
              context: context,
              title: 'Link de venda gerado com sucesso!',
              message: 'Link copiado para a área de transferência.',
              fontColor: Colors.white,
              backgroundColor: Colors.green,
            );
          }
        },
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          party?.name ?? 'Festa',
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.barlow(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          _formatDate(party?.date),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.barlow(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SimpleShadow(
                  opacity: 0.25,
                  offset: const Offset(0, 4),
                  child: SvgPicture.asset(
                    MPGAssetsPaths.of(context).forwardIcon,
                    height: 43.h,
                    clipBehavior: Clip.antiAlias,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
