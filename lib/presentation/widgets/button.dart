import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
      height: Sizes.dimen_24.h,
      decoration: BoxDecoration(
        gradient:
            const LinearGradient(colors: [AppColor.royalBlue, AppColor.violet]),
        borderRadius: BorderRadius.circular(Sizes.dimen_20.w),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text.tr(context),
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
