import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mepaga_ai/presentation/logistics/components/sw_ticket_border.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTicket extends StatelessWidget {
  const ShimmerTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2A2A2A),
      highlightColor: const Color(0xFF3A3A3A),
      child: SizedBox(
        height: 392.h,
        width: 230.w,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: const ShapeDecoration(
                  color: Color(0xFF2A2A2A),
                  shape: SwTicketBorder(
                    radius: 14,
                    topLeft: false,
                    topRight: false,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const ShapeDecoration(
                  color: Color(0xFF2A2A2A),
                  shape: SwTicketBorder(
                    radius: 14,
                    bottomLeft: false,
                    bottomRight: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
