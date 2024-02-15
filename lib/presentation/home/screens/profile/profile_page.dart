import 'package:auto_route/auto_route.dart';
import 'package:domain/use_cases/user_logout_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/common/app_router.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/home/screens/profile/bloc/profile_settings_bloc.dart';
import 'package:mepaga_ai/presentation/home/screens/profile/components/profile_setting_item.dart';
import 'package:mepaga_ai/presentation/home/screens/profile/components/profile_user_info.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  late List<ProfileSettingItem> settingsOptions;

  List<ProfileSettingItem> _buildSettings() => [
        const ProfileSettingItem(text: 'Associar conta a nova plataforma'),
        const ProfileSettingItem(text: 'Alterar dados cadastrais'),
        const ProfileSettingItem(text: 'Histórico de ingressos vendidos'),
        const ProfileSettingItem(text: 'FAQ'),
        const ProfileSettingItem(
          text: 'Sair',
          isLogout: true,
        ),
      ];

  @override
  void initState() {
    super.initState();
    settingsOptions = _buildSettings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileSettingsBloc>(
      create: (context) => ProfileSettingsBloc(
        userLogoutUC: context.read<UserLogoutUC>(),
      ),
      child: BlocConsumer<ProfileSettingsBloc, ProfileSettingsState>(
        listener: (context, state) {
          if (state is ProfileSettingsLoading ||
              state is ProfileSettingsLogoutLoading) {
            setState(() {
              _isLoading = true;
            });
          }

          if (state is ProfileSettingsLogoutSuccess) {
            context.router.replaceAll([const WelcomeRoute()]);
          }
        },
        builder: (context, state) {
          return MPGScaffold(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  Center(
                    child: ProfileUserInfo(
                      isLoading: _isLoading,
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
        },
      ),
    );
  }
}
