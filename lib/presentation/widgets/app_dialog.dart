import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/blocs/theme_bloc/theme_cubit.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';
import 'package:provider/src/provider.dart';

import 'button.dart';

class AppDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Widget? image;

  const AppDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: Sizes.dimen_32,
      backgroundColor:context.read<ThemeCubit>().state == Themes.dark ? AppColor.vulcan :Colors.white  ,
      insetPadding: EdgeInsets.all(
        Sizes.dimen_32.w.toDouble(),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Sizes.dimen_8.w.toDouble(),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: Sizes.dimen_4.h.toDouble(),
          right: Sizes.dimen_16.w.toDouble(),
          left: Sizes.dimen_16.w.toDouble(),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color:context.read<ThemeCubit>().state == Themes.dark ? AppColor.vulcan : Colors.white,
              blurRadius: Sizes.dimen_16,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.tr(context),
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.dimen_6.h.toDouble(),
              ),
              child: Text(
                description.tr(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            if (image != null) image!,
            Button(
              text: buttonText,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
