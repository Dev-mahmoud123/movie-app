import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle? get _whiteHeadline6 =>
      _poppinsTextTheme.headline6?.copyWith(
        fontSize: Sizes.dimen_20.sp.toDouble(),
        color: Colors.white,
      );

  static TextStyle? get _whiteHeadline5 =>
      _poppinsTextTheme.headline5?.copyWith(
        fontSize: Sizes.dimen_24.sp.toDouble(),
        color: Colors.white,
      );

  static TextStyle? get whiteSubtitle1 => _poppinsTextTheme.subtitle1?.copyWith(
        color: Colors.grey,
      );

  static TextStyle? get whiteButton => _poppinsTextTheme.button?.copyWith(
        fontSize: Sizes.dimen_14.sp.toDouble(),
        color: Colors.white,
      );

  static TextStyle? get whiteBodyText2 => _poppinsTextTheme.subtitle1?.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_14.sp.toDouble(),
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle? get _vulcanHeadline6 =>
      _whiteHeadline6?.copyWith(color: AppColor.vulcan);

  static TextStyle? get _vulcanHeadline5 =>
      _whiteHeadline5?.copyWith(color: AppColor.vulcan);

  static TextStyle? get vulcanSubtitle1 =>
      whiteSubtitle1?.copyWith(color: AppColor.vulcan);

  static TextStyle? get vulcanBodyText2 =>
      whiteBodyText2?.copyWith(color: AppColor.vulcan);

  static getTextTheme() => TextTheme(
        headline5: _whiteHeadline5,
        headline6: _whiteHeadline6,
        subtitle1: whiteSubtitle1,
        bodyText2: whiteBodyText2,
        button: whiteButton,
      );

  static getLightTextTheme() => TextTheme(
    headline5: _vulcanHeadline5,
    headline6: _vulcanHeadline6,
    subtitle1: vulcanSubtitle1,
    bodyText2: vulcanBodyText2,
    button: whiteButton,
  );
}

extension ThemeTextExtension on TextTheme {
  TextStyle? get royalBlueSubtitle => subtitle1?.copyWith(
      color: AppColor.royalBlue, fontWeight: FontWeight.w600);

  TextStyle? get greySubtitle1 => subtitle1?.copyWith(
        color: Colors.grey,
      );

  TextStyle? get violetHeadLine6 => headline6?.copyWith(
        color: AppColor.violet,
      );

  TextStyle? get vulcanBodyText2 => bodyText2?.copyWith(
        color: AppColor.vulcan,
        fontWeight: FontWeight.w600,
      );

  TextStyle? get whiteBodyText2 => bodyText2?.copyWith(
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  TextStyle? get greyCaption => caption?.copyWith(
        color: Colors.grey,
      );
}
