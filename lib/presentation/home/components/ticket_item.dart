import 'package:domain/models/party.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:simple_shadow/simple_shadow.dart';

class TicketItem extends StatefulWidget {
  const TicketItem({super.key, required this.party});

  final Party? party;

  @override
  State<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  Party? get party => widget.party;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 11.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
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
                    party?.date ?? '00/00/0000',
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
          InkWell(
            onTap: () {
              // showOkAlertDialog(
              //   context: context,
              //   style: AdaptiveStyle.adaptive,
              //   title: 'Calma fi',
              //   message: 'Ainda vou mexer nisso.\nLogo logo fica pronto!',
              // );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    title: Text(
                      'CALMA FI',
                      style: GoogleFonts.barlow(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    content: Text(
                      'Ainda tô mexendo nisso.\nLogo logo fica pronto!',
                      style: GoogleFonts.barlow(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: SimpleShadow(
              opacity: 0.25,
              offset: const Offset(0, 4),
              child: SvgPicture.asset(
                MPGAssetsPaths.of(context).forwardIcon,
                height: 43.h,
                clipBehavior: Clip.antiAlias,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
