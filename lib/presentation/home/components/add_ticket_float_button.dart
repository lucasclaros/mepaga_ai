import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:simple_shadow/simple_shadow.dart';

class AddTicketFloatingButton extends StatefulWidget {
  const AddTicketFloatingButton({
    super.key,
    required this.onTap,
    this.selected = false,
  });

  final VoidCallback onTap;
  final bool selected;

  @override
  State<AddTicketFloatingButton> createState() =>
      _AddTicketFloatingButtonState();
}

class _AddTicketFloatingButtonState extends State<AddTicketFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: SimpleShadow(
        opacity: 0.25,
        offset: const Offset(0, 4),
        child: SvgPicture.asset(
          widget.selected
              ? MPGAssetsPaths.of(context).addTicketSelectedIcon
              : MPGAssetsPaths.of(context).addTicketIcon,
          width: 90.w,
        ),
      ),
    );
  }
}
