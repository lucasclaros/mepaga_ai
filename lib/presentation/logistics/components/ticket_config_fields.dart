// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:domain/use_cases/get_ticket_info.dart';
import 'package:domain/use_cases/ticket_price_register_uc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/input_formatters.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:mepaga_ai/presentation/logistics/bloc/ticket_configuration_bloc.dart';
import 'package:mepaga_ai/presentation/logistics/components/utils.dart';
import 'package:styled_text/styled_text.dart';

class TicketConfigFields extends StatefulWidget {
  const TicketConfigFields({
    super.key,
    required this.ticketId,
    required this.currentPrice,
    this.onSuccess,
  });

  final String ticketId;
  final double? currentPrice;
  final VoidCallback? onSuccess;

  @override
  State<TicketConfigFields> createState() => _TicketConfigFieldsState();
}

class _TicketConfigFieldsState extends State<TicketConfigFields> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  double _priceWithFee = 0;
  double _priceWithNoFee = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _priceWithFee = (widget.currentPrice ?? 0) > 1.5 ? widget.currentPrice! : 0;
    _priceWithNoFee = calculatePriceWithoutFee(_priceWithFee);

    if (_priceWithNoFee > 0) {
      _textController.value = PriceInputFormatter().formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(
          text: _priceWithNoFee > 1.5
              ? _priceWithNoFee.toStringAsFixed(2)
              : _priceWithFee.toStringAsFixed(2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketConfigurationBloc(
        getTicketInfoUC: context.read<GetTicketInfoUC>(),
        ticketPriceRegisterUC: context.read<TicketPriceRegisterUC>(),
      ),
      child: BlocConsumer<TicketConfigurationBloc, TicketConfigurationState>(
        listener: (context, state) async {
          if (state is TicketAlreadySold) {
            await showFlushbar(
              context: context,
              message: 'Ingresso já vendido',
              backgroundColor: Colors.red,
              fontColor: Colors.white,
            );
          }

          setState(() {
            _isLoading = state is RegisterTicketInfoLoading;
          });

          if (state is RegisterTicketInfoSuccess) {
            widget.onSuccess?.call();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              MPGTextField(
                controller: _textController,
                focusNode: _focusNode,
                isPassword: false,
                hintText: 'Preço do ingresso',
                prefixIcon: MPGAssetsPaths.of(context).walletIcon,
                inputFormatters: [PriceInputFormatter()],
                keyboardType: TextInputType.number,
                scrollPadding: EdgeInsets.only(
                  bottom: 40.h,
                ),
                onEditingComplete: () {
                  _focusNode.unfocus();
                  setState(() {
                    if (_textController.text.isEmpty) {
                      _priceWithFee = 0;
                    } else {
                      final price = _textController.text.replaceAll(r'R$', '');
                      _priceWithFee = calculatePriceWithFee(
                        double.tryParse(price) ?? 0,
                      );
                    }
                  });
                },
                onChanged: (priceRaw) {
                  final price = priceRaw.replaceAll(r'R$', '');
                  setState(() {
                    if (price.isEmpty) {
                      _priceWithFee = 0;
                    } else {
                      _priceWithFee = calculatePriceWithFee(
                        double.tryParse(price) ?? 0,
                      );
                    }
                  });
                },
              ),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'O ingresso será vendido a ',
                          style: GoogleFonts.barlow(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        TextSpan(
                          text: 'R\$${_priceWithFee.toStringAsFixed(2)} ',
                          style: GoogleFonts.barlow(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFB6E17),
                          ),
                        ),
                      ],
                    ),
                  ),
                  StyledText(
                    text: '<doubt/>',
                    tags: {
                      'doubt': StyledTextWidgetTag(
                        GestureDetector(
                          onTap: () {
                            showMPGBottomSheet(
                              context: context,
                              title: 'Por que o preço está maior?',
                              descriptionWidget: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'Cobramos uma taxa de 10% para cobrir os custos operacionais e permitir que suas vendas sejam feitas de forma segura.\n A taxa mínima é de ',
                                        style: GoogleFonts.barlow(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'R\$1,50.\n\n',
                                        style: GoogleFonts.barlow(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFFF5800),
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'Você receberá o valor que digitou no ingresso, e a taxa será cobrada apenas do comprador.',
                                        style: GoogleFonts.barlow(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              buttonText: 'Entendi',
                            );
                          },
                          child: SvgPicture.asset(
                            MPGAssetsPaths.of(context).doubtButton,
                          ),
                        ),
                        size: Size.square(min(25.w, 25)),
                      ),
                    },
                    style: GoogleFonts.barlow(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              MPGButton(
                gradient: _textController.text.isNotEmpty
                    ? MPGColors.of(context).mpgButtonColoredGradient
                    : MPGColors.of(context).mpgButtonColoredGradientDisabled,
                onPressed: () async {
                  if (_textController.text.isNotEmpty) {
                    context.read<TicketConfigurationBloc>().add(
                          RegisterTicketInfo(
                            ticketPrice: _priceWithFee,
                            ticketId: widget.ticketId,
                          ),
                        );
                  }
                },
                isLoading: _isLoading,
                child: Text(
                  'Continuar',
                  style: _textController.text.isNotEmpty
                      ? MPGTextStyles.of(context).mpgColoredButton
                      : MPGTextStyles.of(context).mpgColoredButtonDisabled,
                ),
              ),
              SizedBox(height: 30.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Resgatar ingresso',
                      style: MPGTextStyles.of(context).alreadyHasAccountMessage,
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
