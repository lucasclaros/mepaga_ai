import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/home/screens/profile/components/profile_setting_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static Widget create() => const ProfilePage();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final settingsOptions = const [
    ProfileSettingItem(text: 'Associar conta a nova plataforma'),
    ProfileSettingItem(text: 'Alterar dados cadastrais'),
    ProfileSettingItem(text: 'Histórico de ingressos vendidos'),
    ProfileSettingItem(text: 'FAQ'),
    ProfileSettingItem(text: 'Sair', isLogout: true),
  ];

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Center(
              child: Column(
                children: [
                  Text(
                    UserMM().name,
                    style: GoogleFonts.barlow(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    UserMM().email,
                    style: GoogleFonts.barlow(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(height: 48.h),
            Text(
              'Configurações de usuário',
              style: GoogleFonts.barlow(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 40.h),
            Expanded(
              child: ListView.builder(
                // separatorBuilder: (_, __) => SizedBox(height: 20.h),
                shrinkWrap: true,
                itemCount: settingsOptions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: settingsOptions[index],
                  );
                },
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
