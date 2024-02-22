// ignore_for_file: use_decorated_box, lines_longer_than_80_chars

import 'package:auto_route/auto_route.dart';
import 'package:domain/use_cases/get_ticket_info.dart';
import 'package:domain/use_cases/ticket_price_register_uc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mepaga_ai/presentation/common/empty_states/generic_error_empty_state.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:mepaga_ai/presentation/seller/bloc/ticket_configuration_bloc.dart';
import 'package:mepaga_ai/presentation/seller/components/shimmer_ticket.dart';
import 'package:mepaga_ai/presentation/seller/components/ticket_config_fields.dart';
import 'package:mepaga_ai/presentation/seller/components/ticket_widget.dart';

@RoutePage()
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
  void initState() {
    super.initState();
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
                      Visibility(
                        visible: !widget.isBuy,
                        child: TicketConfigFields(
                          ticketId: widget.ticketId,
                          currentPrice: ticket.price,
                          onSuccess: () {
                            context.router.pop(true);
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
