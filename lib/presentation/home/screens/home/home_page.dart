// ignore_for_file: use_decorated_box, lines_longer_than_80_chars

import 'package:auto_route/auto_route.dart';
import 'package:domain/models/ticket.dart';
import 'package:domain/use_cases/get_user_info_uc.dart';
import 'package:domain/use_cases/get_user_platforms_uc.dart';
import 'package:domain/use_cases/get_user_tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mepaga_ai/common/app_router.dart';
import 'package:mepaga_ai/presentation/common/empty_states/fetch_data_empty_state.dart';
import 'package:mepaga_ai/presentation/common/empty_states/no_tickets_empty_state.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
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
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            title: Text(
                              'Aqui vai abrir a tela de histórico de ingressos!',
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
                    icon: Icon(
                      Icons.history,
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
              Expanded(
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
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
                    }

                    if (state is RegisterPlatform) {
                      showMPGBottomSheet(
                        context: context,
                        title: 'Cadastre sua plataforma',
                        description: '',
                        buttonText: 'Cadastrar',
                        height: 250.h,
                        onPressed: () {
                          context.navigateTo(const PlatformRegistrationRoute());
                        },
                      );
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
                      child: Scrollbar(
                        thickness: 2.w,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 40.h,
                            right: 4.w,
                            left: 4.w,
                          ),
                          child: PagedListView<int, Ticket>(
                            shrinkWrap: true,
                            pagingController: _pagingController,
                            builderDelegate: PagedChildBuilderDelegate<Ticket>(
                              itemBuilder: (context, ticket, index) {
                                return TicketItem(
                                  party: ticket.party,
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
