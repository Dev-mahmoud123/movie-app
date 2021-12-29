import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extension.dart';
import 'package:movie_app/common/extensions/string_extension.dart';
import 'package:movie_app/presentation/themes/theme_colors.dart';


class MovieTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const MovieTitleWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration:BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom:BorderSide(
              color: isSelected ? AppColor.royalBlue : Colors.transparent,
              width: Sizes.dimen_1.h.toDouble(),
            )
          )
        ),
        child: Text(
          title.tr(context),
          style: isSelected
              ? Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: AppColor.royalBlue,
                    fontWeight: FontWeight.w600,
                  )
              : Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
