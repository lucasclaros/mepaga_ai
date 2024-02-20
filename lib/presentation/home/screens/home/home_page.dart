// ignore_for_file: use_decorated_box, lines_longer_than_80_chars

import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:domain/models/ticket.dart';
import 'package:domain/use_cases/get_user_info_uc.dart';
import 'package:domain/use_cases/get_user_platforms_uc.dart';
import 'package:domain/use_cases/get_user_tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mepaga_ai/common/app_router.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/common/empty_states/fetch_data_empty_state.dart';
import 'package:mepaga_ai/presentation/common/empty_states/no_tickets_empty_state.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:mepaga_ai/presentation/home/components/shimmer_ticket_list.dart';
import 'package:mepaga_ai/presentation/home/components/ticket_item.dart';
import 'package:mepaga_ai/presentation/home/components/welcome_header.dart';
import 'package:mepaga_ai/presentation/home/screens/home/bloc/home_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.showFlushbar = false,
  });

  final bool showFlushbar;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  int _requests = 3;
  final _pagingController = PagingController<int, Ticket>(
    firstPageKey: 0,
  );
  final _scrollController = ScrollController();

  String getEmoji() {
    final emojis = [
      MPGAssetsPaths.of(context).partyEmoji,
      MPGAssetsPaths.of(context).partyingFace,
      MPGAssetsPaths.of(context).faceWithSunglasses,
      // MPGAssetsPaths.of(context).ballonEmoji,
      MPGAssetsPaths.of(context).beerEmoji,
    ];
    return emojis[Random().nextInt(emojis.length)];
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

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

    // _pagingController.addPageRequestListener((_) {
    //   context.read<HomeBloc>().add(UserInfo());
    //   _requests--;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        getUserInfoUC: context.read<GetUserInfoUC>(),
        getUserTicketsUC: context.read<GetUserTicketsUC>(),
        getUserPlatformsUC: context.read<GetUserPlatformsUC>(),
      ),
      child: MPGScaffold(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 39.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 9,
                    child: WelcomeHeader(isLoading: _isLoading),
                  ),
                  SizedBox(width: 50.w),
                  SizedBox(
                    height: 40.h,
                    width: 40.w,
                    child: Visibility(
                      visible: !_isLoading,
                      child: SvgPicture.asset(
                        getEmoji(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 39.h),
              Visibility(
                visible: !_isLoading,
                child: Text(
                  'Acompanhe seus ingressos',
                  style: GoogleFonts.barlow(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
              Expanded(
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
                    final isPaymentRouteOpen = context.router.current.name ==
                        PaymentRegistrationRoute.name;
                    setState(() {
                      _isLoading = state is HomeLoading;
                    });

                    if (state is HomeSuccess) {
                      _requests == 0
                          ? _pagingController.appendLastPage(
                              state.tickets,
                            )
                          : _pagingController.appendPage(
                              state.tickets,
                              _pagingController.nextPageKey,
                            );
                      if (UserMM().pixKey == null && !isPaymentRouteOpen) {
                        showMPGBottomSheet(
                          context: context,
                          title:
                              'Cadastre sua chave pix para poder receber o dinheiro das suas vendas',
                          buttonText: 'Cadastrar chave',
                          isDismissable: false,
                          enableDrag: false,
                          canPop: false,
                          onPressed: () {
                            context.router.push(
                              PaymentRegistrationRoute(
                                onSuccess: () {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    showFlushbar(
                                      context: context,
                                      message:
                                          'Chave pix cadastrada com sucesso!',
                                      fontColor: Colors.white,
                                      backgroundColor: Colors.green,
                                    );
                                  });
                                },
                              ),
                            );
                          },
                        ).then((value) {
                          context.read<HomeBloc>().add(UserInfo());
                        });
                      }
                    }

                    if (state is HomeError) {
                      _pagingController.error = state.message;
                    }
                  },
                  builder: (context, state) {
                    return RefreshIndicator(
                      color: Colors.white,
                      backgroundColor: const Color(0xFF7401FF),
                      onRefresh: () async {
                        _pagingController.refresh();
                        context.read<HomeBloc>().add(UserInfo());
                        _requests = 3;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Scrollbar(
                          controller: _scrollController,
                          thickness: 2.w,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: PagedListView<int, Ticket>(
                              shrinkWrap: true,
                              scrollController: _scrollController,
                              pagingController: _pagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<Ticket>(
                                itemBuilder: (context, ticket, index) {
                                  return TicketItem(
                                    ticket: ticket,
                                  );
                                },
                                firstPageProgressIndicatorBuilder: (context) =>
                                    const ShimmerTicketList(),
                                newPageProgressIndicatorBuilder: (context) =>
                                    Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.h, bottom: 30.h),
                                  child: Center(
                                    child: SizedBox(
                                      height: 22.w,
                                      width: 22.w,
                                      child: CircularProgressIndicator(
                                        color: Colors.white.withOpacity(0.8),
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
                                      gradient: MPGColors.of(context)
                                          .mpgButtonWhitedGradient,
                                      onPressed: () async {
                                        _pagingController.refresh();
                                      },
                                      child: Text(
                                        'Tentar novamente',
                                        style: MPGTextStyles.of(context)
                                            .mpgWhitedButton,
                                      ),
                                    ),
                                  ],
                                ),
                                noItemsFoundIndicatorBuilder: (context) =>
                                    Padding(
                                  padding: EdgeInsets.only(top: 50.h),
                                  child: const NoTicketsEmptyState(),
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
              SizedBox(height: 35.h),
            ],
          ),
        ),
      ),
    );
  }
}
