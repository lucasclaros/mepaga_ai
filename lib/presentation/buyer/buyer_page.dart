// ignore_for_file: use_decorated_box, lines_longer_than_80_chars

import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/models/ticket.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/buyer/ticket_widget.dart';
import 'package:mepaga_ai/presentation/common/input_formatters.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/common/utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_text/styled_text.dart';

@RoutePage()
class BuyerPage extends StatefulWidget {
  const BuyerPage({
    super.key,
    this.ticket,
    @PathParam('ticketId') this.ticketId,
  });

  final Ticket? ticket;
  final String? ticketId;

  @override
  State<BuyerPage> createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage> {
  Ticket? get ticket => widget.ticket;
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  double _priceWithFee = 0;
  bool _showingFlush = false;

  double calculatePriceWithFee(double price) {
    if (price == 0) return 0;

    final fee = max(3, price * 0.1);
    return price + fee;
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (widget.ticketId != null) {
        showMPGConfirmationModal(
          c: context,
          title: 'Acesso por um link externo!',
          message:
              'Identificamos um ticket-ID em seu link. Logo mais essa função de retorno de ticket por ID será implementada!',
          confirmButtonText: 'Entendi',
          cancelButtonText: 'Fechar',
        );
      }
    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MPGScaffold(
      child: SingleChildScrollView(
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    stops: const [0, 0.5, 0.8, 1],
                    colors: [
                      const Color(0xff09FBD3),
                      const Color(0xff09FBD3),
                      const Color(0xff09FBD3).withOpacity(0.03),
                      Colors.transparent,
                    ],
                  ),
                ),
                height: 392.h,
                width: 230.w,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CachedNetworkImage(
                        fadeInDuration: const Duration(milliseconds: 750),
                        imageUrl: ticket?.party?.picture ?? '',
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              color: Colors.white,
                              shape: const SwTicketBorder(
                                radius: 20,
                                topLeft: false,
                                topRight: false,
                                borderColor: Colors.black,
                              ),
                            ),
                          );
                        },
                        placeholder: (context, url) {
                          return Shimmer.fromColors(
                            baseColor: Colors.purple.shade700,
                            highlightColor: Colors.purple.shade500,
                            period: const Duration(milliseconds: 500),
                            child: Container(
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: SwTicketBorder(
                                  radius: 20,
                                  topLeft: false,
                                  topRight: false,
                                ),
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  MPGAssetsPaths.of(context).ticketPlaceholder,
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: const SwTicketBorder(
                                radius: 20,
                                topLeft: false,
                                topRight: false,
                                borderColor: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF516379).withOpacity(0.8),
                              const Color(0xFF2b3e59),
                              const Color(0xFF031432),
                            ],
                            stops: const [0, 0.4, 1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          shape: const SwTicketBorder(
                            radius: 20,
                            bottomLeft: false,
                            bottomRight: false,
                            borderColor: Colors.black,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 15.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: AutoSizeText(
                                  ticket?.party?.name ?? 'Festa',
                                  style: GoogleFonts.barlow(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFEBEBEB)
                                        .withOpacity(0.87),
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Spacer(),
                              AutoSizeText(
                                'Local: Banana eventos',
                                style: GoogleFonts.barlow(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      const Color(0xFFEBEBEB).withOpacity(0.87),
                                ),
                                maxLines: 1,
                              ),
                              // const Spacer(),
                              AutoSizeText(
                                'Lote: 2',
                                style: GoogleFonts.barlow(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      const Color(0xFFEBEBEB).withOpacity(0.87),
                                ),
                                maxLines: 1,
                              ),
                              AutoSizeText(
                                'Horário: ${ticket?.party?.date ?? '23h00 - 04h00'}',
                                style: GoogleFonts.barlow(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      const Color(0xFFEBEBEB).withOpacity(0.87),
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
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
                              description:
                                  'Para que seja possível operar o Me Paga Aí é necessário que haja um pequeno lucro sobre toda venda realizada pelo app.\n\n'
                                  'A taxa é atual é 10% por ingresso, isso significa que se você quiser vender um ingresso a '
                                  'R\$30,00 (por exemplo) o preço que será passado para o comprador será R\$33,00.\n\n'
                                  'Assim, você recebe o quanto está pedindo enquanto oferecemos a segurança necessária.\n\n'
                                  r'A taxa mínima é R$3,00.',
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
                onPressed: () {
                  if (_textController.text.isNotEmpty && !_showingFlush) {
                    _showingFlush = true;
                    showFlushbar(
                      context: context,
                      message: 'Chamada para API de cadastro!',
                      fontColor: Colors.white,
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 1, milliseconds: 500),
                    ).then((_) {
                      _showingFlush = false;
                    });
                  }
                },
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
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (!_showingFlush) {
                            _showingFlush = true;
                            showFlushbar(
                              context: context,
                              message: 'Chamada para API de resgate!',
                              fontColor: Colors.white,
                              backgroundColor: Colors.green,
                              duration:
                                  const Duration(seconds: 1, milliseconds: 500),
                            ).then((_) {
                              _showingFlush = false;
                            });
                          }
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
