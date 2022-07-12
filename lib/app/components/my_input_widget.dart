// ignore_for_file: depend_on_referenced_packages

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerenciador_licenca/app/theme/app_theme.dart';
import 'package:intl/intl.dart';

class MyInputWidget extends StatefulWidget {
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String hintText;
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormaters;
  final Function(String?)? onFieldSubmitted;
  final Function(String?) onChanged;
  final TextEditingController textEditingController;
  final String? campoVazio;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization textCapitalization;
  final Function()? onTap;
  final void Function()? onEditingComplete;
  final bool readOnly;
  final bool autoFocus;

  const MyInputWidget({
    Key? key,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength,
    this.inputFormaters,
    this.onFieldSubmitted,
    required this.onChanged,
    required this.textEditingController,
    this.campoVazio,
    required this.formKey,
    this.autovalidateMode,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onEditingComplete,
    this.readOnly = false,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  State<MyInputWidget> createState() => _MyInputWidgetState();
}

class _MyInputWidgetState extends State<MyInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
      child: TextFormField(
        autofocus: widget.autoFocus,
        readOnly: widget.readOnly,
        onEditingComplete: widget.onEditingComplete,
        textCapitalization: widget.textCapitalization,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.campoVazio ?? 'Campo em branco';
          }
          if (widget.label == 'CNPJ' && !CNPJValidator.isValid(value)) {
            return 'CNPJ inválido';
          }
          if ((widget.label == 'KM Final' || widget.label == 'KM Inicial')) {
            if (int.parse(value) <= 0) {
              return '${widget.label} não pode ser 0 ou negativo';
            }
          }
          if (widget.label == 'Telefone' &&
              widget.textEditingController.text.length < 15) {
            return 'Telefone inválido';
          }
          if ((widget.label == 'Litros' || widget.label == 'Valor Total') &&
              NumberFormat('###,###,###', 'pt_Br')
                      .parse(widget.textEditingController.text.trim())
                      .toDouble() ==
                  0.0) {
            return '${widget.label} não pode ser zero(0).';
          }
          return null;
        },
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        onChanged: (value) {
          widget.onChanged(value);
          setState(() {});
        },
        onTap: widget.onTap,
        obscureText: widget.obscureText,
        inputFormatters: widget.inputFormaters,
        onFieldSubmitted: widget.onFieldSubmitted,
        maxLength: widget.maxLength,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          counterText: '',
          hintText: widget.hintText,
          label: Text(widget.label),
          suffixIcon: widget.suffixIcon,
          filled: true,
          isDense: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey.shade700,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppTheme.colors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
