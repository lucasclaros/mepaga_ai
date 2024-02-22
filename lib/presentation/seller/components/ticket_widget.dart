import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/models/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/seller/components/sw_ticket_border.dart';
import 'package:shimmer/shimmer.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          stops: const [0, 0.5, 0.8, 1],
          colors: [
            const Color(0xff09FBD3),
            const Color(0xff09FBD3),
            const Color(0xff09FBD3).withOpacity(0.03),
            Colors.transparent,
          ],
        ),
      ),
      height: 392.h,
      width: 230.w,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 750),
              imageUrl: ticket.party?.picture ?? '',
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    shape: const SwTicketBorder(
                      radius: 20,
                      topLeft: false,
                      topRight: false,
                      borderColor: Colors.black,
                    ),
                  ),
                );
              },
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: Colors.purple.shade700,
                  highlightColor: Colors.purple.shade500,
                  child: Container(
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: SwTicketBorder(
                        radius: 20,
                        topLeft: false,
                        topRight: false,
                      ),
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        MPGAssetsPaths.of(context).ticketPlaceholder,
                      ),
                      fit: BoxFit.cover,
                    ),
                    shape: const SwTicketBorder(
                      radius: 20,
                      topLeft: false,
                      topRight: false,
                      borderColor: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF516379).withOpacity(0.8),
                    const Color(0xFF2b3e59),
                    const Color(0xFF031432),
                  ],
                  stops: const [0, 0.4, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: const SwTicketBorder(
                  radius: 20,
                  bottomLeft: false,
                  bottomRight: false,
                  borderColor: Colors.black,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 15.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: AutoSizeText(
                        ticket.party?.name ?? 'Festa',
                        style: GoogleFonts.barlow(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFEBEBEB).withOpacity(0.87),
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    AutoSizeText(
                      'Local: Banana eventos',
                      style: GoogleFonts.barlow(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFEBEBEB).withOpacity(0.87),
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Lote: 2',
                      style: GoogleFonts.barlow(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFEBEBEB).withOpacity(0.87),
                      ),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'Horário: ${ticket.party?.date ?? '23h00 - 04h00'}',
                      style: GoogleFonts.barlow(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFEBEBEB).withOpacity(0.87),
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
