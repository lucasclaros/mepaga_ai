// ignore_for_file: lines_longer_than_80_chars

import 'package:domain/use_cases/pix_register_uc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mepaga_ai/presentation/common/mpg_button.dart';
import 'package:mepaga_ai/presentation/common/mpg_header.dart';
import 'package:mepaga_ai/presentation/common/mpg_scaffold.dart';
import 'package:mepaga_ai/presentation/common/mpg_textfield.dart';
import 'package:mepaga_ai/presentation/common/themes/assets/mpg_assets_paths.dart';
import 'package:mepaga_ai/presentation/common/themes/colors/mpg_colors.dart';
import 'package:mepaga_ai/presentation/common/themes/text_styles/mpg_text_styles.dart';
import 'package:mepaga_ai/presentation/registration/payment/bloc/payment_registration_bloc.dart';
import 'package:mepaga_ai/presentation/registration/payment/utils.dart';

class PaymentRegistrationPage extends StatefulWidget {
  const PaymentRegistrationPage({
    super.key,
    required this.onSuccess,
  });

  final VoidCallback onSuccess;

  @override
  State<PaymentRegistrationPage> createState() =>
      _PaymentRegistrationPageState();
}

class _PaymentRegistrationPageState extends State<PaymentRegistrationPage> {
  String? _selectedType;
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  String? _errorText;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentRegistrationBloc>(
      create: (context) => PaymentRegistrationBloc(
        pixRegisterUC: context.read<PixRegisterUC>(),
      ),
      child: PopScope(
        canPop: false,
        child: MPGScaffold(
          child:
              BlocConsumer<PaymentRegistrationBloc, PaymentRegistrationState>(
            listener: (context, state) {
              setState(() {
                _isLoading = state is RegisterPixLoading;
              });

              if (state is RegisterPixSuccess) {
                widget.onSuccess();
                context.pop();
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const MPGHeader(
                      title: 'Cadastro Pix',
                      isBackButtonVisible: false,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Column(
                        children: [
                          SizedBox(height: 30.h),
                          Text(
                            'Utilize uma chave Pix existente para receber os fundos da venda dos ingressos.',
                            style: GoogleFonts.barlow(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 45.h),
                          DropdownButtonFormField2(
                            hint: Text(
                              'Tipo de chave Pix',
                              style: GoogleFonts.barlow(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedType = value;
                              });
                              _textController.clear();
                              _errorText = null;
                            },
                            onSaved: (String? value) {
                              setState(() {
                                _selectedType = value;
                              });
                            },
                            barrierColor: Colors.transparent.withOpacity(0.5),
                            dropdownStyleData: const DropdownStyleData(
                              useRootNavigator: true,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xff9c9c9c),
                                  ),
                                  left: BorderSide(
                                    color: Color(0xff9c9c9c),
                                  ),
                                  right: BorderSide(
                                    color: Color(0xff9c9c9c),
                                  ),
                                ),
                              ),
                              elevation: 0,
                            ),
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.5),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 17.h,
                                horizontal: 10.w,
                              ),
                              hintStyle: GoogleFonts.barlow(
                                color: Colors.grey,
                                fontSize: 20.sp,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xff9c9c9c),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xff9c9c9c),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xff9c9c9c),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            style: GoogleFonts.barlow(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'CPF',
                                child: Text(
                                  'CPF',
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'CNPJ',
                                child: Text(
                                  'CNPJ',
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'EMAIL',
                                child: Text(
                                  'E-mail',
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'PHONE',
                                child: Text(
                                  'Telefone',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 55.h),
                          MPGTextField(
                            controller: _textController,
                            enabled: _selectedType != null,
                            isPassword: false,
                            prefixIcon: MPGAssetsPaths.of(context).logoPix,
                            labelText: 'Chave pix',
                            hintText: 'Digite sua chave pix',
                            errorText: _errorText,
                            focusNode: _focusNode,
                            inputFormatters: formatters[_selectedType],
                            textInputAction: TextInputAction.done,
                            keyboardType:
                                getInputType(_selectedType ?? 'EMAIL'),
                            onEditingComplete: () {
                              _focusNode.unfocus();
                              setState(() {
                                _errorText = validateInput(
                                  _selectedType ?? 'EMAIL',
                                  _textController.text,
                                );
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _errorText = validateInput(
                                  _selectedType ?? 'EMAIL',
                                  value,
                                );
                              });
                            },
                          ),
                          SizedBox(height: 55.h),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Cheque',
                              style: GoogleFonts.barlow(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              children: [
                                TextSpan(
                                  text: ' cuidadosamente ',
                                  style: GoogleFonts.barlow(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFFF7C00),
                                  ),
                                ),
                                TextSpan(
                                  text: 'sua chave pix para evitar erros.',
                                  style: GoogleFonts.barlow(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 55.h),
                          MPGButton(
                            gradient: _textController.text.isNotEmpty &&
                                    _errorText == null
                                ? MPGColors.of(context).mpgButtonColoredGradient
                                : MPGColors.of(context)
                                    .mpgButtonColoredGradientDisabled,
                            onPressed: _textController.text.isNotEmpty &&
                                    _errorText == null
                                ? () async {
                                    context.read<PaymentRegistrationBloc>().add(
                                          RegisterPix(
                                            pixKey: _textController.text,
                                            keyType: _selectedType!,
                                          ),
                                        );
                                  }
                                : null,
                            isLoading: _isLoading,
                            child: Text(
                              'Cadastrar',
                              style: _textController.text.isNotEmpty &&
                                      _errorText == null
                                  ? MPGTextStyles.of(context).mpgColoredButton
                                  : MPGTextStyles.of(context)
                                      .mpgColoredButtonDisabled,
                            ),
                          ),
                          SizedBox(height: 55.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
