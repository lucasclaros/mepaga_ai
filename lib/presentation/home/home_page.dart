import 'package:domain/use_cases/get_user_info_uc.dart';
import 'package:domain/use_cases/get_user_tickets.dart';
import 'package:domain/use_cases/user_logout_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/common/routing.dart';
import 'package:mepaga_ai/presentation/common/empty_states/no_tickets_empty_state.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:mepaga_ai/presentation/home/bloc/home_bloc.dart';
import 'package:mepaga_ai/presentation/home/components/shimmer_ticket_list.dart';
import 'package:mepaga_ai/presentation/home/components/ticket_item.dart';
import 'package:mepaga_ai/presentation/home/components/welcome_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.showFlushbar,
  });

  final bool showFlushbar;

  static Widget create({bool showFlushbar = false}) => BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(
          getUserInfoUC: context.read<GetUserInfoUC>(),
          getUserTicketsUC: context.read<GetUserTicketsUC>(),
          userLogoutUC: context.read<UserLogoutUC>(),
        ),
        child: HomePage(
          showFlushbar: showFlushbar,
        ),
      );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  @override
  void initState() {
    if (widget.showFlushbar) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showFlushbar(
          context: context,
          message: 'Login realizado com sucesso!',
          fontColor: Colors.white,
          backgroundColor: Colors.green,
        );
      });
    }
    super.initState();
    context.read<HomeBloc>().add(UserInfo());
  }

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 39.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WelcomeHeader(isLoading: _isLoading),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white.withOpacity(0.8),
                    size: 36.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 39.h),
            Text(
              'Acompanhe seus ingressos',
              style: GoogleFonts.barlow(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 39.h),
            MPGButton(
              width: double.infinity,
              onPressed: () {
                context.read<HomeBloc>().add(UserLogout());
              },
              child: Text(
                'Logout',
                style: MPGTextStyles.of(context).mpgColoredButton,
              ),
            ),
            SizedBox(height: 39.h),
            Expanded(
              child: BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {
                  setState(() {
                    _isLoading = state is HomeLoading || state is LogoutLoading;
                  });

                  if (state is LogoutSuccess) {
                    GoRouter.of(context).pushLogoutPage();
                  }
                },
                builder: (context, state) {
                  if (state is HomeLoading || state is LogoutLoading) {
                    return const ShimmerTicketList();
                  }

                  if (state is HomeSuccessEmpty) {
                    return const NoTicketsEmptyState();
                  }

                  if (state is HomeSuccess) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.tickets.length * 3,
                      itemBuilder: (context, index) {
                        return TicketItem(
                          party: state.tickets[index % 9].party,
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
