// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/use_cases/get_payment_charge_uc.dart';
import 'package:domain/use_cases/get_ticket_info.dart';
import 'package:domain/use_cases/ticket_price_register_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/common/app_router.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:mepaga_ai/presentation/common/empty_states/generic_error_empty_state.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/logistics/bloc/ticket_configuration_bloc.dart';
import 'package:mepaga_ai/presentation/logistics/buyer/bloc/payment_charge_bloc.dart';
import 'package:mepaga_ai/presentation/logistics/components/shimmer_ticket.dart';
import 'package:mepaga_ai/presentation/logistics/components/ticket_widget.dart';
import 'package:mepaga_ai/presentation/logistics/components/utils.dart';

@RoutePage()
class BuyerPage extends StatefulWidget {
  const BuyerPage({
    super.key,
    @PathParam('ticketId') required this.ticketId,
  });

  final String ticketId;

  @override
  State<BuyerPage> createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TicketConfigurationBloc>(
      create: (context) => TicketConfigurationBloc(
        getTicketInfoUC: context.read<GetTicketInfoUC>(),
        ticketPriceRegisterUC: context.read<TicketPriceRegisterUC>(),
        ticketId: widget.ticketId,
      ),
      child: MPGScaffold(
        child: BlocConsumer<TicketConfigurationBloc, TicketConfigurationState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetTicketInfoLoading) {
              return const Center(
                child: ShimmerTicket(),
              );
            }

            if (state is GetTicketInfoSuccess) {
              final ticket = state.ticket;
              final _priceWithFee = ticket.price ?? 0;
              final _priceWithNoFee = calculatePriceWithoutFee(_priceWithFee);

              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.router.pop(),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                vertical: 16.h,
                                horizontal: 18.w,
                              ),
                              child: SvgPicture.asset(
                                MPGAssetsPaths.of(context).backButton,
                                width: 24.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TicketWidget(ticket: ticket),
                      SizedBox(height: 25.h),
                      AutoSizeText(
                        'Ingresso: R\$ ${_priceWithNoFee.toStringAsFixed(2)}',
                        style: GoogleFonts.barlow(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 10.h),
                      AutoSizeText(
                        'Taxa: R\$ ${(_priceWithFee - _priceWithNoFee).toStringAsFixed(2)}',
                        style: GoogleFonts.barlow(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 40.h),
                      // AutoSizeText(
                      //   'Valor final: R\$ ${_priceWithFee.toStringAsFixed(2)}',
                      //   style: GoogleFonts.barlow(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w700,
                      //     color: const Color(0xFFFF5800),
                      //   ),
                      //   maxLines: 1,
                      // ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Valor final: ',
                              style: GoogleFonts.barlow(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            TextSpan(
                              text: 'R\$ ${_priceWithFee.toStringAsFixed(2)}',
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
                          getPaymentChargeUC:
                              context.read<GetPaymentChargeUC>(),
                        ),
                        child:
                            BlocConsumer<PaymentChargeBloc, PaymentChargeState>(
                          listener: (context, state) {
                            setState(() {
                              _isLoading = state is GetPaymentChargeLoading;
                            });

                            if (state is GetPaymentChargeSuccess) {
                              context.router.push(
                                PaymentRoute(
                                  platform: ticket.platform ?? 'byma',
                                  paymentCharge: state.paymentCharge,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return MPGButton(
                              gradient: MPGColors.of(context)
                                  .mpgButtonColoredGradient,
                              onPressed: () {
                                if (UserMM().email.isNotEmpty) {
                                  context.read<PaymentChargeBloc>().add(
                                        GetPaymentChargeEvent(
                                          ticketId: widget.ticketId,
                                          transferEmail: UserMM().email,
                                        ),
                                      );
                                } else {
                                  context.router.push(
                                    AddBuyerEmailRoute(
                                      ticketId: widget.ticketId,
                                      platform: ticket.platform ?? 'byma',
                                      onEmailAdded: (email) {
                                        context.read<PaymentChargeBloc>().add(
                                              GetPaymentChargeEvent(
                                                ticketId: widget.ticketId,
                                                transferEmail: email,
                                              ),
                                            );
                                      },
                                    ),
                                  );
                                }
                              },
                              isLoading: _isLoading,
                              child: Text(
                                'Realizar pagamento',
                                style:
                                    MPGTextStyles.of(context).mpgColoredButton,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              );
            }

            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GenericErrorEmptyState(
                  message: 'Ops... Ocorreu um erro ao carregar este ingresso',
                  onRetry: () {
                    context.read<TicketConfigurationBloc>().add(
                          GetTicketInfo(ticketId: widget.ticketId),
                        );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
