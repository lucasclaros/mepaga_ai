import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/models/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/logistics/components/sw_ticket_border.dart';
import 'package:shimmer/shimmer.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  static const double _cornerRadius = 14;
  static const double _notchRadius = 14;
  // flex 2 image / flex 3 total
  static const double _seamFraction = 2 / 3;

  Widget _buildImageSection(String? picture) {
    const shape = SwTicketBorder(
      radius: _cornerRadius,
      topLeft: false,
      topRight: false,
    );

    // Local asset
    if (picture != null && picture.startsWith('assets/')) {
      return Container(
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: AssetImage(picture),
            fit: BoxFit.cover,
          ),
          shape: shape,
        ),
      );
    }

    // Network image
    return CachedNetworkImage(
      fadeInDuration: const Duration(milliseconds: 750),
      imageUrl: picture ?? '',
      imageBuilder: (context, imageProvider) => Container(
        decoration: ShapeDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          shape: shape,
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: surfaceColor,
        highlightColor: surfaceLight,
        child: Container(
          decoration: const ShapeDecoration(
            color: surfaceLight,
            shape: shape,
          ),
        ),
      ),
      errorWidget: (context, url, error) => _errorPlaceholder(),
    );
  }

  Widget _errorPlaceholder() {
    return const DecoratedBox(
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E1E1E), Color(0xFF2A2A2A)],
        ),
        shape: SwTicketBorder(
          radius: _cornerRadius,
          topLeft: false,
          topRight: false,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.confirmation_number_outlined,
          color: Color(0xFF444444),
          size: 48,
        ),
      ),
    );
  }

  String _formatDate(String? raw) {
    if (raw == null) return '—';
    try {
      final dt = DateTime.parse(raw).toLocal();
      return DateFormat("dd/MM/yyyy 'às' HH'h'mm").format(dt);
    } catch (_) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 392.h,
          width: 230.w,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: _buildImageSection(ticket.party?.picture),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    color: surfaceColor,
                    shape: SwTicketBorder(
                      radius: _cornerRadius,
                      bottomLeft: false,
                      bottomRight: false,
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
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: textPrimary,
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
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: textSecondary,
                          ),
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          'Lote: 2',
                          style: GoogleFonts.barlow(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: textSecondary,
                          ),
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          'Horário: ${_formatDate(ticket.party?.date)}',
                          style: GoogleFonts.barlow(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: textSecondary,
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
        ),
        // Dashed border overlay — traces the full ticket outline including side notches
        const Positioned.fill(
          child: CustomPaint(
            painter: _TicketBorderPainter(
              color: surfaceBorder,
              cornerRadius: _cornerRadius,
              notchRadius: _notchRadius,
              seamFraction: _seamFraction,
            ),
          ),
        ),
      ],
    );
  }
}

class _TicketBorderPainter extends CustomPainter {
  const _TicketBorderPainter({
    required this.color,
    required this.cornerRadius,
    required this.notchRadius,
    required this.seamFraction,
  });

  final Color color;
  final double cornerRadius;
  final double notchRadius;
  final double seamFraction;

  static const double _dashWidth = 5;
  static const double _dashSpace = 4;
  static const double _strokeWidth = 1.5;

  Path _buildOutlinePath(Size size) {
    final r = cornerRadius;
    final n = notchRadius;
    final w = size.width;
    final h = size.height;
    final seam = h * seamFraction;

    // Clockwise outer path, with concave (CCW) notch arcs on each side at the seam
    return Path()
      ..moveTo(r, 0)
      // top edge
      ..lineTo(w - r, 0)
      // top-right convex corner
      ..arcToPoint(Offset(w, r), radius: Radius.circular(r))
      // right edge → right notch (two CCW arcs = full semicircle inward)
      ..lineTo(w, seam - n)
      ..arcToPoint(Offset(w - n, seam), radius: Radius.circular(n), clockwise: false)
      ..arcToPoint(Offset(w, seam + n), radius: Radius.circular(n), clockwise: false)
      // right edge → bottom-right convex corner
      ..lineTo(w, h - r)
      ..arcToPoint(Offset(w - r, h), radius: Radius.circular(r))
      // bottom edge
      ..lineTo(r, h)
      // bottom-left convex corner
      ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r))
      // left edge → left notch (two CCW arcs = full semicircle inward)
      ..lineTo(0, seam + n)
      ..arcToPoint(Offset(n, seam), radius: Radius.circular(n), clockwise: false)
      ..arcToPoint(Offset(0, seam - n), radius: Radius.circular(n), clockwise: false)
      // left edge → top-left convex corner
      ..lineTo(0, r)
      ..arcToPoint(Offset(r, 0), radius: Radius.circular(r))
      ..close();
  }

  Path _dashedPath(Path source) {
    final result = Path();
    for (final metric in source.computeMetrics()) {
      var distance = 0.0;
      var drawing = true;
      while (distance < metric.length) {
        final segment = drawing ? _dashWidth : _dashSpace;
        if (drawing) {
          result.addPath(
            metric.extractPath(distance, distance + segment),
            Offset.zero,
          );
        }
        distance += segment;
        drawing = !drawing;
      }
    }
    return result;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final outline = _buildOutlinePath(size);
    final dashed = _dashedPath(outline);
    canvas.drawPath(
      dashed,
      Paint()
        ..color = color
        ..strokeWidth = _strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_TicketBorderPainter old) => old.color != color;
}
