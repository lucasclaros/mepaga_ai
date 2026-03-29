// ignore_for_file: use_decorated_box, lines_longer_than_80_chars

import 'package:domain/use_cases/get_ticket_info.dart';
import 'package:domain/use_cases/ticket_price_register_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mepaga_ai/presentation/common/empty_states/generic_error_empty_state.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/logistics/bloc/ticket_configuration_bloc.dart';
import 'package:mepaga_ai/presentation/logistics/components/shimmer_ticket.dart';
import 'package:mepaga_ai/presentation/logistics/components/ticket_config_fields.dart';
import 'package:mepaga_ai/presentation/logistics/components/ticket_widget.dart';
import 'package:shimmer/shimmer.dart';

class TicketSellerPage extends StatefulWidget {
  const TicketSellerPage({
    super.key,
    required this.ticketId,
    this.isBuy = false,
  });

  final String ticketId;
  final bool isBuy;

  @override
  State<TicketSellerPage> createState() => _TicketSellerPageState();
}

class _TicketSellerPageState extends State<TicketSellerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TicketConfigurationBloc>(
      create: (context) => TicketConfigurationBloc(
        getTicketInfoUC: context.read<GetTicketInfoUC>(),
        ticketPriceRegisterUC: context.read<TicketPriceRegisterUC>(),
        ticketId: widget.ticketId,
      ),
      child: MPGScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button always visible — never jumps in
            IconButton(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: textPrimary,
                size: 22.w,
              ),
              onPressed: () => context.pop(),
            ),
            Expanded(
              child: BlocConsumer<TicketConfigurationBloc,
                  TicketConfigurationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetTicketInfoError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: GenericErrorEmptyState(
                          message:
                              'Ops... Ocorreu um erro ao carregar este ingresso',
                          onRetry: () {
                            context.read<TicketConfigurationBloc>().add(
                                  GetTicketInfo(ticketId: widget.ticketId),
                                );
                          },
                        ),
                      ),
                    );
                  }

                  final ticket =
                      state is GetTicketInfoSuccess ? state.ticket : null;

                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          // Crossfade: shimmer → ticket, same size, same position
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 450),
                            child: ticket != null
                                ? TicketWidget(
                                    key: const ValueKey('ticket'),
                                    ticket: ticket,
                                  )
                                : const ShimmerTicket(
                                    key: ValueKey('shimmer'),
                                  ),
                          ),
                          SizedBox(height: 25.h),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            child: ticket != null
                                ? TicketConfigFields(
                                    key: const ValueKey('fields'),
                                    ticketId: widget.ticketId,
                                    currentPrice: ticket.price,
                                    onSuccess: () => context.pop(true),
                                  )
                                : const _SellerFieldsSkeleton(
                                    key: ValueKey('fields-skeleton'),
                                  ),
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SellerFieldsSkeleton extends StatelessWidget {
  const _SellerFieldsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2A2A2A),
      highlightColor: const Color(0xFF3A3A3A),
      child: Column(
        children: [
          // TextField skeleton
          Container(
            width: 295.w,
            height: 56.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          SizedBox(height: 25.h),
          // "O ingresso será vendido a R$X" text skeleton
          Container(
            width: 220.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(height: 30.h),
          // Button skeleton
          Container(
            width: 295.w,
            height: 55.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          SizedBox(height: 30.h),
          // "Resgatar ingresso" link skeleton
          Container(
            width: 130.w,
            height: 14.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ],
      ),
    );
  }
}
