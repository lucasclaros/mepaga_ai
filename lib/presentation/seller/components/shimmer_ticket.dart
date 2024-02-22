import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mepaga_ai/presentation/seller/components/sw_ticket_border.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTicket extends StatelessWidget {
  const ShimmerTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.white.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 392.h,
            width: 230.w,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: const SwTicketBorder(
                        radius: 20,
                        topLeft: false,
                        topRight: false,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: const SwTicketBorder(
                        radius: 20,
                        bottomLeft: false,
                        bottomRight: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        ],
      ),
    );
  }
}
