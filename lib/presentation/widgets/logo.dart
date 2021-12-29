import 'package:flutter/material.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';
import 'package:provider/src/provider.dart';

class Logo extends StatelessWidget {
  final double height;

  const Logo({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/pngs/logo.png",
      key: const ValueKey("logo_image_key"),
      height: height.h,
      color: context.read<ThemeCubit>().state == Themes.dark ? Colors.white :AppColor.vulcan,
    );
  }
}
