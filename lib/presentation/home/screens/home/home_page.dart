// ignore_for_file: use_decorated_box, lines_longer_than_80_chars

import 'package:domain/models/ticket.dart';
import 'package:domain/use_cases/get_user_info_uc.dart';
import 'package:domain/use_cases/get_user_platforms_uc.dart';
import 'package:domain/use_cases/get_user_tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/common/empty_states/fetch_data_empty_state.dart';
import 'package:mepaga_ai/presentation/common/empty_states/no_tickets_empty_state.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:mepaga_ai/presentation/home/components/shimmer_ticket_list.dart';
import 'package:mepaga_ai/presentation/home/components/ticket_item.dart';
import 'package:mepaga_ai/presentation/common/mpg_fade_in.dart';
import 'package:mepaga_ai/presentation/home/components/welcome_header.dart';
import 'package:mepaga_ai/config/app_config.dart';
import 'package:mepaga_ai/presentation/home/screens/home/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.showFlushbar = false});

  final bool showFlushbar;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.showFlushbar) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showFlushbar(
          context: context,
          message: 'Login realizado com sucesso!',
          fontColor: Colors.white,
          backgroundColor: successColor,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        getUserInfoUC: context.read<GetUserInfoUC>(),
        getUserTicketsUC: context.read<GetUserTicketsUC>(),
        getUserPlatformsUC: context.read<GetUserPlatformsUC>(),
      )..add(UserInfo()),
      child: MPGScaffold(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MPGFadeIn(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 39.h),
                    WelcomeHeader(isLoading: _isLoading),
                    if (kMockApiCalls) ...[
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: brandPrimary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: brandPrimary.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.play_circle_outline_rounded,
                              color: brandPrimary,
                              size: 14.w,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              'Modo Demo',
                              style: GoogleFonts.barlow(
                                color: brandPrimary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: 32.h),
                    Visibility(
                      visible: !_isLoading,
                      child: Text(
                        'Acompanhe seus ingressos',
                        style: GoogleFonts.barlow(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocConsumer<HomeBloc, PagingState<int, Ticket>>(
                  listener: (context, state) {
                    final isPaymentRouteOpen =
                        GoRouterState.of(context).uri.toString() == '/pix-registration';

                    setState(() {
                      _isLoading = state.isLoading;
                    });

                    final loadedSuccessfully = !state.isLoading &&
                        state.error == null &&
                        state.pages != null &&
                        state.pages!.isNotEmpty;

                    if (loadedSuccessfully && UserMM().pixKey == null && !isPaymentRouteOpen) {
                      showMPGBottomSheet(
                        context: context,
                        title:
                            'Cadastre sua chave pix para poder receber o dinheiro das suas vendas',
                        buttonText: 'Cadastrar chave',
                        isDismissable: false,
                        enableDrag: false,
                        canPop: false,
                        onPressed: () {
                          context.push(
                            '/pix-registration',
                            extra: {
                              'onSuccess': () {
                                SchedulerBinding.instance.addPostFrameCallback(
                                  (_) {
                                    showFlushbar(
                                      context: context,
                                      message: 'Chave pix cadastrada com sucesso!',
                                      fontColor: Colors.white,
                                      backgroundColor: Colors.green,
                                    );
                                  },
                                );
                              },
                            },
                          );
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return RefreshIndicator(
                      color: Colors.white,
                      backgroundColor: surfaceColor,
                      onRefresh: () async {
                        context.read<HomeBloc>().add(UserInfo());
                        // UserInfo is dispatched on Bloc creation.
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Scrollbar(
                          controller: _scrollController,
                          thickness: 2.w,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: PagedListView<int, Ticket>(
                              state: state,
                              shrinkWrap: true,
                              scrollController: _scrollController,
fetchNextPage: () {
                                context.read<HomeBloc>().add(UserInfo());
                              },
                              builderDelegate: PagedChildBuilderDelegate<Ticket>(
                                itemBuilder: (context, ticket, index) {
                                  return TicketItem(ticket: ticket);
                                },
                                firstPageProgressIndicatorBuilder: (context) =>
                                    const ShimmerTicketList(),
                                newPageProgressIndicatorBuilder: (context) =>
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10.h,
                                        bottom: 30.h,
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          height: 22.w,
                                          width: 22.w,
                                          child: CircularProgressIndicator(
                                            color: Colors.white.withValues(alpha: 
                                              0.8,
                                            ),
                                            strokeWidth: 2.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                newPageErrorIndicatorBuilder: (context) =>
                                    const Center(
                                      child: Text(
                                        'Ocorreu um erro ao carregar os ingressos',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                firstPageErrorIndicatorBuilder: (context) =>
                                    Column(
                                      children: [
                                        const FetchDataEmptyState(),
                                        SizedBox(height: 20.h),
                                        MPGButton(
                                          gradient: MPGColors.of(
                                            context,
                                          ).mpgButtonWhitedGradient,
                                          onPressed: () async {
                                            context.read<HomeBloc>().add(
                                              UserInfo(initialLoading: true),
                                            );
                                          },
                                          child: Text(
                                            'Tentar novamente',
                                            style: MPGTextStyles.of(
                                              context,
                                            ).mpgWhitedButton,
                                          ),
                                        ),
                                      ],
                                    ),
                                noItemsFoundIndicatorBuilder: (context) => Padding(
                                  padding: EdgeInsets.only(top: 50.h),
                                  child: Column(
                                    children: [
                                      const NoTicketsEmptyState(),
                                      const SizedBox(height: 20),
                                      MPGButton(
                                        gradient: MPGColors.of(
                                          context,
                                        ).mpgButtonWhitedGradient,
                                        onPressed: () {
                                          // UserInfo is dispatched on Bloc creation.
                                          context.read<HomeBloc>().add(
                                            UserInfo(initialLoading: true),
                                          );
                                        },
                                        child: Text(
                                          'Atualizar',
                                          style: MPGTextStyles.of(
                                            context,
                                          ).mpgWhitedButton,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
