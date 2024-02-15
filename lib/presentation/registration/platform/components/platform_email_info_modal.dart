import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/registration/platform/components/utils.dart';

class PlatformEmailInfoModal extends StatelessWidget {
  const PlatformEmailInfoModal({
    super.key,
    this.onAssociateSameEmail,
    this.onAssociateDifferentEmail,
  });

  final Function()? onAssociateSameEmail;
  final Function()? onAssociateDifferentEmail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPlatformEmailAssociationModal(
          context: context,
          onAssociateSameEmail: onAssociateSameEmail,
          onAssociateDifferentEmail: onAssociateDifferentEmail,
        );
      },
      child: SvgPicture.asset(
        MPGAssetsPaths.of(context).doubtButton,
      ),
    );
  }
}
