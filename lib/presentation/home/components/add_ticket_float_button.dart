import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:simple_shadow/simple_shadow.dart';

class AddTicketFloatingButton extends StatefulWidget {
  const AddTicketFloatingButton({
    super.key,
    required this.tabStream,
    required this.onTap,
    // this.selected = false,
  });

  final Stream<int> tabStream;
  final VoidCallback onTap;
  // final bool selected;

  @override
  State<AddTicketFloatingButton> createState() =>
      _AddTicketFloatingButtonState();
}

class _AddTicketFloatingButtonState extends State<AddTicketFloatingButton> {
  bool _called = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
        _called = true;
      },
      child: SimpleShadow(
        opacity: 0.25,
        offset: const Offset(0, 4),
        child: StreamBuilder<int>(
          initialData: 0,
          stream: widget.tabStream,
          builder: (context, snapshot) {
            final index = snapshot.data ?? 0;
            return SvgPicture.asset(
              index == 1 && _called
                  ? MPGAssetsPaths.of(context).addTicketSelectedIcon
                  : MPGAssetsPaths.of(context).addTicketIcon,
              width: 90.w,
            );
          },
        ),
      ),
    );
  }
}
