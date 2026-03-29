// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/use_cases/get_payment_charge_uc.dart';
import 'package:domain/use_cases/get_ticket_info.dart';
import 'package:domain/use_cases/ticket_price_register_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/common/empty_states/generic_error_empty_state.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/mpg_theme.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/logistics/bloc/ticket_configuration_bloc.dart';
import 'package:mepaga_ai/presentation/logistics/buyer/bloc/payment_charge_bloc.dart';
import 'package:mepaga_ai/presentation/logistics/components/shimmer_ticket.dart';
import 'package:mepaga_ai/presentation/logistics/components/ticket_widget.dart';
import 'package:mepaga_ai/presentation/logistics/components/utils.dart';
import 'package:shimmer/shimmer.dart';

class BuyerPage extends StatefulWidget {
  const BuyerPage({
    super.key,
    required this.ticketId,
  });

  final String ticketId;

  @override
  State<BuyerPage> createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  bool _isPaymentLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TicketConfigurationBloc>(
      create: (context) => TicketConfigurationBloc(
        getTicketInfoUC: context.read<GetTicketInfoUC>(),
        ticketPriceRegisterUC: context.read<TicketPriceRegisterUC>(),
        ticketId: widget.ticketId,
        isBuy: true,
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
                  final priceWithFee = ticket?.price ?? 0;
                  final priceWithNoFee = calculatePriceWithoutFee(priceWithFee);

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
                          // Crossfade: skeleton → price info + button
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            child: ticket != null
                                ? _BuyerPriceSection(
                                    key: const ValueKey('price'),
                                    ticketId: widget.ticketId,
                                    platform: ticket.platform,
                                    priceWithFee: priceWithFee,
                                    priceWithNoFee: priceWithNoFee,
                                    isLoading: _isPaymentLoading,
                                    onLoadingChanged: (v) =>
                                        setState(() => _isPaymentLoading = v),
                                  )
                                : const _BuyerFieldsSkeleton(
                                    key: ValueKey('price-skeleton'),
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

// ─── Price section (shown after ticket loads) ────────────────────────────────

class _BuyerPriceSection extends StatelessWidget {
  const _BuyerPriceSection({
    super.key,
    required this.ticketId,
    required this.platform,
    required this.priceWithFee,
    required this.priceWithNoFee,
    required this.isLoading,
    required this.onLoadingChanged,
  });

  final String ticketId;
  final String? platform;
  final double priceWithFee;
  final double priceWithNoFee;
  final bool isLoading;
  final ValueChanged<bool> onLoadingChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutoSizeText(
          'Ingresso: R\$ ${priceWithNoFee.toStringAsFixed(2)}',
          style: GoogleFonts.barlow(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.8),
          ),
          maxLines: 1,
        ),
        SizedBox(height: 10.h),
        AutoSizeText(
          'Taxa: R\$ ${(priceWithFee - priceWithNoFee).toStringAsFixed(2)}',
          style: GoogleFonts.barlow(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.8),
          ),
          maxLines: 1,
        ),
        SizedBox(height: 40.h),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Valor final: ',
                style: GoogleFonts.barlow(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              TextSpan(
                text: 'R\$ ${priceWithFee.toStringAsFixed(2)}',
                style: GoogleFonts.barlow(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFF5800),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 50.h),
        BlocProvider(
          create: (context) => PaymentChargeBloc(
            getPaymentChargeUC: context.read<GetPaymentChargeUC>(),
          ),
          child: BlocConsumer<PaymentChargeBloc, PaymentChargeState>(
            listener: (context, state) {
              onLoadingChanged(state is GetPaymentChargeLoading);
              if (state is GetPaymentChargeSuccess) {
                context.push(
                  '/payment',
                  extra: {
                    'platform': platform ?? 'sympla',
                    'paymentCharge': state.paymentCharge,
                  },
                );
              }
            },
            builder: (context, state) {
              return MPGButton(
                gradient: MPGColors.of(context).mpgButtonColoredGradient,
                isLoading: isLoading,
                onPressed: () {
                  if (UserMM().email.isNotEmpty) {
                    context.read<PaymentChargeBloc>().add(
                          GetPaymentChargeEvent(
                            ticketId: ticketId,
                            transferEmail: UserMM().email,
                          ),
                        );
                  } else {
                    context.push(
                      '/buyer-email',
                      extra: {
                        'ticketId': ticketId,
                        'platform': platform ?? 'sympla',
                        'onEmailAdded': (email) {
                          context.read<PaymentChargeBloc>().add(
                                GetPaymentChargeEvent(
                                  ticketId: ticketId,
                                  transferEmail: email,
                                ),
                              );
                        },
                      },
                    );
                  }
                },
                child: Text(
                  'Realizar pagamento',
                  style: MPGTextStyles.of(context).mpgColoredButton,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── Skeleton (shown while ticket is loading) ─────────────────────────────────

class _BuyerFieldsSkeleton extends StatelessWidget {
  const _BuyerFieldsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2A2A2A),
      highlightColor: const Color(0xFF3A3A3A),
      child: Column(
        children: [
          // "Ingresso: R$ X" skeleton
          Container(
            width: 180.w,
            height: 18.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(height: 10.h),
          // "Taxa: R$ X" skeleton
          Container(
            width: 130.w,
            height: 15.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(height: 40.h),
          // "Valor final: R$ X" skeleton
          Container(
            width: 200.w,
            height: 18.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(height: 50.h),
          // Button skeleton
          Container(
            width: 295.w,
            height: 55.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ],
      ),
    );
  }
}
