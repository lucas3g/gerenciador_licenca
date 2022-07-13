import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

abstract class AppTextStyles {
  TextStyle get button;
  TextStyle get titleAppBar;
  TextStyle get titleSplash;
  TextStyle get titleSplashBlack;
  TextStyle get titleLogin;
  TextStyle get titleLoginBlack;
  TextStyle get titleLicenca;
  TextStyle get labelCliente;
  TextStyle get textCliente;
  TextStyle get textoSairApp;
  TextStyle get textoCadastroSucesso;
  TextStyle get textoTermo;
  TextStyle get textoRadioList;
  TextStyle get textoConfirmarData;
  TextStyle get textoCancelarData;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get button => GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.colors.button);

  @override
  TextStyle get titleAppBar => GoogleFonts.inter(
      fontSize: 20,
      color: AppTheme.colors.titleAppBar,
      fontWeight: FontWeight.w700);

  @override
  TextStyle get titleSplash => GoogleFonts.montserrat(
      fontSize: 60,
      color: AppTheme.colors.primary,
      fontWeight: FontWeight.w700);

  @override
  TextStyle get titleSplashBlack => GoogleFonts.montserrat(
      fontSize: 60, color: Colors.black, fontWeight: FontWeight.w700);

  @override
  TextStyle get titleLogin => GoogleFonts.montserrat(
        fontSize: 40,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleLoginBlack => GoogleFonts.montserrat(
        fontSize: 40,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleLicenca => GoogleFonts.montserrat(
      fontSize: 18,
      color: AppTheme.colors.titleLicenca,
      fontWeight: FontWeight.w700);

  @override
  TextStyle get labelCliente => GoogleFonts.montserrat(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700);

  @override
  TextStyle get textCliente =>
      GoogleFonts.montserrat(fontSize: 14, color: Colors.black);

  @override
  TextStyle get textoSairApp => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get textoCadastroSucesso => GoogleFonts.montserrat(
      fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700);

  @override
  TextStyle get textoTermo => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
      );

  @override
  TextStyle get textoRadioList => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      );

  @override
  TextStyle get textoCancelarData => GoogleFonts.montserrat(
        fontSize: 14,
        color: Colors.black,
      );

  @override
  TextStyle get textoConfirmarData => GoogleFonts.montserrat(
        fontSize: 14,
        color: AppTheme.colors.primary,
        fontWeight: FontWeight.w600,
      );
}
